WITH cte AS(SELECT
  c.customer_id,
  c.first_name,
  o.order_id,
  o.product_id,
  o.quantity,
  o.total_amount
FROM {{ ref("stg_customers") }} c
JOIN {{ ref("stg_orders") }} o
ON c.customer_id = o.customer_id
)
SELECT
  cte.customer_id,
  cte.first_name,
  p.category,
  COUNT(order_id) AS total_orders,
  SUM(cte.total_amount) AS total_revenue,
  SUM(cte.total_amount) / COUNT(order_id) AS avg_order_value
FROM cte 
JOIN {{ ref("stg_products") }} p
ON cte.product_id = p.product_id
GROUP BY
  cte.customer_id,
  p.category,
  cte.first_name
