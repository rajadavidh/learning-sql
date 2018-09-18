# SQL for Data Analysis

# SELECT and FROM ------------------------------
/*
1. SELECT is where you tell the query what columns you want back.
^ SELECT adalah keyword untuk menampilkan kolom

2. FROM is where you tell the query what table you are querying from.
Notice the columns need to exist in this table.
^ FROM adalah keyword yang menunjukkan tabel asal
*/


# LIMIT ------------------------------
/*
The LIMIT statement is useful when you want to see just the first few rows of a table.

This can be much faster for loading than if we load the entire dataset.
*/

# Example:
SELECT * FROM orders LIMIT 10;
SELECT occurred_at, account_id, channel FROM web_events LIMIT 15;

# ORDER BY ------------------------------
/*
The ORDER BY statement is always after the SELECT and FROM statements, but it is before the LIMIT statement.

Default: ASCENDING

Pro Tip:
Remember DESC can be added after the column in your ORDER BY statement to sort in descending order.
ASCENDING (lowest to highest; earliest to latest; oldest to newest)
DESCENDING (highest to lowest; latest to earliest; newest to oldest)
*/

# Example:
SELECT * FROM orders ORDER BY occurred_at LIMIT 10;
SELECT * FROM orders ORDER BY occurred_at DESC LIMIT 10;

## Quiz ORDER BY
/*
1. Write a query to return the 10 earliest orders in the orders table. Include the id, occurred_at, and total_amt_usd.
*/

SELECT id, occurred_at, total_amt_usd FROM orders ORDER BY occurred_at LIMIT 10;

/*
2. Write a query to return the top 5 orders in terms of largest total_amt_usd. Include the id, account_id, and total_amt_usd.
*/

SELECT id, account_id, total_amt_usd FROM orders ORDER BY total_amt_usd DESC LIMIT 5;

/*
3. Write a query to return the bottom 20 orders in terms of least total. Include the id, account_id, and total.
*/

SELECT id, account_id, total FROM orders ORDER BY total LIMIT 20;

# ORDER BY Part II
/*
Here, we saw that we can ORDER BY more than one column at a time.

The statement sorts according to columns listed from left first and those listed on the right after that.

We still have the ability to flip the way we order using DESC.
*/

# Example:
SELECT account_id, total_amt_usd FROM orders ORDER BY account_id, total_amt_usd DESC;
# ^ sorting berdasarkan account_id dahulu

SELECT account_id, total_amt_usd FROM orders ORDER BY total_amt_usd DESC, account_id;
# ^ sorting berdasarkan total_amt_usd dahulu

## Quiz ORDER BY Part II
/*
1. Write a query that returns the top 5 rows from orders ordered according to newest to oldest,
but with the largest total_amt_usd for each date listed first for each date.
You will notice each of these dates shows up as unique because of the time element.
When you learn about truncating dates in a later lesson,
you will better be able to tackle this question on a day, month, or yearly basis.
*/

SELECT account_id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;
# ^ Correct solution:
SELECT *
FROM orders
ORDER BY occurred_at DESC, total_amt_usd DESC
LIMIT 5;

/*
2. Write a query that returns the top 10 rows from orders ordered according to oldest to newest,
but with the smallest total_amt_usd for each date listed first for each date.
You will notice each of these dates shows up as unique because of the time element.
When you learn about truncating dates in a later lesson,
you will better be able to tackle this question on a day, month, or yearly basis.
*/

SELECT account_id, occurred_at, total_amt_usd
FROM orders
ORDER BY total_amt_usd, occurred_at -- (!!!Incorrect)
LIMIT 10;
# ^ Correct solution:
SELECT *
FROM orders
ORDER BY occurred_at, total_amt_usd
LIMIT 10;

# WHERE ------------------------------
/*
Filter result based on specific criteria.

Using these WHERE statements, we do not need to ORDER BY unless we want to actually order our data.

Common symbols used within WHERE statements include:
> (greater than)
< (less than)
>= (greater than or equal to)
<= (less than or equal to)
= (equal to)
!= (not equal to)
*/

# Example:
SELECT * FROM orders WHERE account_id = 4251 ORDER BY occurred_at DESC LIMIT 10;

# WHERE Quiz
/*
1. Pull the first 5 rows and all columns from the orders table that have a dollar amount of
gloss_amt_usd greater than or equal to 1000.
*/

SELECT * FROM orders WHERE gloss_amt_usd >= 1000 LIMIT 5;

/*
2. Pull the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.
*/

SELECT * FROM orders WHERE total_amt_usd < 500 LIMIT 10;

# WHERE with Non-numeric data
/*
You also need to be sure to use single quotes (just be careful if you have quotes in the original text)
with the text data.

Commonly when we are using WHERE with non-numeric data fields, we use the LIKE, NOT, or IN operators.
*/

# Example:
SELECT * FROM demo.accounts WHERE name = 'United Technologies';

# WHERE Quiz Part II
/*
Filter the accounts table to include the company name, website, and the primary point of contact (primary_poc)
for Exxon Mobil in the accounts table.
*/

SELECT name, website, primary_poc FROM accounts WHERE name = 'Exxon Mobil';

# ARITHMETIC OPERATORS ------------------------------
/*
Common operators include:
* (Multiplication)
+ (Addition)
- (Subtraction)
/ (Division)

Creating a new column that is a combination of existing columns is known as a "derived column".
*/

# Example:
SELECT account_id, occurred_at, standard_qty, gloss_qty, poster_qty,
       gloss_qty * poster_qty <-- This is "derived column"
FROM orders;

# Example making "derived column" as an alias:
SELECT account_id, occurred_at, standard_qty, gloss_qty, poster_qty,
       gloss_qty * poster_qty AS nonstandard_qty
FROM orders;

# ARITHMETIC OPERATORS Quiz
/*
1. Create a column that divides the standard_amt_usd by the standard_qty
to find the unit price for standard paper for each order.
Limit the results to the first 10 orders, and include the id and account_id fields.
*/

SELECT id, account_id,
       standard_amt_usd / standard_qty AS unit_price
FROM orders;
# ^ Correct solution:
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price
FROM orders
LIMIT 10;

/*
2. Write a query that finds the percentage of revenue that comes from poster paper for each order.
You will need to use only the columns that end with _usd. (Try to do this without using the total column).
Include the id and account_id fields.

NOTE - you will be thrown an error with the correct solution to this question. This is for a division by zero.
You will learn how to get a solution without an error to this query when you learn about CASE statements
in a later section. For now, you might just add some very small value to your denominator as a work around.
*/

SELECT id, account_id,
       (poster_qty * poster_amt_usd) / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_revenue
FROM orders;
# ^ Correct solution:
SELECT id, account_id,
       poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders;

# LOGICAL OPERATORS ------------------------------
/*
1. LIKE
This allows you to perform operations similar to using WHERE and =,
but for cases when you might not know exactly what you are looking for.

2. IN
This allows you to perform operations similar to using WHERE and =, but for more than one condition.

3. NOT
This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a certain condition.

4. AND & BETWEEN
These allow you to combine operations where all combined conditions must be true.

5. OR
This allow you to combine operations where at least one of the combined conditions must be true.
*/

# LIKE ------------------------------
/* The LIKE operator is extremely useful for working with text.

You will use LIKE within a WHERE clause.

The LIKE operator is frequently used with % (wildcard sign). The % tells us that we might want any number of characters
leading up to a particular set of characters or following a certain set of characters.
*/

# Example:
SELECT * FROM web_events_full WHERE referrer_url LIKE '%google%';

# LIKE Quiz
/*
1. All the companies whose names start with 'C'.
*/

SELECT * FROM accounts WHERE name LIKE 'C%';

/*
2. All companies whose names contain the string 'one' somewhere in the name.
*/

SELECT * FROM accounts WHERE name LIKE '%one%';

/*
3. All companies whose names end with 's'.
*/

SELECT * FROM accounts WHERE name LIKE '%s';

# IN ------------------------------
/*
The IN operator is useful for working with both numeric and text columns.

This operator allows you to use an =, but for more than one item of that particular column.
We can check one, two or many column values for which we want to pull data, but all within the same query.

In the upcoming concepts, you will see the OR operator that would also allow us to perform these tasks,
but the IN operator is a cleaner way to write these queries.
*/

# Example:
SELECT * FROM accounts WHERE name IN ('Walmart', 'Apple');
SELECT * FROM orders WHERE account_id IN (1001, 1021);

# IN Quiz
/*
1. Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
*/

SELECT name, primary_poc, sales_rep_id FROM accounts WHERE name IN ('Walmart', 'Target', 'Nordstorm');

/*
2. Use the web_events table to find all information regarding individuals who were contacted via
the channel of organic or adwords.
*/

SELECT * FROM web_events WHERE channel IN ('organic', 'adwords');

# NOT ------------------------------
/*
The NOT operator is an extremely useful operator for working with the previous two operators we introduced: IN and LIKE.

By specifying NOT LIKE or NOT IN, we can grab all of the rows that do not meet a particular criteria.
*/

# Example:
SELECT sales_rep_id, name FROM accounts WHERE sales_rep_id NOT IN (321500, 321570) ORDER BY sales_rep_id;

SELECT * FROM web_events_full WHERE referrer_url NOT LIKE '%google%';

# NOT Quiz
# TODO

# AND and BETWEEN ------------------------------
# TODO

# AND and BETWEEN Quiz
# TODO

# OR ------------------------------
# TODO

# OR Quiz
# TODO