# The type of rating that can be assigned
class RatingValue < ActiveRecord::Base
  acts_as_enumeration
  
  column :value, :integer
  
  has_many  :ratings,
              :foreign_key => 'value_id'
  
  validates_presence_of :value
  
  def to_i #:nodoc:
    value
  end
  
  create :id => 1, :name => 'poor', :value => 1
  create :id => 2, :name => 'below_average', :value => 2
  create :id => 3, :name => 'average', :value => 3
  create :id => 4, :name => 'above_average', :value => 4
  create :id => 5, :name => 'excellent', :value => 5
end
