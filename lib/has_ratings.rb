module PluginAWeek #:nodoc:
  # Adds a generic implementation for dealing with ratings
  module HasRatings
    def self.included(base) #:nodoc:
      base.class_eval do
        extend PluginAWeek::HasRatings::MacroMethods
      end
    end
    
    module MacroMethods
      # Creates the following association:
      # * +ratings+ - All ratings associated with the current record.
      def has_ratings
        has_many  :ratings,
                    :as => :ratable,
                    :extend => RatingExtension
      end
    end
    
    module RatingExtension
      # Gets the average of all the ratings
      def average
        empty? ? 0.0 : inject(0) {|total, rating| total += rating.value.to_i} / size.to_f
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  include PluginAWeek::HasRatings
end
