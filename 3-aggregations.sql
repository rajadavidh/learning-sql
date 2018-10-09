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
