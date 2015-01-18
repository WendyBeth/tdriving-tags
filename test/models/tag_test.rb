require "test_helper"

class TagTest < ActiveSupport::TestCase
  before do 
    @tag = tags(:valid_tag)
    @pending_tag = tags(:pending_tag)
    @approved_tag = tags(:approved_tag)
    @rejected_tag = tags(:rejected_tag)
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

  test "responds to status" do 
    assert_respond_to @tag, :status
  end

  test "default status is pending" do 
    tag = Tag.create!(name: 'always')
    assert_equal tag.status, 'pending'
  end

  test "scope 'pending' returns tags with status: 'pending'" do 
    pending_tags = Tag.pending 

    assert pending_tags.include?(@pending_tag)
    assert_not pending_tags.include?(@rejected_tag)
    assert_not pending_tags.include?(@approved_tag)
  end

  test "scope 'approved' returns tags with status: 'approved'" do 
    approved_tags = Tag.approved 

    assert approved_tags.include?(@approved_tag)
    assert_not approved_tags.include?(@rejected_tag)
    assert_not approved_tags.include?(@pending_tag)
  end

  test "scope 'rejected' returns tags with status: 'rejected'" do 
    rejected_tags = Tag.rejected 

    assert rejected_tags.include?(@rejected_tag)
    assert_not rejected_tags.include?(@approved_tag)
    assert_not rejected_tags.include?(@pending_tag)
  end

  test "a tag name must be unique" do 
    repeat_tag = Tag.new(name: 'approved_tag')
    assert_not repeat_tag.save
  end
end
