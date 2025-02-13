require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = Book.create!(title: "Test Book", author: "Test Author", isbn: "123456789")
  end

  test "should get index" do
    get books_url
    assert_response :success
    assert_select "h1", "Books"  # Assuming there's a heading with "Books" on the index page
    assert_select ".book", minimum: 1  # Assuming books are rendered with a class "book"
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
    assert_select "h1", @book.title  # Assuming the book title is rendered as a heading on the show page
  end

  test "should return 404 for non-existent book" do
    assert_raises(ActiveRecord::RecordNotFound) do
      get book_url(-1)
    end
  end
end
