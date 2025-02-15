# Clear the existing data
Book.destroy_all

# Seed the database with sample books
books = [
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", isbn: "9780743273565", status: 'available' },
  { title: "1984", author: "George Orwell", isbn: "9780451524935", status: 'available' },
  { title: "To Kill a Mockingbird", author: "Harper Lee", isbn: "9780061120084", status: 'available' },
  { title: "Pride and Prejudice", author: "Jane Austen", isbn: "9781503290563", status: 'available' },
  { title: "Moby-Dick", author: "Herman Melville", isbn: "9781503280786", status: 'available' }
]

books.each do |book|
  Book.create!(book)
end

puts "Seeded #{Book.count} books successfully!"
