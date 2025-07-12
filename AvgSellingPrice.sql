-- LeetCode
-- Easy
-- 1251 question number

-- Question:=
-- Table: Prices
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | start_date    | date    |
-- | end_date      | date    |
-- | price         | int     |
-- +---------------+---------+
-- (product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table indicates the price of the product_id in the period from start_date to end_date.
-- For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.


-- Table: UnitsSold
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | purchase_date | date    |
-- | units         | int     |
-- +---------------+---------+
-- This table may contain duplicate rows.
-- Each row of this table indicates the date, units, and product_id of each product sold. 


-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.
-- Return the result table in any order.
-- The result format is in the following example.


-- solution:
SELECT
    p.product_id,
    ROUND(
        COALESCE(
            SUM(u.units * p.price) / NULLIF(SUM(u.units), 0),
            0
        ),
        2
    ) AS average_price
FROM
    Prices p
    LEFT JOIN UnitsSold u ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    p.product_id;

-- ✅ SQL Handles Row-by-Row First
-- SQL processes aggregations like SUM() on a row-by-row basis before applying the GROUP BY.
-- SUM(u.units * p.price)
-- It works like this under the hood:
-- For each matching row (after the JOIN and WHERE/ON conditions):
-- It calculates u.units * p.price.
-- Then it adds up all those individual values for each product_id (due to the GROUP BY).

--steps:-
-- Step 1: u.units * p.price row-by-row:
-- 100 * 5 = 500
-- 15 * 20 = 300
-- Step 2: Aggregation:
-- SUM(u.units * p.price) → 500 + 300 = 800
-- SUM(u.units) → 100 + 15 = 115
-- Step 3: Division:
-- 800 / 115 = 6.9565...
-- Rounded: 6.96

-- ✅ Difference between IFNULL() and COALESCE():
-- Function	Description
-- IFNULL(a, b)	Returns a if it's not NULL, else returns b. Only works with 2 arguments.
-- COALESCE(a, b, c, ...)	Returns the first non-NULL value in the list. Can take multiple arguments.

-- ✅ Problems in your current query:
-- 1.LEFT JOIN with WHERE purchase_date BETWEEN ... — this acts like an INNER JOIN and filters out products
-- with no sales, so products without sales are missing in the result.
-- 2.You're joining on only product_id, but you also need to match purchase_date between start_date and 
-- end_date — and that condition should be inside the JOIN, not in the WHERE.


-- others answer
SELECT
    p.product_id,
    COALESCE(
        ROUND(SUM(p.price * u.units) / SUM(u.units), 2),
        0
    ) AS average_price
FROM
    Prices p
    LEFT JOIN UnitsSold u ON p.product_id = u.product_id
    AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY
    p.product_id;