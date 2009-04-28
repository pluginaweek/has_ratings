require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class RatingValueByDefaultTest < ActiveRecord::TestCase
  def setup
    @rating_value = RatingValue.new
  end
  
  def test_should_not_have_a_name
    assert @rating_value.name.blank?
  end
  
  def test_should_not_have_a_value
    assert_nil @rating_value.value
  end
end

class RatingValueTest < ActiveRecord::TestCase
  def test_should_be_valid_with_a_valid_set_of_attributes
    rating_value = new_rating_value
    assert rating_value.valid?
  end
  
  def test_should_require_a_name
    rating_value = new_rating_value(:name => nil)
    assert !rating_value.valid?
    assert rating_value.errors.invalid?(:name)
  end
  
  def test_should_require_a_value
    rating_value = new_rating_value(:value => nil)
    assert !rating_value.valid?
    assert rating_value.errors.invalid?(:value)
  end
  
  def test_should_convert_to_an_integer
    rating_value = new_rating_value(:value => 1)
    assert_equal 1, rating_value.to_i
  end
end

class RatingValueAfterBeingCreatedTest < ActiveRecord::TestCase
  def setup
    @rating_value = create_rating_value
  end
  
  def test_should_not_have_any_ratings
    assert @rating_value.ratings.empty?
  end
end

class RatingValueWithRatingsTest < ActiveRecord::TestCase
  def setup
    @rating_value = create_rating_value
    @poor_rating = create_rating(:value => @rating_value)
    @second_poor_rating = create_rating(:value => @rating_value)
  end
  
  def test_should_have_ratings
    assert_equal [@poor_rating, @second_poor_rating], @rating_value.ratings
  end
end
