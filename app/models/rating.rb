# A rating of a particular record.  Ratings consist of three components:
# * +rater+ - The person who is actually creating the rating
# * +ratable+ - The object which is being rated
# * +value+ - The value being assigned to the rating
# 
# *Note* that the value does not represent the actual integer value, but rather
# the enumeration record in the RatingValue model.
class Rating < ActiveRecord::Base
  belongs_to :rater, :polymorphic => true
  belongs_to :ratable, :polymorphic => true
  belongs_to :value, :class_name => 'RatingValue'
  
  validates_presence_of :rater_id, :rater_type, :ratable_id, :ratable_type,
                        :value_id
end
