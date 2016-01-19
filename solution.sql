--1. Which authors are represented in our store?
SELECT * FROM authors;

--2. Which authors are also distinguished authors?
SELECT * FROM distinguished_authors;

--3. Which authors are not distinguished authors?
SELECT last_name, first_name FROM authors
EXCEPT
SELECT last_name, first_name FROM distinguished_authors;

--4. How many authors are represented in our store?
SELECT COUNT(*) AS NumberOFAuthors FROM authors;

--5. Who are the favorite authors of the employee with the first name of Michael?
SELECT authors_and_titles FROM favorite_authors WHERE employee_id = (SELECT id FROM employees WHERE first_name = 'Michael');

--6. What are the titles of all the books that are in stock today?
SELECT books.title, stock.stock FROM books
JOIN editions ON editions.book_id = books.id
JOIN stock ON stock.isbn = editions.isbn
WHERE stock.stock > 0;
--Note: I don't need to display stock.stock, but it proves I've only selected the ones that are in stock at the moment.

--7. Insert one of your favorite books into the database. Hint: You’ll want to create data in at least 2 other tables to completely create this book.
INSERT INTO books (id, title, author_id, subject_id)
	VALUES(899, 'Pride and Prejudice', 208, 3);
INSERT INTO authors (id, last_name, first_name)
	VALUES(208, 'Austen', 'Jane');
INSERT INTO editions (isbn, book_id, edition, publisher_id, publication, type)
	VALUES('0486284735', 899, 1, 59, '1813-01-28', 'p');
INSERT INTO stock (isbn, cost, retail, stock)
	VALUES('0486284735', 5.00, 13.95, 12); 

--8. What authors have books that are not in stock?
SELECT authors.last_name, stock.stock FROM authors
JOIN books ON books.author_id = authors.id
JOIN editions ON editions.book_id = books.id
JOIN stock ON stock.isbn = editions.isbn
WHERE stock.stock = 0;

--9. What is the title of the book that has the most stock?
SELECT books.title, stock.stock FROM books
JOIN editions ON editions.book_id = books.id
JOIN stock ON stock.isbn = editions.isbn
ORDER BY stock DESC
LIMIT 1;