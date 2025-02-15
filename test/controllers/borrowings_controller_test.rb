require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Load test user
    @book = books(:one) # Load test book
    @borrowing = borrowings(:one) # Load test borrowing
  end

  # ✅ Authenticated User Tests
  test "should get index when authenticated" do
    sign_in @user
    get borrowings_url
    assert_response :success
  end

  test "should redirect destroy when not authenticated" do
    delete borrowing_url(@borrowing)
    assert_response :redirect
    assert_redirected_to new_session_url
  end

  test "should redirect create when not authenticated" do
    post borrowings_url, params: { book_id: @book.id }
    assert_response :redirect
    assert_redirected_to new_session_url
  end

  test "should redirect index when not authenticated" do
    get borrowings_url
    assert_response :redirect
    assert_redirected_to new_session_url
  end

  private

  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
  end
end
