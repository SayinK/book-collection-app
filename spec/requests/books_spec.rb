require 'rails_helper'

RSpec.describe "Books", type: :request do
  
  describe "Integration Tests: Creating a book" do
    it "creates a new book with all attributes" do
      post books_path, params: { 
        book: { 
          title: "To Kill a Mockingbird",
          author: "Harper Lee",
          price: 17.99,
          published_date: Date.new(1960, 6, 8)
        }
      }
      
      expect(response).to redirect_to(root_path)
      follow_redirect!
      
      expect(response.body).to include("Book was created")
      expect(Book.last.title).to eq("To Kill a Mockingbird")
      expect(Book.last.author).to eq("Harper Lee")
      expect(Book.last.price.to_f).to eq(17.99)
    end
  end

  describe "Integration Tests: Creating with missing attributes" do
    it "does not create a book with blank title" do
      expect {
        post books_path, params: { book: { title: "", author: "Author", price: 13 } }
      }.to_not change(Book, :count)
    end

    it "does not create a book with blank author" do
      expect {
        post books_path, params: { book: { title: "Title", author: "", price: 17 } }
      }.to_not change(Book, :count)
    end

    it "does not create a book with negative price" do
      expect {
        post books_path, params: { book: { title: "Title", author: "Author", price: -8 } }
      }.to_not change(Book, :count)
    end
  end

  describe "Integration Tests: Updating a book" do
    it "updates all book attributes" do
      book = Book.create!(
        title: "Old Title",
        author: "Old Author",
        price: 12.00,
        published_date: Date.today
      )
      
      patch book_path(book), params: { 
        book: { 
          title: "New Title",
          author: "New Author",
          price: 24.00
        } 
      }
      
      expect(response).to redirect_to(root_path)
      follow_redirect!
      
      expect(response.body).to include("Book was updated")
      expect(book.reload.title).to eq("New Title")
      expect(book.reload.author).to eq("New Author")
      expect(book.reload.price.to_f).to eq(24.00)
    end
  end

  describe "Integration Tests: Deleting a book" do
    it "deletes a book" do
      book = Book.create!(
        title: "To Delete",
        author: "Author",
        price: 18,
        published_date: Date.today
      )
      
      expect {
        delete book_path(book)
      }.to change(Book, :count).by(-1)
      
      expect(response).to redirect_to(root_path)
      follow_redirect!
      
      expect(response.body).to include("Book was deleted")
    end
  end
end