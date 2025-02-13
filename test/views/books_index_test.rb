require 'rails_helper'

RSpec.describe "Books Index", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:book1) { Book.create(title: "The Great Gatsby", author: "F. Scott Fitzgerald") }
  let!(:book2) { Book.create(title: "1984", author: "George Orwell") }
  let!(:book3) { Book.create(title: "To Kill a Mockingbird", author: "Harper Lee") }

  context "when visiting the books index page" do
    it "displays a list of books with their titles and authors" do
      visit books_path

      expect(page).to have_content("All Books")
      expect(page).to have_link(book1.title, href: book_path(book1))
      expect(page).to have_link(book2.title, href: book_path(book2))
      expect(page).to have_link(book3.title, href: book_path(book3))

      within(".grid") do
        expect(page).to have_content("Title: #{book1.title}")
        expect(page).to have_content("Author: #{book1.author}")
        expect(page).to have_content("Title: #{book2.title}")
        expect(page).to have_content("Author: #{book2.author}")
        expect(page).to have_content("Title: #{book3.title}")
        expect(page).to have_content("Author: #{book3.author}")
      end
    end
  end

  context "when a book link is clicked" do
    it "navigates to the book's detail page" do
      visit books_path
      click_link book1.title

      expect(current_path).to eq(book_path(book1))
      expect(page).to have_content(book1.title)
      expect(page).to have_content(book1.author)
    end
  end

  context "when no books are available" do
    it "displays a message indicating no books are available" do
      Book.delete_all
      visit books_path

      expect(page).to have_content("All Books")
      expect(page).to have_content("No books available")
    end
  end
end
