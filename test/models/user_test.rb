require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(email_address: "user@example.com", password: "password123")
  end

  test "is valid with valid attributes" do
    assert @user.valid?
  end

  test "is invalid without a password" do
    @user.password = nil
    assert_not @user.valid?, "User should not be valid without a password"
  end

  test "email address is normalized before save" do
    user = User.create(email_address: "  EXAMPLE@DOMAIN.COM  ", password: "password123")
    assert_equal "example@domain.com", user.email_address, "Email address should be normalized"
  end

  test "has many borrowings" do
    assert_respond_to @user, :borrowings
  end

  test "has many borrowed books through borrowings" do
    assert_respond_to @user, :borrowed_books
  end
end
