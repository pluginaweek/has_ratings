# Copyright (c) 2006 FortiusOne, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
# following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
# NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'acts_association_helper'

module PluginAWeek #:nodoc:
  module Acts #:nodoc:
    module Ratable #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        #
        def acts_as_ratable(*args, &extension)
          create_options = {
            :foreign_key_name => :ratable,
            :extend => RatingExtension,
            :actor => :rater
          }
          
          options, rating_class, association_id = create_acts_association(:rating, create_options, {}, *args, &extension)
          options.reverse_merge!(
            :rater_names => "#{association_id.to_s.singularize}rs"
          )
          
          if options[:in]
            rating_class.class_eval do
              validates_inclusion_of :value, :in => options[:in]
            end
          else
            Class.create('RatingValue', :superclass => ::RatingValue, :parent => self) do
              has_many  :ratings,
                          :class_name => rating_class.name,
                          :foreign_key => nil,
                          :conditions => 'value = #{rank}'
            end
            
            rating_class.class_eval do
              def name
                self.class::RatingValue.find_by_rank(value).name
              end
              
              validate do |model|
                model.errors.add 'value', 'is not included in the list' if self.class::RatingValue.find_by_rank(value).nil?
              end
            end
          end
          
          # Add domain-specific aliases if rating/raters is not being used
          if self.reflections[association_id].macro == :has_many && association_id != :ratings
            class_eval <<-end_eval
              class << self
                def find_all_by_#{association_id.to_s.singularize}(count, ratings, options = {})
                  find_all_by_rating(count, ratings, options, '#{association_id}')
                end
              end
              
              def #{options[:rater_names]}
                raters('#{association_id}')
              end
            end_eval
          end
          
          extend PluginAWeek::Acts::Ratable::ClassMethods
          include PluginAWeek::Acts::Ratable::InstanceMethods
        end
      end
      
      module RatingExtension
        #
        #
        def average
          inject(0) {|total, rating| total += rating.value} / size.to_f
        end
      end
      
      module ClassMethods
        # Finds objects with the ratings specified.  You can either specify a single
        # rating, or an array.  Each single rating or element in the array can be a
        # number or a range.  To find items with a minimum rating, use -1 as the end of the range.
        # Example:
        # find_all_by_rating(3..-1)  # Finds all with a rating of at least 3
        # 
        def find_all_by_rating(count, ratings, options = {}, association_id = 'ratings')
          ratings = send(association_id)
          
          conditions = Array(ratings).collect do |rating|
            if rating.kind_of?(Range)
              if rating.end > 0
                ["((#{association_id}.value >= ?) AND (#{association_id}.value <= ?))", rating.begin, rating.end]
              else
                ["(#{association_id}.value >= ?)", rating.begin]
              end
            else
              ["(#{association_id}.value = ?)", rating.to_i]
            end
          end
          
          condition_str = conditions.collect {|condition| condition.first}.join(' OR ')
          condition_args = conditions.collect {|condition| condition.slice(1..-1)}.flatten
          
          with_scope(:find => {:conditions => [condition_str, *condition_args], :include => association_id}) do
            find(:all, options)
          end      
        end
      end
      
      module InstanceMethods
        #
        #
        def raters(association_id = 'ratings')
          ratings = send(association_id)
          ratings.collect {|r| r.rater}
        end
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::Acts::Ratable
end