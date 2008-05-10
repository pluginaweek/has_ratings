# A rating of a particular record
class Rating < ActiveRecord::Base
  belongs_to  :value,
                :class_name => 'RatingValue'
  belongs_to  :ratable,
                :polymorphic => true
  belongs_to  :rater,
                :polymorphic => true
  
  validates_presence_of :ratable_id,
                        :ratable_type,
                        :rater_id,
                        :rater_type,
                        :value_id
end
