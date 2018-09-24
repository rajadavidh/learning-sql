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
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;
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

/*
ER Diagram Reminder
In the Parch & Posey database there are 5 tables:
1. web_events
2. accounts
3. orders
4. sales_reps
5. region

You will notice some of the columns in the tables have PK or FK next to the column name,
while other columns don't have a label at all.

If you look a little closer, you might notice that the PK is associated with the first column in every table.
The PK here stands for primary key. A primary key exists in every table,
and it is a column that has a unique value for every row.

If you look at the first few rows of any of the tables in our database,
you will notice that this first, PK, column is always unique.
For this database it is always called id, but that is not true of all databases.
*/

/*
Primary Key (PK)
A primary key is a unique column in a particular table. This is the first column in each of our tables.
Here, those columns are all called id, but that doesn't necessarily have to be the name.
It is common that the primary key is the first column in our tables in most databases.
*/

/*
Foreign Key (FK)
A foreign key is when we see a primary key in another table.
We can see these in the previous ERD the foreign keys are provided as:
1. region_id
2. account_id
3. sales_rep_id
*/

/*
The way we join any two tables is in this way: linking the PK and FK (generally in an ON statement).
Example:
ON sales_reps.region_id = region.id

The actual ordering of which table name goes first in this statement doesn't matter so much.
So, we could also write:
ON region.id = sales_reps.region_id
*/

/*
JOIN for more than 2 tables
If we wanted to join all three of these tables, we could use the same logic.
The code below pulls all of the data from all of the joined tables:
*/

SELECT *
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

/*
Alternatively, we can create a SELECT statement that could pull specific columns from any of the three tables.
Again, our JOIN holds a table, and ON is a link for our PK to equal the FK.

To pull specific columns, the SELECT statement will need to specify the table that you are wishing
to pull the column from, as well as the column name.

We could pull only three columns in the above by changing the select statement to the below,
but maintaining the rest of the JOIN information:
*/

SELECT web_events.channel, accounts.name, orders.total
FROM web_events
JOIN accounts
ON web_events.account_id = accounts.id
JOIN orders
ON accounts.id = orders.account_id

/*
We could continue this same process to link all of the tables if we wanted.

!!! For efficiency reasons, we probably don't want to do this unless we actually need information from all of the tables.
*/


/*
Alias
When we JOIN tables together, it is nice to give each table an alias.
Frequently an alias is just the first letter of the table name.
Best practice: Use the lowercase letter and use the underscore instead of space

Example for table name:
FROM tablename AS t1
JOIN tablename2 AS t2

You actually saw something similar for column names in the Arithmetic Operators concept.

Example for arithmetic operators:
SELECT col1 + col2 AS total, col3

Frequently, you might also see these statements without the AS statement.
Each of the above could be written in the following way instead, and they would still produce the exact same results:

Example for table name:
FROM tablename t1
JOIN tablename2 t2

Example for arithmetic operators:
SELECT col1 + col2 total, col3
*/

-- Example:
SELECT o.*, a.*
FROM orders o
JOIN accounts a
ON o.account_id = a.id

/*
Alias for columns in resulting table
While aliasing tables is the most common use case. It can also be used
to alias the columns selected to have the resulting table reflect a more readable name.
*/

-- Example:
SELECT t1.column1 aliasname, t2.column2 aliasname2
FROM tablename AS t1
JOIN tablename2 AS t2

/*
^ The result:
| aliasname   | aliasname2  |
| example row | example row |
| example row | example row |
*/

-- Quiz: JOIN part I

/*
1. Provide a table for all web_events associated with account name of Walmart. There should be three columns.
Be sure to include the primary_poc, time of the event, and the channel for each event.
Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
*/

SELECT a.name, a.primary_poc, w.occurred_at, w.channel
FROM accounts AS a
JOIN web_events AS w
ON a.id = w.account_id
WHERE a.name = 'Walmart';
-- ^ Solution:
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name = 'Walmart';

/*
2. Provide a table that provides the region for each sales_rep along with their associated accounts.
Your final table should include three columns: the region name, the sales rep name, and the account name.
Sort the accounts alphabetically (A-Z) according to account name.
*/

SELECT r.name region_name, s.name sales_rep_name, a.name account_name
FROM region AS r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON a.sales_rep_id = s.id
ORDER BY a.name ASC;
-- ^ Solution:
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
ORDER BY a.name;

/*
3. Provide the name for each region for every order,
as well as the account name and the unit price they paid (total_amt_usd/total) for the order.
Your final table should have 3 columns: region name, account name, and unit price.
A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
*/

SELECT r.name region_name, a.name account_name, o.total_amt_usd / (o.total+0.01) unit_price
FROM region as r
JOIN sales_reps AS s
ON r.id = s.region_id
JOIN accounts AS a
ON a.sales_rep_id = s.id
JOIN orders AS o
ON o.account_id = a.id
LIMIT 10;
-- ^ Solution:
SELECT r.name region, a.name account,
       o.total_amt_usd/(o.total + 0.01) unit_price
FROM region r
JOIN sales_reps s
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id;