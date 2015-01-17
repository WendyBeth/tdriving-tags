require "test_helper"

class TaggingTest < ActiveSupport::TestCase
  before do 
    @tagging = taggings(:valid_tagging)
  end

  test "can create a tagging" do 
    tagging = Tagging.new(video_id: 1, tag_id: 2)
    assert tagging.save
  end

  test "responds to video" do 
    assert_respond_to @tagging, :video
  end
end
