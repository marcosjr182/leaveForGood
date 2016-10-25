require 'test_helper'

class AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_index_url
    assert_response :success
  end

  test "should get organizations" do
    get admin_organizations_url
    assert_response :success
  end

  test "should get donations" do
    get admin_donations_url
    assert_response :success
  end

  test "should get users" do
    get admin_users_url
    assert_response :success
  end

end
