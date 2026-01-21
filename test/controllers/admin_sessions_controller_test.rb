require "test_helper"

class AdminSessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_login_url
    assert_response :success
  end

  test "should post create" do
    post admin_login_url, params: { email: "naijeria@gmail.com" }
    assert_response :redirect
  end
end
