require 'acts_association_helper'
require 'class_associations'

module PluginAWeek #:nodoc:
  module Acts #:nodoc:
    module Ratable #:nodoc:
      def self.included(base) #:nodoc:
        base.extend(MacroMethods)
      end
      
      module MacroMethods
        # 
        def acts_as_ratable(*args, &extension)
          default_options = {
            :as => :ratable,
            :extend => RatingExtension,
            :create_inner_class => true
          }
          association_id, rating_class, options = create_acts_association(:rating, default_options, *args, &extension)
          
          class << self
            has_many :rating_names
          end
          
          # Add validations for the numerical value range
          model = self
          rating_class.class_eval do
            if options[:in]
              validates_inclusion_of  :value,
                                        :in => options[:in]
            else
              validates_inclusion_of  :value,
                                        :in => model.rating_names,
                                        :evaluate => Proc.new {|rating_name| rating_name.value},
                                        :if => :ratable_id?
            end
          end
          
          # Add domain-specific aliases if rating/raters is not being used
          if options[:counter] == :many && association_id != :ratings
            class_eval <<-end_eval
              class << self
                def find_all_by_#{association_id.to_s.singularize}(count, ratings, options = {})
                  find_all_by_rating(count, ratings, options, '#{association_id}')
                end
              end
            end_eval
          end
          
          extend PluginAWeek::Acts::Ratable::ClassMethods
          include PluginAWeek::Acts::Ratable::InstanceMethods
        end
        
        def acts_as_rater(*args, &extension)
          default_options = {
            :as => :rater
          }
          create_acts_association(:rating, default_options, *args, &extension)
        end
      end
      
      module RatingExtension
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