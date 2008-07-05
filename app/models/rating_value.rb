# The type of rating that can be assigned.  This is an enumeration which consists
# of a pre-determined set of possible rating values.  Each value has the following
# attributes:
# * +name+ - The actual name to refer to the value as
# * +value+ - The numeric value of the rating (higher is better)
# 
# Values should normally be referred to by name.  For example,
# 
#   RatingValue['poor']       # => #<RatingValue id: 1, name: "poor", value: 1>
#   RatingValue['excellent']  # => #<RatingValue id: 5, name: "excellent", value: 5>
class RatingValue < ActiveRecord::Base
  acts_as_enumeration
  
  column :value, :integer
  
  has_many  :ratings,
              :foreign_key => 'value_id'
  
  validates_presence_of :value
  
  # Returns the integer value of the rating
  def to_i
    value
  end
  
  # Represent the possible values for ratings
  create :id => 1, :name => 'poor', :value => 1
  create :id => 2, :name => 'below_average', :value => 2
  create :id => 3, :name => 'average', :value => 3
  create :id => 4, :name => 'above_average', :value => 4
  create :id => 5, :name => 'excellent', :value => 5
end
