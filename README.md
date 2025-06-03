# 📦 E-commerce Analytics Project (dbt + DuckDB)

## Project Scenario
I am the analytics engineer at **ShopQuick**, a fictional e-commerce startup.  
The business team wants a reliable reporting model to track customer orders, revenue, and product performance.

## Tech Stack
- **dbt-core**
- **DuckDB**
- **Visual Studio Code**
- Seed data from CSV files

---

## 📂 Project Structure
my_ecommerce_project/
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
└── README.md

---

## ✅ Tasks Completed

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
- Used `schema.yml` to add:
  - `not_null`, `unique`, `relationships` tests
  - Column-level descriptions

### 5. Jinja & Materializations
- Used `{{ ref() }}` for model chaining
- Materialized `order_summary` as a table

---

## 📊 Example Output

| customer_id | first_name | category   | total_orders | total_revenue | avg_order_value |
|-------------|------------|------------|--------------|----------------|------------------|
| 1           | Alice      | Stationery | 2            | 55.00          | 27.50           |
| 2           | Bob        | Stationery | 1            | 15.00          | 15.00           |
| 3           | Carla      | Furniture  | 1            | 90.00          | 90.00           |

---
