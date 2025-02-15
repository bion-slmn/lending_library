require "test_helper"

class BorrowedBooksViewTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers

  def setup
    @user = User.create!(email_address: "user@example.com", password: "password")
    @book1 = Book.create!(title: "The Catcher in the Rye", author: "J.D. Salinger", isbn: "9780316769488", status: "borrowed")
    @book2 = Book.create!(title: "To Kill a Mockingbird", author: "Harper Lee", isbn: "9780061120084", status: "borrowed")
    @borrowing1 = Borrowing.create!(user: @user, book: @book1, created_at: Date.today, due_date: Date.today + 14.days)
    @borrowing2 = Borrowing.create!(user: @user, book: @book2, created_at: Date.today - 5.days, due_date: Date.today + 9.days)
  end

  test "displays the list of borrowed books when user is logged in" do
    sign_in_as(@user)
    get borrowings_path

    assert_response :success
    assert_select "h1", "My Borrowed Books"
    assert_select "h2", @book1.title
    assert_select "h2", @book2.title
    assert_select "p", text: /Borrowed on:/
    assert_select "p", text: /Return Due Date:/
    assert_select "form[action=?][method=?]", borrowing_path(@borrowing1), "post"
  end

  test "shows a message if no books are borrowed" do
    Borrowing.destroy_all
    sign_in_as(@user)
    get borrowings_path

    assert_response :success
    assert_select "p", "You haven't borrowed any books yet."
  end


  private

  def sign_in_as(user)
    post session_path, params: { email_address: user.email_address, password: "password" }
  end
end