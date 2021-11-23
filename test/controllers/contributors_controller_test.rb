require 'test_helper'

class ContributorsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get contributors_new_url
    assert_response :success
  end

  test "should get create" do
    get contributors_create_url
    assert_response :success
  end

end
