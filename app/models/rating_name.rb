#
class RatingName < ActiveRecord::Base
  acts_as_enumerated    :conditions => 'type = #{type}'
  acts_as_list          :column => 'value', :scope => 'type = #{type}'
  
  validates_presence_of :name
end