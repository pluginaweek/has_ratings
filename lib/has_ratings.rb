# Adds a generic implementation for dealing with ratings
module HasRatings
  module MacroMethods
    # Creates the following association:
    # * +ratings+ - All ratings associated with the current record
    # 
    # This association assumes that it is being created on the +ratable+
    # model.  If you want to create an association on the +rater+ model,
    # it will have to be created manually like so:
    # 
    #   has_many :ratings, :as => :rater
    # 
    # == Creating new ratings
    # 
    # Creating new ratings is very similar to creating other records within
    # a has_many association:
    # 
    #   user = User.find(1)
    #   
    #   video = Video.find_by_name('The Shawshank Redemption')
    #   video.ratings.create(:rater => user, :value => 'excellent')
    #   video.ratings.average   # => 5
    def has_ratings
      has_many :ratings, :as => :ratable, :extend => RatingExtension
    end
  end
  
  module RatingExtension
    # Gets the average of all the ratings, up to a precision of 2 decimals.
    # If no ratings have ever been made, then 0.0 is returned.
    # 
    # For example,
    # 
    #   video = Video.find_by_name('The Shawshank Redemption')
    #   video.ratings.map {|rating| rating.value.to_i}    # => [4, 5, 5]
    #   video.ratings.average                             # => 4.67
    def average
      if empty?
        0.0
      else
        average = inject(0) {|total, rating| total += rating.value.to_i} / size.to_f
        average.round(2)
      end
    end
  end
end

ActiveRecord::Base.class_eval do
  extend HasRatings::MacroMethods
end
