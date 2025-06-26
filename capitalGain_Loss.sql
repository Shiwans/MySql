-- Leetcode
-- 1393 problem number
-- MEDIUM

-- Table: Stocks
-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | stock_name    | varchar |
-- | operation     | enum    |
-- | operation_day | int     |
-- | price         | int     |
-- +---------------+---------+
-- (stock_name, operation_day) is the primary key (combination of columns with unique values) for this table.
-- The operation column is an ENUM (category) of type ('Sell', 'Buy')
-- Each row of this table indicates that the stock which has stock_name had an operation on the day operation_day with the price.
-- It is guaranteed that each 'Sell' operation for a stock has a corresponding 'Buy' operation in a previous day. It is also guaranteed
-- that each 'Buy' operation for a stock has a corresponding 'Sell' operation in an upcoming day.
 

-- Q:=
-- Write a solution to report the Capital gain/loss for each stock.
-- The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
-- Return the result table in any order
-- The result format is in the following example.


-- solution:- 
SELECT 
  stock_name,
  MAX(CASE WHEN operation = 'Sell' THEN total_price ELSE 0 END) -
  MAX(CASE WHEN operation = 'Buy' THEN total_price ELSE 0 END) AS capital_gain_loss
FROM (
  SELECT stock_name, operation, SUM(price) AS total_price
  FROM stocks
  GROUP BY stock_name, operation
) AS grouped_data
GROUP BY stock_name;


-- better way
SELECT 
  stock_name,
  total_sell - total_buy AS capital_gain_loss
FROM (
    SELECT 
      stock_name,
      SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) AS total_buy,
      SUM(CASE WHEN operation = 'Sell' THEN price ELSE 0 END) AS total_sell
    FROM Stocks
    GROUP BY stock_name
) AS sub;


-- optimized way
SELECT 
  stock_name,
  SUM(CASE WHEN operation = 'Sell' THEN price ELSE 0 END) -
  SUM(CASE WHEN operation = 'Buy' THEN price ELSE 0 END) AS capital_gain_loss
FROM stocks
GROUP BY stock_name;


-- other solution
SELECT 
  stock_name,
  SUM(CASE 
        WHEN operation = 'Buy' THEN -price 
        WHEN operation = 'Sell' THEN price 
      END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;


-- most optimized query:-
SELECT 
  stock_name,
  SUM(CASE WHEN operation = 'Sell' THEN price ELSE -price END) AS capital_gain_loss
FROM Stocks
GROUP BY stock_name;
