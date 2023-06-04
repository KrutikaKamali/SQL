/* Q1: Who is the senior most employee based on job title? */

SELECT first_name, last_name, levels
FROM employee
ORDER BY levels desc
LIMIT 1

/* Q2: Which countries have the most Invoices? */

SELECT COUNT(*) AS c, billing_country
FROM invoice
GROUP BY billing_country
ORDER BY c DESC

/* Q3: What are top 3 values of total invoice?*/

SELECT billing_country AS Country
FROM invoice
GROUP BY Country

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in
the city we made the most money. Write a query that returns one city that has the highest sum of 
invoice totals. Return both the city name & sum of all invoice totals */

SELECT billing_city, SUM(total) AS invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
Limit 1

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the 
best customer. Write a query that returns the person who has spent the most money. */

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS Total
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id
ORDER BY Total DESC
LIMIT 1

/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock')
ORDER BY email

/* Q7: Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS number_of_songs
FROM track
JOIN album ON track.album_id = album.album_id
JOIN artist ON album.artist_id = artist.artist_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10

/* Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT track.name, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(track.milliseconds) FROM track)
ORDER BY milliseconds DESC