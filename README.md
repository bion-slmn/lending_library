Here’s a detailed `README.md` file for your Ruby on Rails 8 book lending library application:

---

# 📚 Book Lending Library Application

A simple Book Lending Library application built with **Ruby on Rails 8** that allows registered users to browse books, borrow available books for 2 weeks, return books, and view a list of currently borrowed books. This project uses Rails 8's default authentication system for user management.

## 🚀 Features
- User Registration and Login (Rails 8 default authentication)
- Book Listing Page with Availability Status
- Book Details Page with the ability to borrow the book (if available)
- User Profile Page showing currently borrowed books and due dates
- Return Borrowed Books
- Model Validations (e.g., unique ISBN, required fields)
- Error Handling (e.g., prevent borrowing an already borrowed book)
- Tests for models, controllers, and views using Rails' built-in testing framework

---

## 🛠️ Setup Instructions

### Prerequisites
Make sure you have the following installed:
- **Ruby** 3.2.x  
- **Rails** 8.x  
- **SQLite**  
- **Bundler**

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/book-lending-library.git
cd book-lending-library
```

### 2. Install Dependencies
Run the following command to install the required gems:
```bash
bundle install
```

### 3. Configure the Database
Create and migrate the database:
```bash
rails db:create
rails db:migrate
```

### 4. Seed the Database
Seed the database with sample books and a default user:
```bash
rails db:seed
```

The seed file creates:
- **Sample Books** with random titles, authors, and ISBNs.
- **Default User** for easy testing:  
  **Email:** `test@example.com`  
  **Password:** `password`

### 5. Start the Rails Server
Run the server:
```bash
rails server
```
Visit `http://localhost:3000` to access the application.

---

## 🧪 Running Tests
This application includes model, controller, and view tests. Run the test suite with the following command:
```bash
rails test
```

---

## 📂 Project Structure
- **Models**
  - `User`: Handles user authentication and associations.
  - `Book`: Represents a book with validations for title, author, and ISBN.
  - `Borrowing`: Tracks the relationship between a user and a book with a due date.
  
- **Controllers**
  - `BooksController`: Handles listing, showing details, and borrowing books.
  - `BorrowingsController`: Handles returning borrowed books.
  - `UsersController`: Displays the user profile and borrowed books.

---

## 🔒 Authentication
This project uses Rails 8's default authentication system. Users can register, log in, and manage their borrowed books.

---
