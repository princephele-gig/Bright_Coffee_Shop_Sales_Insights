--- Combining Functions to get Clean & Enhanced BIG DATA Query for the entire table
SELECT
      transaction_id,
      transaction_date,
      transaction_time,
      transaction_qty,
      store_id,
      store_location,
      product_id,
      unit_price,
      product_category,
      product_type,
      product_detail,
--- Adding columns to enhance the table for better insights
--- New Column Added 1
      DayName(transaction_date) AS Day_Name,
--- New Column Added 2
      MonthName(transaction_date) AS Month_Name,
--- New Column Added 3      
      DayofMonth(transaction_date) AS Day_of_Month,
--- New Column Added 4 - determining the Day_Classification
CASE
      When DayName(transaction_date) IN ('Sun','Sat') Then 'Weekend'
      Else 'Weekday'
END AS Day_Classification,
--- New Column Added 5 - Time_Classification
CASE
      When Date_format(transaction_time, 'HH:MM:SS') BETWEEN '05:00:00' AND '08:59:59' THEN '01. Morning Rush'
      When Date_format(transaction_time, 'HH:MM:SS') BETWEEN '09:00:00' AND  '11:59:59' THEN '02. Mid Morning'
      When Date_format(transaction_time, 'HH:MM:SS') BETWEEN '12:00:00' AND '15:59:59' THEN '03. Afternoon'
      When Date_format(transaction_time, 'HH:MM:SS') BETWEEN '16:00:00' AND '18:00:00' THEN '04. Evening'
      Else '05. Night'
END AS Time_Classification,
--- New Column Added 6 - Spend Buckets
CASE
      When (transaction_qty*unit_price) <= 50 Then '01. Low Spender'
      When (transaction_qty*unit_price) BETWEEN 51 AND 200 Then '02. Medium Spender'
      When (transaction_qty*unit_price) BETWEEN 201 AND 300 Then '03. High Spender'
      Else '04. Blesser Spender'
END AS Spend_Bucket,
--- New Column Added 76 - Revenue
     unit_price*transaction_qty AS Revenue
From `retail_analysis`.`default`.`bright_coffee_shop_`;
