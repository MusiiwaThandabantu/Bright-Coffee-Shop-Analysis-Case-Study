SELECT 
--- Dates

      transaction_date AS Purchase_date,
      Dayname(transaction_date) AS Day_name,
      Monthname(transaction_date) AS Month_name,
      Dayofmonth(transaction_date) AS day_of_month,

CASE 
        WHEN Day_name IN('Sat','Sun') THEN 'Weekend'
        ELSE 'Weekdays'
END AS Day_classification,

     -- date_format(transaction_time, 'HH:mm:ss')

CASE
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
END AS time_buckets,

--- Count of IDs
      COUNT(DISTINCT transaction_id) AS Number_of_sales,
      COUNT(DISTINCT product_id) AS Number_of_products,
      COUNT(DISTINCT store_id) AS Number_of_stores,
--- Revenue
      SUM(transaction_qty*unit_price) AS revenue_per_day,
  
--- Spending 
CASE
    WHEN revenue_per_day <=50 THEN 'Low Spend'
    WHEN revenue_per_day BETWEEN 52 AND 100 THEN 'Medium Spend'
    ELSE 'High Spend'
END AS spend_bucket,

--- Categorical Columns
    store_location,
    product_category,
    product_detail
FROM `bright_coffee_shop`.`default`.`bright_coffee_shop_analysis`
GROUP BY transaction_date,
         Dayname(transaction_date),
         Monthname(transaction_date),
  
---- Checking if its Weekend or Weekdays
CASE 
    WHEN Day_name IN('Sat','Sun') THEN 'Weekend'
    ELSE 'Weekdays'
END,

     -- date_format(transaction_time, 'HH:mm:ss')

CASE
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '05:00:00' AND '11:59:59' THEN 'Morning'
    WHEN date_format(transaction_time, 'HH:mm:ss') BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN date_format(transaction_time, 'HH:mm:ss') >= '17:00:00' THEN 'Evening'
END,
        store_location,
         product_category,
         product_detail;
