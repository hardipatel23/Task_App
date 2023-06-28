require "test_helper"

class UserShowControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_show_show_url
    assert_response :success
  end
end
