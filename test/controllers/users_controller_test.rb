require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @existing_user = User.create!(email_address: "test@example.com", password: "password")
  end

  test "should get new user form" do
    get new_user_url
    assert_response :success
    assert_select "h1", "Register User"  # Assuming the form page has this header
  end

  test "should create a new user" do
    assert_difference("User.count", 1) do
      post users_url, params: { user: { email_address: "newuser@example.com", password: "password", password_confirmation: "password" } }
    end
    assert_redirected_to root_path
    assert_equal "User registered successfully!", flash[:notice]
  end

  test "should not create user with duplicate email" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email_address: "test@example.com", password: "password", password_confirmation: "password" } }
    end
    assert_response :unprocessable_entity
    assert_select "p#alert", "Email already exists. Please use a different email."
  end



  private

  def new_user_url
    "/users/new"
  end

  def users_url
    "/users"
  end
end
