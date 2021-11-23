require 'test_helper'

class ModificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get modifications_index_url
    assert_response :success
  end

  test "should get show" do
    get modifications_show_url
    assert_response :success
  end

  test "should get create" do
    get modifications_create_url
    assert_response :success
  end

  test "should get validate" do
    get modifications_validate_url
    assert_response :success
  end

  test "should get deny" do
    get modifications_deny_url
    assert_response :success
  end

end
