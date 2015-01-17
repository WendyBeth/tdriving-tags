require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user saves" do 
    assert users(:valid_user).save
  end
end