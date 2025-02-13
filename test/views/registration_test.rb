require 'rails_helper'

RSpec.describe "User Registration", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when visiting the registration page" do
    it "displays the registration form" do
      visit new_user_path

      expect(page).to have_content("Register User")
      expect(page).to have_field("Email Address", type: "email")
      expect(page).to have_field("Password", type: "password")
      expect(page).to have_button("Register")
      expect(page).to have_link("Sign in", href: new_session_path)
    end
  end

  context "when submitting the registration form" do
    it "registers a user successfully with valid details" do
      visit new_user_path

      fill_in "Email Address", with: "test@example.com"
      fill_in "Password", with: "password123"
      click_button "Register"

      expect(page).to have_content("Welcome! You have signed up successfully.") # Adjust the message based on your actual flash notice
      expect(current_path).to eq(root_path) # Adjust this path as necessary
    end

    it "shows errors when the form is submitted with invalid details" do
      visit new_user_path

      fill_in "Email Address", with: ""
      fill_in "Password", with: ""
      click_button "Register"

      expect(page).to have_content("Email address can't be blank") # Adjust based on validation messages
      expect(page).to have_content("Password can't be blank")
    end
  end

  context "when there is a flash message" do
    it "displays a success message for notices" do
      visit new_user_path
      page.execute_script("document.getElementById('notice').textContent = 'Registration successful!'")
      expect(page).to have_css(".bg-green-100", text: "Registration successful!")
    end

    it "displays an error message for alerts" do
      visit new_user_path
      page.execute_script("document.getElementById('alert').textContent = 'Registration failed!'")
      expect(page).to have_css(".bg-red-100", text: "Registration failed!")
    end
  end
end
