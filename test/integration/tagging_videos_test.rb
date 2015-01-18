require "test_helper"

class TaggingVideosTest < ActionDispatch::IntegrationTest
  before :each do 
    DatabaseCleaner.start
  end

  after :each do 
    if page.has_content?('Sign out')
      click_link 'Sign out'
    end

    DatabaseCleaner.clean 
  end
  
  test "as a signed in user, I can create a new tag" do 
    sign_in_user
    visit new_video_tag_path(videos(:valid_video))

    fill_in 'Name', with: 'ruby'

    assert_difference('Tag.count', 1) do 
      click_button 'Save'
    end

    assert_equal Tag.last.name, 'ruby'
  end

  test "a tag's videos show up on that tag's show page" do 
    sign_in_user
    visit new_video_tag_path(videos(:valid_video))

    fill_in 'Name', with: 'taggy'
    click_button 'Save'

    visit tag_path(Tag.last)

    assert page.has_content?("#{videos(:valid_video).title}"), "page does not have video title"
  end

  test "as an administrator, no tags are available if I haven't approved any" do 
    sign_in_admin
    Tag.all.each { |tag| tag.update_attributes(status: "pending") }
    
    visit tags_path

    assert page.has_content?("No tags are currently available."), "no content: 'No tags are currently available.'"
  end

  test "tags show up on the tags index page only if they are approved" do 
    visit tags_path
    assert page.has_content?("approved_tag"), "approved_tag not present"
    assert_not page.has_content?("rejected_tag"), "rejected_tag present"
    assert_not page.has_content?("pending_tag"), "pending_tag present"
  end

  test "as an admin, I can see all tags in a tags admin panel" do 
    sign_in_admin
    visit admin_tags_path

    assert page.has_content?("pending_tag")
    assert page.has_content?("rejected_tag")
    assert page.has_content?("approved_tag")
  end

  test "as an admin, I can add tags to a video when I create a new video" do 
    sign_in_admin
    visit new_video_path

    fill_in 'Title', with: "A Video With Tags"
    fill_in 'All tags', with: "ruby, tdd, rails, minitest"

    assert_difference('Video.count', 1) do 
      click_button 'Save'
    end

    tags = Video.last.tags.map(&:name)

    assert tags.include?("ruby"), "tags do not include 'ruby'"
    assert tags.include?("tdd"), "tags do not include 'tdd'"
    assert tags.include?("rails"), "tags do not include 'rails'"
    assert tags.include?("minitest"), "tags do not include 'minitest'"
  end

  test "as a signed in user, I can add an existing tag to a video" do 
    sign_in_user
    visit new_video_tag_path(videos(:valid_video))

    fill_in 'Name', with: 'approved_tag'

    assert_no_difference('Tag.count') do 
      click_button 'Save'
    end

    assert videos(:valid_video).tags.include?(tags(:approved_tag)), "approved tag not added to valid video"
    assert current_path == video_path(videos(:valid_video)), "current path is not valid_video path"
  end
end