# test/models/book_test.rb
require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: "Test Book", author: "John Doe", isbn: "123-456-789")
  end

  test "associations" do
    assert_respond_to @book, :borrowings
    assert_respond_to @book, :users
  end

  test "validations" do
    @book.title = nil
    assert_not @book.valid?, "Book is valid without a title"

    @book.author = nil
    assert_not @book.valid?, "Book is valid without an author"

    @book.isbn = nil
    assert_not @book.valid?, "Book is valid without an ISBN"
  end

  test "isbn should be unique" do
    @book.save
    duplicate_book = @book.dup
    assert_not duplicate_book.valid?, "Book is valid with a duplicate ISBN"
  end

  test "instance method: status is initially nil" do
    assert_nil @book.status
  end
end
