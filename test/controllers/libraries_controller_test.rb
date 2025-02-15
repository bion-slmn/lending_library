require "test_helper"

class LibrariesControllerTest < ActionDispatch::IntegrationTest
  test "should get show at root path" do
    get root_url
    assert_response :success
  end

  test "should get show at my_library path" do
    get my_library_url
    assert_response :success
  end
end
