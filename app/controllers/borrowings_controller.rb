class BorrowingsController < ApplicationController
  before_action :set_borrowing, only: :destroy
  
  def index
    @borrowed_books = Borrowing.includes(:book).where(user: Current.user)
  end
  

  def create
    book = Book.find(params[:book_id])
  
    if book.status == "available"
      borrowing = Borrowing.create(user: Current.user, book: book, due_date: 2.weeks.from_now)
      
      if borrowing.persisted?  # Check if it was successfully saved
        book.update(status: "borrowed")
        redirect_to book_path(book), notice: "You have successfully borrowed the book."
      else
        redirect_to book_path(book), alert: "Failed to borrow the book. Please try again."
      end
    else
      redirect_to book_path(book), alert: "Book is not available."
    end
  end
  

  def destroy
    @borrowing.book.update(status: "available")  
    @borrowing.destroy  
    redirect_to borrowings_path, notice: "Book returned successfully."
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end
end
