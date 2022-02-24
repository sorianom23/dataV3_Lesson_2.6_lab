
-- #### Lab | SQL Queries - Lesson 2.6 #### --

-- 1. In the table actor, which are the actors whose last names are not repeated?
-- For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd.
-- These three actors have the same last name. So we do not want to include this last name in our output.
-- Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
select * from sakila.actor
order by last_name ASC;

select last_name as 'Unique Last Name'
from sakila.actor
group by last_name
having count(*) < 2;


-- 2. Which last names appear more than once? We would use the same logic as in the previous question
-- but this time we want to include the last names of the actors where the last name was present more than once.
select last_name as 'Unique Last Name'
from sakila.actor
group by last_name
having count(*) > 1;


-- 3. Using the rental table, find out how many rentals were processed by each employee.
-- Employee 1: 8040 rentals
-- Employee 2: 8004 rentals
select * from sakila.rental;

select staff_id as 'Employee', count(rental_id) as 'Rentals'
from sakila.rental
group by staff_id;



-- 4. Using the film table, find out how many films were released each year.
select * from sakila.film;
select film_id, release_year
from sakila.film;
-- Since I've checked and I know that there are only films from 2006.. I can't count them all and get the results -> 1000
select count(release_year) from sakila.film;
-- A more efficient way to do (((in case there are multiple years))) would be the following:
select release_year, count(film_id) from sakila.film
group by release_year;


-- 5. Using the film table, find out for each rating how many films were there.
select * from sakila.film;

select rating as 'Rental Rate', count(film_id) as 'Number of Films'
from sakila.film
group by rating
order by rating DESC;

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places.
select * from sakila.film;

select rating as 'Rating',
count(film_id) as 'Number of Films',
round(avg(length) ,2) as 'Length Avg'
from sakila.film
group by rating
order by rating DESC;


-- 7. Which kind of movies (rating) have a mean duration of more than two hours?
-- All of them
select rating as 'Rating',
round(avg(length)) as 'Length Avg'  
from sakila.film
where length > 120
group by rating;


-- 8. Rank films by length (filter out the rows that have nulls or 0s in length column).
-- In your output, only select the columns title, length, and the rank.

-- ######## DENSE_RANK() ######## --
-- It doesn't leave gaps in the ranking (like RANK() does)
-- More than one row can have the same rank. The next row will get the next rank

select * from sakila.film;

select title, length, dense_rank() over(order by length) as 'rank'
from sakila.film
where length <> 0 and length <> ' '
order by length ASC;

