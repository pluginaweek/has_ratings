#
class Rating < ActiveRecord::Base
  validates_presence_of     :ratable_id,
                            :rater_id,
                            :rater_type,
                            :value
  validates_numericality_of :value
  
  def name
    self.class::RatingName.find_by_value(value).name
  end
end