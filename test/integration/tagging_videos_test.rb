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
end