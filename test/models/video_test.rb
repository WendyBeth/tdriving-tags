require "test_helper"

class VideoTest < ActiveSupport::TestCase
  before do 
    @video = videos(:valid_video)
  end

  test "valid video saves" do 
    assert videos(:valid_video).save
  end

  test "responds to title" do 
    assert_respond_to videos(:valid_video), :title
  end

  test "responds to abstract" do 
    assert_respond_to videos(:valid_video), :abstract
  end

  test "responds to youtube_code" do 
    assert_respond_to videos(:valid_video), :youtube_code
  end

  test "must have title" do 
    invalid_video = Video.new(abstract: "I'm not valid", youtube_code: "still not valid")

    assert_not invalid_video.save
  end

  test "title must be unique" do 
    i_am_valid = Video.create!(title: "Valid")
    i_am_not = Video.new(title: "Valid")

    assert_not i_am_not.save
  end

  test "responds to taggings" do 
    assert_respond_to @video, :taggings
  end

  test "responds to tags" do 
    assert_respond_to @video, :tags
  end
end