-- ============================================================
-- OLIST END-TO-END DATA ANALYTICS
-- SQL BUSINESS ANALYSIS
-- ============================================================

USE olist_project;


-- ============================================================
-- 0. CHECK DATABASE
-- ============================================================

SHOW TABLES;

SELECT 
    *
FROM
    orders
LIMIT 5;


-- ============================================================
-- Q1 | SELLER COMMERCIAL PERFORMANCE
-- ============================================================
-- Research question:
-- Which acquisition channels bring sellers with stronger
-- commercial performance after conversion?
SELECT 
    m.origin AS acquisition_channel,
    COUNT(DISTINCT cd.seller_id) AS number_of_sellers,
    COUNT(DISTINCT oi.order_id) AS number_of_orders,
    ROUND(SUM(oi.price), 2) AS total_gmv,
    ROUND(SUM(oi.price) / COUNT(DISTINCT oi.order_id),
            2) AS average_order_value
FROM
    mql AS m
        INNER JOIN
    closed_deals AS cd ON m.mql_id = cd.mql_id
        INNER JOIN
    order_items AS oi ON cd.seller_id = oi.seller_id
WHERE
    m.origin IS NOT NULL
        AND m.origin NOT IN ('unknown' , 'missing')
GROUP BY m.origin
ORDER BY total_gmv DESC;



-- ============================================================
-- Q2 | REGIONAL DELIVERY PERFORMANCE
-- ============================================================
-- Research question:
-- How reliable is delivery performance, and are there
-- meaningful regional differences?
SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,
                    o.order_purchase_timestamp)),
            2) AS average_delivery_days,
    ROUND(AVG(CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
                ELSE 0
            END) * 100,
            2) AS late_delivery_rate
FROM
    orders AS o
        INNER JOIN
    customers AS c ON o.customer_id = c.customer_id
WHERE
    o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY average_delivery_days DESC;



-- ============================================================
-- Q2.1 | STATES WITH THE HIGHEST LATE DELIVERY RATE
-- ============================================================

SELECT 
    c.customer_state,
    COUNT(DISTINCT o.order_id) AS delivered_orders,
    ROUND(AVG(CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
                ELSE 0
            END) * 100,
            2) AS late_delivery_rate
FROM
    orders AS o
        INNER JOIN
    customers AS c ON o.customer_id = c.customer_id
WHERE
    o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY late_delivery_rate DESC;



-- ============================================================
-- Q3 | DELIVERY RELIABILITY AND CUSTOMER SATISFACTION
-- ============================================================
-- Research question:
-- Which factors are most associated with lower customer
-- satisfaction?
--
-- This query focuses on delivery reliability.
--
-- Some orders have multiple reviews, so a CTE is used to create
-- one average review score per order before comparing late and
-- on-time deliveries.
-- ============================================================

WITH order_reviews AS (

    SELECT
        order_id,
        AVG(review_score) AS review_score

    FROM reviews

    GROUP BY order_id
)

SELECT
    CASE
        WHEN o.order_delivered_customer_date
             > o.order_estimated_delivery_date
        THEN 'Late'

        ELSE 'On time'

    END AS delivery_status,

    COUNT(DISTINCT o.order_id) AS number_of_orders,

    ROUND(
        AVG(r.review_score),
        2
    ) AS average_review_score

FROM orders AS o

INNER JOIN order_reviews AS r
    ON o.order_id = r.order_id

WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL

GROUP BY delivery_status

ORDER BY average_review_score DESC;



-- ============================================================
-- Q3.1 | DELIVERY PERFORMANCE BY REVIEW SCORE
-- ============================================================
-- Metrics:
-- - number of orders
-- - average delivery time
-- - late delivery rate
-- ============================================================

SELECT 
    r.review_score,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    ROUND(AVG(DATEDIFF(o.order_delivered_customer_date,
                    o.order_purchase_timestamp)),
            2) AS average_delivery_days,
    ROUND(AVG(CASE
                WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date THEN 1
                ELSE 0
            END) * 100,
            2) AS late_delivery_rate
FROM
    orders AS o
        INNER JOIN
    reviews AS r ON o.order_id = r.order_id
WHERE
    o.order_status = 'delivered'
        AND o.order_delivered_customer_date IS NOT NULL
        AND r.review_score IN (1 , 2, 3, 4, 5)
GROUP BY r.review_score
ORDER BY r.review_score;



-- ============================================================
-- Q3.2 | PRODUCT CATEGORY AND CUSTOMER SATISFACTION
-- ============================================================
-- Negative review = review score 1 or 2
SELECT 
    ct.product_category_name_english AS product_category,
    COUNT(DISTINCT oi.order_id) AS reviewed_orders,
    ROUND(AVG(r.review_score), 2) AS average_review_score,
    ROUND(AVG(CASE
                WHEN r.review_score <= 2 THEN 1
                ELSE 0
            END) * 100,
            2) AS negative_review_rate
FROM
    order_items AS oi
        INNER JOIN
    products AS p ON oi.product_id = p.product_id
        LEFT JOIN
    category_translation AS ct ON p.product_category_name = ct.product_category_name
        INNER JOIN
    reviews AS r ON oi.order_id = r.order_id
GROUP BY ct.product_category_name_english
HAVING COUNT(DISTINCT oi.order_id) >= 100
ORDER BY negative_review_rate DESC;