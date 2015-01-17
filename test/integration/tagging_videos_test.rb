require "test_helper"

class TaggingVideosTest < ActionDispatch::IntegrationTest
  test "as a signed in user, I can create a new tag" do 
    sign_in_user
    visit new_video_tag_path(videos(:valid_video))

    fill_in 'Tag', with: 'ruby'

    assert_difference('Tag.count', 1) do 
      click_button 'Save'
    end

    assert_equal Tag.last.name, 'ruby'
  end
end