# Data Dictionary (short version)

This is not a full column-by-column dictionary yet. It only covers what was actually checked and decided in Notebook 1: primary keys, how tables connect, and the few columns that were dropped or renamed.

A bigger reason this file is short: most of the 11 datasets were already clean. There was very little to fix — no messy column names (except one typo), almost no columns to drop, and only one small text-formatting issue in the whole project. That is a real finding, not a step we skipped.

## Primary keys (one row per this column)

| Table | Primary key | Confirmed unique? |
|---|---|---|
| customers | `customer_id` | Yes |
| orders | `order_id` | Yes |
| products | `product_id` | Yes |
| sellers | `seller_id` | Yes |
| mql | `mql_id` | Yes |
| closed_deals | `mql_id` | Yes |

`order_items`, `payments`, `reviews` and `geolocation` do not have a single unique key — they are expected to have several rows per order (or per zip code), which is normal for this kind of data.

## How tables connect (foreign keys)

| From | To | Column | Match rate |
|---|---|---|---|
| orders | customers | `customer_id` | 100% |
| order_items | orders | `order_id` | 100% |
| order_items | products | `product_id` | 100% |
| order_items | sellers | `seller_id` | 100% |
| closed_deals | mql | `mql_id` | 100% |
| closed_deals | sellers | `seller_id` | 45.13% (380 of 842 — see `data_sources.md`) |

## Columns dropped

| Table | Column | Why |
|---|---|---|
| reviews | `review_comment_title` | Free-text field, mostly empty, not needed for this project (no text/sentiment analysis planned). |
| reviews | `review_comment_message` | Same reason as above. |

That's it — no other columns were removed. Everything else was kept, including columns with missing values, because the missing values were explained and documented instead of just deleted (see the "Findings and cleaning decision" sections in Notebook 1).

## Columns renamed

| Table | Old name | New name | Why |
|---|---|---|---|
| products | `product_name_lenght` | `product_name_length` | Fixed a spelling typo in the original dataset. |
| products | `product_description_lenght` | `product_description_length` | Same reason. |

## Still pending

A full description of every column (name, type, unit, example, % missing, keep/drop) has not been written yet. If it's needed for the rubric, this file can be extended later, table by table.
