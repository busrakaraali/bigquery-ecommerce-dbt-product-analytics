# E-commerce Product Analytics — dbt + BigQuery

End-to-end product analytics project built with dbt and BigQuery on the [TheLook E-commerce dataset](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce). Covers funnel conversion, customer segmentation, product performance, and marketing channel analysis.

---

## Dataset

**Source:** [TheLook E-commerce — BigQuery Public Data](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce)

TheLook is a fictitious e-commerce clothing retailer dataset created by the Looker team. It contains transactional and behavioral data across users, orders, products, and clickstream events — making it ideal for realistic product analytics work.

| Table | Description | Key Fields |
|---|---|---|
| `events` | Clickstream events (views, add-to-cart, purchases) | `event_type`, `session_id`, `traffic_source` |
| `users` | Registered user profiles | `age`, `gender`, `country`, `traffic_source` |
| `orders` | Order headers with status and fulfillment timestamps | `status`, `created_at`, `returned_at` |
| `order_items` | Line-level order data | `product_id`, `sale_price`, `status` |
| `products` | Product catalog | `category`, `brand`, `retail_price`, `cost` |

**BigQuery project:** `bigquery-public-data`
**Dataset:** `thelook_ecommerce`

---

## Project Structure

```
models/
├── staging/          # Clean and rename raw source tables (views)
├── intermediate/     # Session grouping, funnel tracking, order aggregation (views)
└── marts/            # Business-facing analytics tables (materialized tables)
```

### Models

**Staging**
- `stg_events` — parsed timestamps, nulls removed, columns renamed
- `stg_users` — cleaned profiles with derived age group field
- `stg_orders` — status flags (`is_complete`, `is_returned`), parsed dates
- `stg_order_items` — line items linked to products and orders
- `stg_products` — catalog with gross margin and margin % calculations

**Intermediate** *(in progress)*
- `int_user_sessions` — events grouped into sessions per user
- `int_funnel_events` — view → cart → purchase tracking per user
- `int_customer_orders` — aggregated order history per customer

**Marts** *(in progress)*
- `mart_funnel_performance` — conversion rates and drop-off by channel
- `mart_customer_segments` — new vs returning, revenue per user
- `mart_product_performance` — top products, category revenue
- `mart_channel_performance` — conversion and revenue by traffic source

---

## Business Questions

- What is the funnel conversion rate from product view to purchase?
- Which traffic channels bring the highest-value customers?
- What share of revenue comes from repeat buyers vs first-time customers?
- Which product categories drive the most margin?
- How does conversion rate vary by age group or gender?

---

## Tools

- **dbt** 1.11 — transformation layer, testing, documentation
- **BigQuery** — cloud data warehouse
- **Python** (plotly / matplotlib) — visualization

---

## How to Run

**Prerequisites:** dbt-bigquery installed, Google Cloud credentials configured

```bash
# Install dependencies
pip install dbt-bigquery

# Authenticate with Google Cloud
gcloud auth application-default login

# Install dbt packages
dbt deps

# Test connection
dbt debug

# Run all models
dbt run

# Run tests
dbt test
```

**Run a specific layer only:**
```bash
dbt run --select staging
dbt run --select intermediate
dbt run --select marts
```
