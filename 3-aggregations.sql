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