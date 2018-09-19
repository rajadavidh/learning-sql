/*
Database Normalization
When creating a database, it is really important to think about how data will be stored.
This is known as normalization, and it is a huge part of most SQL classes.
If you are in charge of setting up a new database, it is important to have a thorough understanding of database normalization.

There are essentially three ideas that are aimed at database normalization:

1. Are the tables storing logical groupings of the data?
2. Can I make changes in a single location, rather than in many tables for the same information?
3. Can I access and manipulate data quickly and efficiently?

This is discussed in detail here: https://www.itprotoday.com/microsoft-sql-server/sql-design-why-you-need-database-normalization

However, most analysts are working with a database that was already set up with the necessary properties in place.
As analysts of data, you don't really need to think too much about data normalization.
You just need to be able to pull the data from the database, so you can start drawing insights.
This will be our focus in this lesson.
*/

/*
JOIN
The JOIN introduces the second table from which you would like to pull data, and
the ON tells you how you would like to merge the tables in the FROM and JOIN statements together.
*/

-- Example INNER JOIN:
SELECT orders.*, accounts.*
FROM orders JOIN accounts ON orders.account_id = accounts.id;


/*
Additional Information
If we wanted to only pull individual elements from either the orders or accounts table,
we can do this by using the exact same information in the FROM and ON statements.

However, in your SELECT statement, you will need to know how to specify tables and columns in the SELECT statement:
1. The table name is always before the period.
2. The column you want from that table is always after the period.

For example, if we want to pull only the account name and the dates in which that account placed an order,
but none of the other columns, we can do this with the following query:
*/
SELECT accounts.name, orders.occurred_at
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
-- ^ This query only pulls two columns, not all the information in these two tables.

/*
Alternatively, the below query pulls all the columns from _ both_ the accounts and orders table:
*/
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;


-- Quiz: JOIN
/*
1. Try pulling all the data from the accounts table, and all the data from the orders table.
*/
SELECT accounts.*, orders.*
FROM orders JOIN accounts ON orders.account_id = accounts.id;
-- ^ Correct solution:
SELECT orders.*, accounts.*
FROM accounts
JOIN orders
ON accounts.id = orders.account_id;
/*
^ Notice this result is the same as if you switched the tables in the FROM and JOIN.
Additionally, which side of the = a column is listed doesn't matter.
*/

/*
2. Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and the primary_poc from the accounts table.
*/
SELECT orders.standard_qty, orders.gloss_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders JOIN accounts ON orders.account_id = accounts.id;