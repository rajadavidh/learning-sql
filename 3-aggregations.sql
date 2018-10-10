/*
NULL
NULLs are a datatype that specifies where no data exists in SQL.
They are often ignored in our aggregation functions,
which you will get a first look at in the next concept using COUNT.

Notice that NULLs are different than a zero - they are cells where data does not exist.

When identifying NULLs in a WHERE clause, we write IS NULL or IS NOT NULL.
We don't use =, because NULL isn't considered a value in SQL. Rather, it is a property of the data.
*/

/*
NULL Expert tip
There are two common ways in which you are likely to encounter NULLs:

1. NULLs frequently occur when performing a LEFT or RIGHT JOIN.
You saw in the last lesson - when some rows in the left table of a left join are not
matched with rows in the right table, those rows will contain some NULL values in the result set.

2. NULLs can also occur from simply missing data in our database.
*/

-- Example:
SELECT *
FROM accounts
WHERE primary_poc IS NULL;


/*
COUNT
Returning all rows that contains non-null data.
Notice that COUNT does not consider rows that have NULL values.
Therefore, this can be useful for quickly identifying which rows have missing data.
*/

SELECT COUNT(*) AS order_count
FROM orders
WHERE occurred_at >= '2016-02-01'
AND occurred_at < '2017-01-01';

/*
Here is an example of finding all the rows in the accounts table.
```
SELECT COUNT(*)
FROM accounts;
```

But we could have just as easily chosen a column to drop into the aggregation function:
```
SELECT COUNT(accounts.id)
FROM accounts;
```

These two statements are equivalent, but this isn't always the case.
*/


/*
SUM
Unlike COUNT, you can only use SUM on numeric columns.
However, SUM will ignore NULL values, as do the other aggregation functions you will see in the upcoming lessons.
*/

-- Example :
SELECT SUM(standard_qty) AS standard,
       SUM(gloss_qty) AS gloss,
       SUM(poster_qty) AS poster
FROM orders;

-- ^ you can not use SUM(*) the way you can use COUNT(*)

/*
Aggregation Reminder
An important thing to remember: aggregators only aggregate vertically - the values of a column.
If you want to perform a calculation across rows, you would do this with simple arithmetic:
https://community.modeanalytics.com/sql/tutorial/sql-operators/#arithmetic-in-sql
*/

-- Quiz: SUM

/*
1. Find the total amount of poster_qty paper ordered in the orders table.
*/

SELECT SUM(poster_qty) AS poster
FROM orders;
-- ^ Solution:
SELECT SUM(poster_qty) AS total_poster_sales
FROM orders;

/*
2. Find the total amount of standard_qty paper ordered in the orders table.
*/

SELECT SUM(standard_qty) AS standard
FROM orders;
-- ^ Solution:
SELECT SUM(standard_qty) AS total_standard_sales
FROM orders;

/*
3. Find the total dollar amount of sales using the total_amt_usd in the orders table.
*/

SELECT SUM(total_amt_usd) AS total_sales
FROM orders;
-- ^ Solution:
SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders;

/*
4. Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table.
This should give a dollar amount for each order in the table.
*/

SELECT SUM(standard_amt_usd) AS standard_sales,
       SUM(gloss_amt_usd) AS gloss_sales
FROM orders;
-- ^ I was incorrectly interpret the question. Correct solution:
SELECT standard_amt_usd + gloss_amt_usd AS total_standard_gloss
FROM orders;

/*
5. Find the standard_amt_usd per unit of standard_qty paper.
Your solution should use both an aggregation and a mathematical operator.
*/

SELECT SUM(standard_amt_usd) / SUM(standard_qty) AS standard_sales_per_unit
FROM orders;
-- ^ Solution:
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_price_per_unit
FROM orders;


/*
MIN and MAX
Notice that here we were simultaneously obtaining the MIN and MAX number of orders of each paper type.
However, you could run each individually.

Notice that MIN and MAX are aggregators that again ignore NULL values.
Check the expert tip below for a cool trick with MAX & MIN.

Expert Tip
Functionally, MIN and MAX are similar to COUNT in that they can be used on non-numerical columns.

Depending on the column type, MIN will return:
* the lowest number,
* earliest date, or
* non-numerical value
as early in the alphabet as possible.

As you might suspect, MAX does the opposite—it returns:
* the highest number,
* the latest date, or
* the non-numerical value
closest alphabetically to “Z.”
*/

-- Example:

SELECT MIN(standard_qty) AS standard_min,
       MIN(gloss_qty) AS gloss_min,
       MIN(poster_qty) AS poster_min,
       MAX(standard_qty) AS standard_max,
       MAX(gloss_qty) AS gloss_max,
       MAX(poster_qty) AS poster_max,
FROM orders;

/*
AVG
Similar to other software AVG returns the mean of the data - that is
the sum of all of the values in the column divided by the number of values in a column.
This aggregate function again ignores the NULL values in both the numerator and the denominator.

If you want to count NULLs as zero, you will need to use SUM and COUNT.
However, this is probably not a good idea if the NULL values truly just represent unknown values for a cell.
*/

-- Example:

SELECT AVG(standard_qty) AS standard_avg,
       AVG(gloss_qty) AS gloss_avg,
       AVG(poster_qty) AS poster_avg
FROM orders;

/*
MEDIAN - Expert Tip
One quick note that a median might be a more appropriate measure of center for this data,
but finding the median happens to be a pretty difficult thing to get using SQL alone —
so difficult that finding a median is occasionally asked as an interview question.

Some reference I found:
https://www.red-gate.com/simple-talk/sql/t-sql-programming/calculating-the-median-value-within-a-partitioned-set-using-t-sql/
https://www.1keydata.com/sql/sql-median.html
https://sqlperformance.com/2012/08/t-sql-queries/median
https://stackoverflow.com/questions/1342898/function-to-calculate-median-in-sql-server
*/

/*
1. When was the earliest order ever placed? You only need to return the date.
*/


/*
2. Try performing the same query as in question 1 without using an aggregation function.
*/


/*
3. When did the most recent (latest) web_event occur?
*/


/*
4. Try to perform the result of the previous query without using an aggregation function.
*/


/*
5. Find the mean (AVERAGE) amount spent per order on each paper type,
as well as the mean amount of each paper type purchased per order.
Your final answer should have 6 values - one for each paper type for the average number of sales,
as well as the average amount.
*/

/*
6. Via the video, you might be interested in how to calculate the MEDIAN.
Though this is more advanced than what we have covered so far try finding
- what is the MEDIAN total_usd spent on all orders?
*/