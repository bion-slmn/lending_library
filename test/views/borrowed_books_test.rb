require 'rails_helper'

RSpec.describe "My Borrowed Books", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { User.create(email: "user@example.com", password: "password") }
  let!(:book1) { Book.create(title: "The Catcher in the Rye", author: "J.D. Salinger", status: "borrowed") }
  let!(:book2) { Book.create(title: "To Kill a Mockingbird", author: "Harper Lee", status: "borrowed") }
  let!(:borrowing1) { Borrowing.create(user: user, book: book1, created_at: Date.today, due_date: Date.today + 14.days) }
  let!(:borrowing2) { Borrowing.create(user: user, book: book2, created_at: Date.today - 5.days, due_date: Date.today + 9.days) }

  context "when the user is logged in" do
    before do
      login_as(user)  # Assuming you have a helper method for logging in users
    end

    it "displays the list of borrowed books" do
      visit borrowed_books_path

      expect(page).to have_content("My Borrowed Books")
      expect(page).to have_content(book1.title)
      expect(page).to have_content("Author: #{book1.author}")
      expect(page).to have_content("Borrowed on: #{borrowing1.created_at.strftime('%B %d, %Y')}")
      expect(page).to have_content("Return Due Date: #{borrowing1.due_date.strftime('%B %d, %Y')}")
      expect(page).to have_button("Return Book")
    end

    it "allows the user to return a book" do
      visit borrowed_books_path

      within first(".bg-gray-100") do
        click_button "Return Book"
      end

      expect(current_path).to eq(borrowed_books_path)
      expect(page).to have_content("Book returned successfully").or have_no_content(book1.title)
    end

    it "shows a message if no books are borrowed" do
      Borrowing.destroy_all
      visit borrowed_books_path

      expect(page).to have_content("You haven't borrowed any books yet.")
    end
  end

  context "when the user is not logged in" do
    it "prompts the user to log in" do
      visit borrowed_books_path

      expect(page).to have_content("Please log in to see your borrowed books.")
      expect(page).to have_link("log in", href: new_session_path)
    end
  end
end
