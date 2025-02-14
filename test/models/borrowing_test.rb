# test/models/borrowing_test.rb
require "test_helper"

class BorrowingTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email_address: "user@example.com", password: "password123")
    @book = Book.create(title: "Sample Book", author: "John Doe", isbn: "123-456-789")
    @borrowing = Borrowing.new(user: @user, book: @book, due_date: Date.today + 7.days)
  end

  test "associations" do
    assert_respond_to @borrowing, :user
    assert_respond_to @borrowing, :book
  end

  test "is valid with valid attributes" do
    assert @borrowing.valid?, "Borrowing should be valid with valid attributes"
  end

  test "is not valid without a due date" do
    @borrowing.due_date = nil
    assert_not @borrowing.valid?, "Borrowing should not be valid without a due date"
  end
end
