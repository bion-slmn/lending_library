require "test_helper"

class BorrowingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email_address: "test@example.com", password_digest: "password")
    @book = Book.create!(title: "Sample Book", author: "Author", isbn: "123456789", status: "available")
    @borrowing = Borrowing.create!(user: @user, book: @book, due_date: 2.weeks.from_now)

    # Simulate user login
    Current.user = @user
  end

  test "should get index" do
    get borrowings_url
    assert_response :success
    assert_select "h1", "Borrowed Books"  # Assuming your index page has this header
  end

  test "should create borrowing if book is available" do
    assert_difference("Borrowing.count") do
      post borrowings_url, params: { book_id: @book.id }
    end
    assert_redirected_to book_path(@book)
    assert_equal "borrowed", @book.reload.status
    assert_equal "You have successfully borrowed the book.", flash[:notice]
  end

  test "should not create borrowing if book is not available" do
    @book.update(status: "borrowed")
    assert_no_difference("Borrowing.count") do
      post borrowings_url, params: { book_id: @book.id }
    end
    assert_redirected_to book_path(@book)
    assert_equal "Book is not available.", flash[:alert]
  end

  test "should destroy borrowing and update book status" do
    assert_difference("Borrowing.count", -1) do
      delete borrowing_url(@borrowing)
    end
    assert_redirected_to borrowings_path
    assert_equal "available", @book.reload.status
    assert_equal "Book returned successfully.", flash[:notice]
  end
end
