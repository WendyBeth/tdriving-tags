require "test_helper"

class TagsControllerTest < ActionController::TestCase
  test "user must be signed in to get new" do 
    get :new, video_id: videos(:valid_video)
    assert_response :redirect
  end
end
