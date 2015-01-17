require "test_helper"

class VideosControllerTest < ActionController::TestCase
  before do 
    @valid_params = { 
                      title: 'Video Title',
                      abstract: 'Video abstract.',
                      youtube_code: 'Gx12345'
                    }
  end

  test "get index" do 
    get :index
    assert_response :success
  end

  test "get show" do 
    get :show, id: videos(:valid_video)
    assert_response :success
  end

  test "admin can get new" do 
    sign_in users(:admin_user)
    get :new
    assert_response :success
  end

  test "non-admin cannot get new" do 
    get :new
    assert_response :redirect
  end

  test "admin can post create" do 
    sign_in users(:admin_user)

    assert_difference('Video.count', 1) do 
      post :create, { video: @valid_params }
    end

    assert_response :redirect
  end

  test "an admin is redirected to new when attempting to post create invalid video" do 
    sign_in users(:admin_user)

    assert_no_difference('Video.count') do 
      post :create, { video: { title: '' } }
    end

    assert_template :new
  end

  test "non-admin is redirected from create" do 
    assert_no_difference('Video.count') do 
      post :create, { video: @valid_params }
    end
    
    assert_response :redirect
  end

  test "admin can get edit" do 
    sign_in users(:admin_user)
    get :edit, id: videos(:valid_video)
    assert_response :success
  end

  test "non-admin is redirected from edit" do 
    get :edit, id: videos(:valid_video)
    assert_response :redirect
  end

  test "admin can put update" do 
    sign_in users(:admin_user)

    put :update, id: videos(:valid_video), video: { title: 'New Title' }
    assert_response :redirect
    assert_equal 'New Title', Video.find(videos(:valid_video)).title
  end

  test "an admin is redirected to edit when attempting to put update invalid video" do 
    sign_in users(:admin_user)

    put :update, id: videos(:valid_video), video: { title: '' }
    assert_template :edit
  end

  test "non-admin is redirected from update" do 
    put :update, id: videos(:valid_video), video: { title: 'New Title' }
    assert_response :redirect
    assert_not_equal 'New Title', Video.find(videos(:valid_video)).title
  end

  test "admin can delete destroy" do 
    sign_in users(:admin_user)

    assert_difference('Video.count', -1) do 
      delete :destroy, id: videos(:valid_video)
    end

    assert_response :redirect
  end

  test "non-admin is redirected from delete" do 
    assert_no_difference('Video.count') do 
      delete :destroy, id: videos(:valid_video)
    end

    assert_response :redirect
  end
end