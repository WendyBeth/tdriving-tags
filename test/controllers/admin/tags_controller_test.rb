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
end
