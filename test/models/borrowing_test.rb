# spec/models/borrowing_spec.rb
require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe "validations" do
    it { should validate_presence_of(:due_date) }
  end

  describe "custom logic" do
    let(:user) { User.create(email_address: "user@example.com", password: "password123") }
    let(:book) { Book.create(title: "Sample Book", author: "John Doe", isbn: "123-456-789") }
    let(:borrowing) { Borrowing.create(user: user, book: book, due_date: Date.today + 7.days) }

    it "is valid with valid attributes" do
      expect(borrowing).to be_valid
    end

    it "is not valid without a due date" do
      borrowing.due_date = nil
      expect(borrowing).not_to be_valid
    end
  end
end
