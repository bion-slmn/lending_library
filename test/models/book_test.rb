# spec/models/book_spec.rb
require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "associations" do
    it { should have_many(:borrowings) }
    it { should have_many(:users).through(:borrowings) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:author) }
    it { should validate_presence_of(:isbn) }
    it { should validate_uniqueness_of(:isbn) }
  end

  describe "instance methods" do
    let(:book) { Book.create(title: "Test Book", author: "John Doe", isbn: "123-456-789") }

    it "initially has a nil status" do
      expect(book.status).to be_nil
    end
  end
end
