-- LeetCode
-- MEDIUM
-- 608 quesiton number

-- question:-
-- Table: Tree
-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | id          | int  |
-- | p_id        | int  |
-- +-------------+------+
-- id is the column with unique values for this table.
-- Each row of this table contains information about the id of a node and the id of its parent node in a tree.
-- The given structure is always a valid tree.

-- Each node in the tree can be one of three types:
-- "Leaf": if the node is a leaf node.
-- "Root": if the node is the root of the tree.
-- "Inner": If the node is neither a leaf node nor a root node.

-- Write a solution to report the type of each node in the tree.
-- Return the result table in any order.
-- The result format is in the following example.


-- solution:-
select
    id,
    case
        when p_id is null then "Root"
        when id in (
            select
                p_id
            from
                tree
            where
                p_id is not null
        ) then "Inner"
        else "Leaf"
    end as type
from
    tree;


-- other solutions:
SELECT
    t1.id,
    CASE
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN COUNT(t2.id) > 0 THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM
    Tree t1
    LEFT JOIN Tree t2 ON t1.id = t2.p_id
GROUP BY
    t1.id


-- another solution:
SELECT
    id,
    "Root" AS type
FROM
    Tree
WHERE
    p_id IS NULL
UNION ALL
SELECT
    p_id AS id,
    "Inner" AS type
FROM
    Tree
WHERE
    p_id IS NOT NULL
    AND p_id NOT IN (
        SELECT
            id
        FROM
            Tree
        WHERE
            p_id IS NULL
    )
GROUP BY
    p_id
UNION ALL
SELECT
    id,
    "Leaf" AS type
FROM
    Tree
WHERE
    id NOT IN (
        SELECT DISTINCT
            (p_id)
        FROM
            Tree
        WHERE
            p_id IS NOT NULL
    )
    AND id NOT IN (
        SELECT
            id
        FROM
            Tree
        WHERE
            p_id IS NULL
    );