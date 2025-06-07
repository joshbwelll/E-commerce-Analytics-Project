# 📦 E-commerce Analytics Project (dbt + DuckDB)

## Project Scenario
I am the analytics engineer at **ShopQuick**, a fictional e-commerce startup.  
The business team wants a reliable reporting model to track customer orders, revenue, and product performance.

## Tech Stack
- **dbt-core**
- **DuckDB**
- **Visual Studio Code**
- **Seed data from CSV files**

---

## 📂 Project Structure
<pre> ```my_ecommerce_project/
├── dbt_project.yml
├── models/
│ ├── staging/
│ │ ├── stg_customers.sql
│ │ ├── stg_orders.sql
│ │ └── stg_products.sql
│ └── marts/
│ ├── order_summary.sql
│ └── schema.yml
├── seeds/
│ ├── customers.csv
│ ├── orders.csv
│ └── products.csv
└── README.md ``` </pre>

---

## ✅ Dbt Workflow: From Initialization to Materialization  

### 1. Seed Data
- Loaded `customers.csv`, `orders.csv`, and `products.csv` using `dbt seed`.

### 2. Staging Models
Created in `models/staging/`:
- `stg_customers.sql`
- `stg_orders.sql`
- `stg_products.sql`

* Cleaned and cast data types  
* Used `ref()` to create lineage

### 3. Reporting Model
Created `models/marts/order_summary.sql`:
- Joined all staging models
- Aggregated **total orders**, **total revenue**, **average order value**
- Grouped by `customer_id` and `category`

### 4. Schema & Tests
- Defined tests and documentation in `schema.yml`:
  - Used data_tests: `not_null`, `unique`, `relationships`
  - Column-level descriptions
  - Schema visual:
  
  <img width="964" alt="image" src="https://github.com/user-attachments/assets/f7943522-88a9-46ee-b562-8cfd63c46519" />


### 5. Jinja & Materializations
- Used `{{ ref() }}` for model chaining
- Materialized `order_summary` as a table
- **My jinja SQL code**:
  ```sql
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
  ```

---

## Result

| customer_id | first_name | category   | total_orders | total_revenue | avg_order_value |
|-------------|------------|------------|--------------|----------------|------------------|
| 1           | Alice      | Stationery | 2            | 55.00          | 27.50           |
| 2           | Bob        | Stationery | 1            | 15.00          | 15.00           |
| 3           | Carla      | Furniture  | 1            | 90.00          | 90.00           |

---
