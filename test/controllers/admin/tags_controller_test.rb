require "test_helper"

class Admin::TagsControllerTest < ActionController::TestCase
  test "get index" do 
    sign_in users(:admin_user)
    get :index
    assert_response :success
  end

  test "non-admin is redirected from index" do 
    get :index
    assert_response :redirect
  end

  test "admin can edit a tag" do 
    sign_in users(:admin_user)

    get :edit, id: tags(:pending_tag)
    assert_response :success
  end

  test "non-admin is redirected from edit" do 
    get :edit, id: tags(:pending_tag)
    assert_response :redirect
  end

  test "admin can get update" do 
    sign_in users(:admin_user)
    put :update, id: tags(:pending_tag), tag: { status: 'approved' }
    assert_equal 'approved', Tag.find(tags(:pending_tag)).status
    assert_equal flash[:notice], "Successfully updated tag"
  end

  test "non-admin is redirected from update" do 
    put :update, id: tags(:pending_tag), tag: { status: 'approved' }
    assert_response :redirect
    assert_not_equal 'approved', Tag.find(tags(:pending_tag)).status
  end

  test "an invalid tag will not be saved but will instead render edit" do 
    sign_in users(:admin_user)
    put :update, id: tags(:pending_tag), tag: { name: '' }
    assert_template :edit
  end

    test "admin can create a tag" do 
    sign_in users(:admin_user)

    assert_difference('Tag.count', 1) do
      post :create, tag: { name: 'new_tag', status: 'approved' }
    end

    assert_response :redirect
  end

  test "non-admin is redirected from create" do 
    assert_no_difference('Tag.count') do 
      post :create, tag: { name: 'new_tag', status: 'approved' }
    end

    assert_response :redirect
  end

  test "an invalid tag will not be saved but will instead render new" do 
    sign_in users(:admin_user)

    assert_no_difference('Tag.count') do 
      post :create, { video_id: videos(:valid_video), tag: { name: '' } }
    end

    assert_template :new
  end

end
