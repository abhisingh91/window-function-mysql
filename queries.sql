-- Average price with OVER
SELECT
	asin,
    brand,
    price,
    AVG(price) OVER() avg_price
FROM products;

-- Average, minimum, and maximum price with OVER
SELECT
	asin,
    brand,
    price,
    AVG(price) OVER() avg_price,
    MIN(price) OVER() min_price,
    MAX(price) OVER() max_price
FROM products;

-- Difference from average price with OVER
SELECT
	asin,
    brand,
    price,
    ROUND(AVG(price) OVER(), 2) AS avg_price,
    ROUND(price - AVG(price) OVER(), 2) AS diff_from_avg
FROM products;

-- Percent of the average price with OVER
SELECT
	asin,
    brand,
    price,
    ROUND(AVG(price) OVER(), 2) avg_price,
    ROUND(price/AVG(price) OVER() * 100, 2) percent_avg_price
FROM products;

-- Percent difference from the average price
SELECT
	asin,
    brand,
    price,
    ROUND(AVG(price) OVER(), 2) avg_price,
    ROUND((price/AVG(price) OVER() - 1) * 100, 2) percent_diff_avg_price
FROM products;

-- PARTITION BY

-- PARTITION BY brand
SELECT
	asin,
    brand,
    price,
    ROUND(AVG(price) OVER(PARTITION BY brand), 2) AS avg_brand_price
FROM products;

-- Brand price delta
SELECT
	asin,
    brand,
    price,
    ROUND(AVG(price) OVER(PARTITION BY brand), 2) AS avg_brand_price,
    ROUND(price - AVG(price) OVER(PARTITION BY brand), 2) AS brand_price_delta
FROM products;
-- Brand price delta 0 indicates that there is only one product from that specific brand

-- ROW NUMBER

-- overall price rank
SELECT
	asin,
    brand,
    price,
    ROW_NUMBER() OVER(ORDER BY price DESC) overall_price_rank
FROM products;

-- brand price rank
SELECT
	asin,
    brand,
    price,
    ROW_NUMBER() OVER(ORDER BY price DESC) overall_price_rank,
    ROW_NUMBER() OVER(PARTITION BY brand ORDER BY price DESC) brand_price_rank
FROM products;

-- Top 3 brand prices
SELECT
	asin,
    brand,
    price,
    ROW_NUMBER() OVER(ORDER BY price DESC) overall_price_rank,
    ROW_NUMBER() OVER(PARTITION BY brand ORDER BY price DESC) brand_price_rank,
    CASE
		WHEN ROW_NUMBER() OVER(PARTITION BY brand ORDER BY price DESC) <= 3 THEN 'Yes'
        ELSE 'No'
	END AS top_3_flag
FROM products;

-- RANK
SELECT
	asin,
    brand,
    price,
    ROW_NUMBER() OVER(ORDER BY price DESC) overall_price_rank,
    RANK() OVER(ORDER BY price DESC) overall_price_rank_w_rank
FROM products;

-- DENSE RANK
SELECT
	asin,
    brand,
    price,
    ROW_NUMBER() OVER(ORDER BY price DESC) overall_price_rank,
    RANK() OVER(ORDER BY price DESC) overall_price_rank_w_rank,
    DENSE_RANK() OVER(ORDER BY price DESC) overall_price_rank_w_dense_rank
FROM products;

-- Running total of prices overall
SELECT
    asin,
    brand,
    price,
    ROUND(SUM(price) OVER(ORDER BY price), 2) AS running_total
FROM products;

-- Moving average of prices
SELECT
	asin,
    brand,
    price,
    ROUND(SUM(price) OVER(ORDER BY price), 2) AS running_total,
    ROUND(AVG(price) OVER(ORDER BY price ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) moving_average
FROM products;

-- Percentile price rank
SELECT
	asin,
    brand,
    price,
    PERCENT_RANK() OVER(PARTITION BY brand) AS percentile_price_rank
FROM products;

-- Nth Value of price (in this case 2nd highest)
SELECT
	asin,
    brand,
    price,
    NTH_VALUE(price, 2) OVER(ORDER BY price DESC) AS second_highest_price
FROM products;

-- LAG by 1 period
SELECT
	asin,
    brand,
    obs_date,
    price,
    LAG(price) OVER(PARTITION BY brand ORDER BY obs_date) AS lag_price
FROM products;

-- LAG by 2 period
SELECT
	asin,
    brand,
    obs_date,
    price,
    LAG(price, 2) OVER(PARTITION BY brand ORDER BY obs_date) AS lag_price
FROM products;

-- LEAD by a period
SELECT
	asin,
    brand,
    obs_date,
    price,
    LEAD(price) OVER(PARTITION BY brand ORDER BY obs_date) AS lead_price
FROM products;
