require "test_helper"

class TagTest < ActiveSupport::TestCase
  before do 
    @tag = tags(:valid_tag)
  end

  test "can create a tag" do 
    tag = Tag.new(name: 'rails')
    assert tag.save
  end

  test "responds to taggings" do 
    assert_respond_to @tag, :taggings
  end

  test "responds to videos" do 
    assert_respond_to @tag, :videos
  end

  test "must have a name" do 
    tag = Tag.new
    assert_not tag.save
  end
end
