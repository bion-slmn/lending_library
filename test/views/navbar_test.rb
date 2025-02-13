require 'rails_helper'

RSpec.describe "Navigation Bar", type: :system do
  before do
    driven_by(:rack_test) # Use :rack_test for non-JS tests, switch to :selenium for JS.
  end

  context "when user is not logged in" do
    it "displays 'Log In' and 'Register' links" do
      visit root_path
      expect(page).to have_link("Log In", href: new_session_path)
      expect(page).to have_link("Register", href: new_user_path)
      expect(page).not_to have_content("Logged in as")
      expect(page).not_to have_link("Logout")
    end
  end

  context "when user is logged in" do
    let(:user) { create(:user, email_address: "user@example.com") }
    let(:session) { create(:session, user: user) }

    before do
      # Simulate user login
      allow(Current).to receive(:user).and_return(user)
      allow(Current).to receive(:session).and_return(session)
    end

    it "displays the user's email and 'Logout' link" do
      visit root_path
      expect(page).to have_content("Logged in as user@example.com")
      expect(page).to have_link("Logout", href: session_path(session.id))
      expect(page).not_to have_link("Log In")
      expect(page).not_to have_link("Register")
    end
  end

  context "navigation links" do
    it "displays 'My Library', 'All Books', and 'Borrowed Books' links" do
      visit root_path
      expect(page).to have_link("My Library", href: my_library_path)
      expect(page).to have_link("All Books", href: books_path)
      expect(page).to have_link("Borrowed Books", href: borrowings_path)
    end
  end
end
