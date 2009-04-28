require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RatingByDefaultTest < ActiveRecord::TestCase
  def setup
    @rating = Rating.new
  end
  
  def test_should_not_have_a_ratable_association
    assert_nil @rating.ratable_id
  end
  
  def test_should_not_have_a_ratable_type
    assert_nil @rating.ratable_type
  end
  
  def test_should_not_have_a_rater
    assert_nil @rating.rater_id
  end
  
  def test_should_not_have_a_rater_type
    assert_nil @rating.rater_type
  end
  
  def test_should_not_have_a_value
    assert_nil @rating.value_id
  end
end

class RatingTest < ActiveRecord::TestCase
  def test_should_be_valid_with_a_valid_set_of_attributes
    rating = new_rating
    assert rating.valid?
  end
  
  def test_should_require_a_ratable_association
    rating = new_rating(:ratable => nil)
    assert !rating.valid?
    assert rating.errors.invalid?(:ratable_id)
  end
  
  def test_should_require_a_ratable_type
    rating = new_rating(:ratable => nil)
    assert !rating.valid?
    assert rating.errors.invalid?(:ratable_type)
  end
  
  def test_should_require_a_rater
    rating = new_rating(:rater => nil)
    assert !rating.valid?
    assert rating.errors.invalid?(:rater_id)
  end
  
  def test_should_require_a_rater_type
    rating = new_rating(:rater => nil)
    assert !rating.valid?
    assert rating.errors.invalid?(:rater_type)
  end
  
  def test_should_require_a_value
    rating = new_rating(:value => nil)
    assert !rating.valid?
    assert rating.errors.invalid?(:value_id)
  end
end

class RatingAfterBeingCreatedTest < ActiveRecord::TestCase
  def setup
    @rating = create_rating
  end
  
  def test_should_have_a_value
    assert_not_nil @rating.value
  end
  
  def test_should_have_a_ratable_association
    assert_not_nil @rating.ratable
  end
  
  def test_should_have_a_rater
    assert_not_nil @rating.rater
  end
end
