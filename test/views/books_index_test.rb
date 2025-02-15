require "test_helper"

class BooksIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(email_address: "user@example.com", password: "password")

    @book1 = Book.create!(title: "The Catcher in the Rye", author: "J.D. Salinger", isbn: "9780316769488")
    @book2 = Book.create!(title: "To Kill a Mockingbird", author: "Harper Lee", isbn: "9780061120084")
  end

  test "displays all books with titles and authors" do
    sign_in_as(@user)  # Sign in before making the request
    get books_path
    assert_response :success

    assert_select "h1", "All Books"

    assert_select "p", text: /Title: #{@book1.title}/
    assert_select "p", text: /Author: #{@book1.author}/
    assert_select "p", text: /Title: #{@book2.title}/
    assert_select "p", text: /Author: #{@book2.author}/

    assert_select "a[href=?]", book_path(@book1)
    assert_select "a[href=?]", book_path(@book2)
  end

  private

  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
    follow_redirect!
  end
end
