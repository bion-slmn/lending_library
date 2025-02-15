require "test_helper"

class BookShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(email_address: "user@example.com", password: "password")
    @book = Book.create!(title: "The Catcher in the Rye", author: "J.D. Salinger", isbn: "9780316769488", status: "available")
  end

  test "redirects to login page if user is not signed in" do
    get book_path(@book)
    assert_response :redirect
    assert_redirected_to new_session_path
  end

  test "allows signed-in user to view book details" do
    sign_in_as(@user)
    get book_path(@book)
    assert_response :success
    assert_select "h2", @book.title
    assert_select "p", text: /Author: #{@book.author}/
    assert_select "p", text: /ISBN: #{@book.isbn}/
    assert_select "p", text: /Status: #{@book.status}/
  end

  private

  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
    follow_redirect!
  end
end
