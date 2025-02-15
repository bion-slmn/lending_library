require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @book = books(:one)
  end


  test "should get index when authenticated" do
    sign_in @user
    get books_url
    assert_response :success
  end

  test "should get show when authenticated" do
    sign_in @user
    get book_url(@book)
    assert_response :success
  end

  # ❌ Test for non-authenticated user
  test "should redirect index when not authenticated" do
    get books_url
    assert_response :redirect
    assert_redirected_to new_session_url # Ensure redirection to login
  end

  test "should redirect show when not authenticated" do
    get book_url(@book)
    assert_response :redirect
    assert_redirected_to new_session_url
  end

  private

  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
