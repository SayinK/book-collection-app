require 'rails_helper'

RSpec.describe Book, type: :model do

  describe "Unit Tests: Validations" do
    it "is valid with all attributes" do
      book = Book.new(
        title: "Harry Potter",
        author: "J.K. Rowling",
        price: 19.99,
        published_date: Date.new(1997, 6, 26)
      )
      expect(book).to be_valid
    end

    # tests for title
    it "is invalid without a title" do
      book = Book.new(title: nil)
      expect(book).to_not be_valid
    end

    it "is invalid with a blank title" do
      book = Book.new(title: "")
      expect(book).to_not be_valid
    end

    # tests for author
    it "is invalid without an author" do
      book = Book.new(title: "Test Book", author: nil)
      expect(book).to_not be_valid
    end

    it "is invalid with a blank author" do
      book = Book.new(title: "Test Book", author: "")
      expect(book).to_not be_valid
    end

    # tests for price
    it "is invalid without a price" do
      book = Book.new(title: "Test Book", price: nil)
      expect(book).to_not be_valid
    end

    it "is invalid with a negative price" do
      book = Book.new(title: "Test Book", price: -5.00)
      expect(book).to_not be_valid
    end

    it "is valid with a price of zero" do
      book = Book.new(
        title: "Free Book",
        author: "Author",
        price: 0,
        published_date: Date.today
      )
      expect(book).to be_valid
    end

    # test for published date
    it "is invalid without a published date" do
      book = Book.new(title: "Test Book", published_date: nil)
      expect(book).to_not be_valid
    end
  end
end