require 'test_helper'

class NstsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get nsts_index_url
    assert_response :success
  end

  test "should get create" do
    get nsts_create_url
    assert_response :success
  end

  test "should get destroy" do
    get nsts_destroy_url
    assert_response :success
  end

end
