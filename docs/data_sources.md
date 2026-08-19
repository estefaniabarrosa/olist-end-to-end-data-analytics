# Data Sources

This project uses two public datasets published by Olist, a Brazilian marketplace. Both are real, anonymized operational data — not synthetic or fictional data.

## 1. Brazilian E-Commerce Public Dataset by Olist

- **Source:** [kaggle.com/datasets/olistbr/brazilian-ecommerce](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)
- **What it is:** ~100k real orders placed on the Olist marketplace between 2016 and 2018, split across 9 relational tables.
- **Used for:** marketplace performance, delivery, reviews, sellers, products, geography.

| Table | Rows (after cleaning) | What one row means |
|---|---|---|
| customers | 99,441 | one customer record per order |
| orders | 99,441 | one order |
| order_items | 112,650 | one item inside an order (an order can have several) |
| payments | 103,886 | one payment record (an order can have more than one payment) |
| reviews | 99,224 | one review per order |
| products | 32,951 | one product |
| sellers | 3,095 | one seller |
| geolocation | 738,332 | one lat/long observation per zip code (many per zip code) |
| category_translation | 71 | English name for each product category |

## 2. Marketing Funnel by Olist

- **Source:** same Kaggle publisher, companion dataset to the E-Commerce one.
- **What it is:** the lead-generation and sales process Olist used to acquire sellers, before those sellers started selling.
- **Used for:** seller acquisition channel, lead type, business segment.

| Table | Rows (after cleaning) | What one row means |
|---|---|---|
| mql (Marketing Qualified Leads) | 8,000 | one lead |
| closed_deals | 842 | one lead that converted into a seller |

## How the two datasets connect

`closed_deals.seller_id` is the bridge between the Marketing Funnel and the E-Commerce data. This connection was checked in Notebook 1 (section 12):

- Of the 842 sellers acquired through Marketing, only **380** are found selling in the E-Commerce data. The other 462 are not assumed to be a data error — this is treated as a finding to explore during EDA, not a bug to fix.
- Because of this, any analysis that mixes acquisition data with marketplace performance (business questions 1 and 4) only covers those 380 sellers, not all 842.

## Scale used in this project vs. the full dataset

Most of the EDA and SQL work will run on the full ~100k-order E-Commerce dataset. The Marketing Funnel join is a smaller, secondary analysis limited to the 380 observable sellers — it answers a different, narrower question (which acquisition channel performs best), not the main marketplace analysis.

## Data folder structure

- `data/raw/` — original files as downloaded from Kaggle, untouched.
- `data/processed/` — cleaned CSVs exported from `notebooks/01_data_wrangling_cleaning.ipynb`, used by all later notebooks.
