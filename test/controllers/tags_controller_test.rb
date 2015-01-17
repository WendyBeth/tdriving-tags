require "test_helper"

class TagsControllerTest < ActionController::TestCase
  test "user must be signed in to get new" do 
    get :new, video_id: videos(:valid_video)
    assert_response :redirect
  end

  test "a signed in user is redirected to new when attempting to post create invalid tag" do 
    sign_in users(:valid_user)

    assert_no_difference('Tag.count') do 
      post :create, { video_id: videos(:valid_video).id, tag: { name: '' } }
    end

    assert_template :new
  end

  test "non signed in user is redirected from create" do 
    assert_no_difference('Video.count') do 
      post :create, { video_id: videos(:valid_video).id, tag: { name: 'No' } }
    end

    assert_response :redirect
  end

  test "get show" do 
    get :show, id: tags(:valid_tag)
    assert_response :success
  end
end