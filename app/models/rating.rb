#
#
class Rating < ActiveRecord::Base
  validates_presence_of     :value
  validates_numericality_of :value
end