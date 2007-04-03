# 
class Rating < ActiveRecord::Base
  validates_presence_of     :ratable_id,
                            :ratable_type,
                            :rater_id,
                            :rater_type,
                            :value
  validates_numericality_of :value
  
  # 
  def name
    self.class::RatingName.find_by_owner_type_and_value(ratable_type, value).name
  end
end