require 'test_helper'

class TextsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get texts_show_url
    assert_response :success
  end

  test "should get update" do
    get texts_update_url
    assert_response :success
  end

end
