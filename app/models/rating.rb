# $Id$
# $LastChangedDate$
# $LastChangedRevision$
#
# Copyright (c) 2006 FortiusOne, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
# following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
# NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Ratings ActiveRecord class to deal with ratings
#
# This needs to be a table with the following columns:
#
# rating :integer
class Rating < ActiveRecord::Base
  belongs_to                :ratable,
                              :polymorphic => true
  belongs_to                :rater,
                              :class_name => 'User',
                              :foreign_key => 'rater_id'
  
  validates_presence_of     :value
  
  validates_numericality_of :value
  
  RATING_NAMES =
  [
    'Poor',
    'Below Average',
    'Average',
    'Above Average',
    'Excellent'
  ]
  
  class << self
    def human_value(value)
      RATING_NAMES[value-1]
    end
  end
  
  #
  #
  def human_value
    self.class.human_value(value) if value && (1..5).include?(value)
  end
end