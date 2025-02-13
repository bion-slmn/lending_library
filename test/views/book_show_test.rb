require 'rails_helper'

RSpec.describe "Book Details", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:available_book) { Book.create(title: "The Great Gatsby", author: "F. Scott Fitzgerald", isbn: "9780743273565", status: "available") }
  let!(:unavailable_book) { Book.create(title: "1984", author: "George Orwell", isbn: "9780451524935", status: "borrowed") }

  context "when visiting the book details page" do
    it "displays the book's title, author, ISBN, and status" do
      visit book_path(available_book)

      expect(page).to have_content(available_book.title)
      expect(page).to have_content("Author: #{available_book.author}")
      expect(page).to have_content("ISBN: #{available_book.isbn}")
      expect(page).to have_content("Status: available")
    end
  end

  context "when the book is available" do
    it "shows a 'Borrow' button" do
      visit book_path(available_book)

      expect(page).to have_button("Borrow")
    end

    it "allows the user to click 'Borrow' and redirects to borrowings path" do
      visit book_path(available_book)
      
      click_button "Borrow"
      expect(current_path).to eq(book_borrowings_path(available_book))
    end
  end

  context "when the book is not available" do
    it "shows a disabled 'Not Available' button" do
      visit book_path(unavailable_book)

      expect(page).to have_button("Not Available", disabled: true)
    end
  end
end
