#
#
class RatingValue < ActiveRecord::Base
  acts_as_list          :column => 'rank', :scope => 'type = #{type}'
  
  validates_presence_of :name
end