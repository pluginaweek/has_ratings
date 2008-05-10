require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class VideoTest < Test::Unit::TestCase
  def setup
    @video = create_video
  end
  
  def test_should_not_have_any_ratings
    assert @video.ratings.empty?
  end
  
  def test_should_have_an_average_of_0
    assert_equal 0.0, @video.ratings.average
  end
end

class VideoWithRatingsTest < Test::Unit::TestCase
  def setup
    @video = create_video
    
    rater = create_user
    @poor_rating = create_rating(:rater => rater, :ratable => @video, :value => :poor)
    @average_rating = create_rating(:rater => rater, :ratable => @video, :value => :average)
  end
  
  def test_should_have_ratings
    assert_equal [@poor_rating, @average_rating], @video.ratings
  end
  
  def test_should_have_an_average
    assert_equal 2.0, @video.ratings.average
  end
end
