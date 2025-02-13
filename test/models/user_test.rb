# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end

    it "is invalid without an email address" do
      user.email_address = nil
      expect(user).not_to be_valid
    end

    it "is invalid without a password_digest" do
      user.password_digest = nil
      expect(user).not_to be_valid
    end

    it "is invalid with a duplicate email address" do
      create(:user, email_address: "test@example.com")
      duplicate_user = build(:user, email_address: "test@example.com")
      expect(duplicate_user).not_to be_valid
    end
  end

  describe "Database columns" do
    it { should have_db_column(:email_address).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end
end
