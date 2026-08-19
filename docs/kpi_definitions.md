# KPI and Metric Definitions

This document lists the main metrics used in this project. Each metric is defined once here, and used the same way across the notebooks, SQL and the dashboard.

Metrics are grouped into three dimensions, kept separate on purpose: a seller can generate a lot of money (commercial) but still deliver late (operational) or get bad reviews (satisfaction). Keeping these apart lets us check if that is actually true, instead of assuming it.

## Commercial performance

| Metric | What it means | How it's calculated | Status |
|---|---|---|---|
| **GMV** (Gross Merchandise Value) | Total value of everything a seller sold on the marketplace. | Sum of `price` across all their order items. | Done — computed in Notebook 2 |
| **Number of orders** | How many different orders a seller took part in. | Count of unique `order_id`. | Done — computed in Notebook 2 |
| **AOV** (Average Order Value) | On average, how much a seller sells per order. | GMV / number of unique orders. Note: this is only the seller's share of the order, not the customer's full basket (which can include other sellers). | Done — computed in Notebook 2 |
| **Observed active period** | How long a seller has been active, based on the data we have. | Date of last sale − date of first sale. | Not done yet |

## Operational performance

| Metric | What it means | How it's calculated | Status |
|---|---|---|---|
| **Average delivery time** | On average, how many days it takes an order to reach the customer. | Delivery date − purchase date. | Not done yet |
| **Late delivery rate** | Share of orders that arrived later than Olist told the customer to expect. | Number of late orders / number of delivered orders. "Late" means delivered after `order_estimated_delivery_date`. | Not done yet |
| **Delivery time variability** | How consistent a seller's delivery times are, not just how fast. | Standard deviation of delivery days per seller. | Not done yet |

## Customer satisfaction

| Metric | What it means | How it's calculated | Status |
|---|---|---|---|
| **Average review score** | On average, how customers rated orders from a seller. | Mean of `review_score` (1 to 5). | Not done yet |

## Notes

- These definitions live in code inside `notebooks/02_eda_business_analysis.ipynb`, in the "Business metrics dictionary" markdown cell. This file is a standalone copy so it can be linked from the README without opening a notebook.
- "Status" reflects what is actually built in the notebook right now, not what is planned. This file will be updated as the analytical dataset grows.
