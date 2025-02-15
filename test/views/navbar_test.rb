require "test_helper"

class NavigationBarTest < ActionDispatch::SystemTestCase
  driven_by :rack_test # Use :selenium if JavaScript is required

  test "displays 'Log In' and 'Register' links when user is not logged in" do
    visit root_path
    assert_link "Log In", href: new_session_path
    assert_link "Register", href: new_user_path
    assert_no_text "Logged in as"
    assert_no_link "Logout"
  end


   

  test "displays navigation links for 'My Library', 'All Books', and 'Borrowed Books'" do
    visit root_path
    assert_link "My Library", href: my_library_path
    assert_link "All Books", href: books_path
    assert_link "Borrowed Books", href: borrowings_path
  end

  private

  def sign_in(user)
    post session_url, params: { email_address: user.email_address, password: "password" }
    follow_redirect! # Ensure we're on the right page after login
  end
end
