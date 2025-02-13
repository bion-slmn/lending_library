require "test_helper"

class LibrariesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get library_url(id: 1)  # Assuming an ID of 1 for the library
    assert_response :success
  end

  test "should render show template" do
    get library_url(id: 1)
    assert_template :show
  end
end
