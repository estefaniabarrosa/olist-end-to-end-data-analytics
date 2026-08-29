# Olist End-to-End Data Analytics

End-to-end data analytics project using **Python, SQL and Tableau** to analyze Olist's Brazilian marketplace ecosystem — connecting seller acquisition, marketplace performance and customer satisfaction into a single data-driven story.

## Business context

Olist connects sellers with customers through its Brazilian e-commerce marketplace. This project analyzes both marketplace activity (E-Commerce dataset) and the seller acquisition funnel (Marketing Funnel dataset) to answer one main question:

> **How can Olist use data to improve seller acquisition, marketplace performance and customer satisfaction through data-driven business decisions?**

Full scope, hypotheses and analysis techniques are documented in [`docs/problem_statement.md`](docs/problem_statement.md).

## Research questions & key findings

| # | Question | Key finding |
|---|---|---|
| **Q1** | Which acquisition channels bring sellers with stronger commercial performance? | `organic_search` sellers show descriptively higher GMV than `paid_search`, but the difference is **not statistically significant** (ANOVA p = 0.59; Kruskal-Wallis p = 0.38). Acquisition channel alone should not be used to predict seller value. |
| **Q2** | How reliable is delivery performance across regions? | Delivery reliability **differs significantly** across Brazilian states — from 5.6% late in Minas Gerais to 23.9% in Alagoas, against a national average of 8.1%. Ranking states by *share of total late deliveries* rather than by rate identifies Rio de Janeiro as the priority: 13.5% late on the second-highest order volume, accounting for **21% of all late deliveries** in the marketplace. |
| **Q3** | Which factors most affect customer satisfaction: delivery, category, or price? | Delivery timing has the strongest relationship: on-time orders average **4.29 stars** vs **2.57** for late ones, and **37.8%** of 1-star reviews involve a late delivery vs only **3.0%** of 5-star reviews. Category matters too (e.g. `fashion_male_clothing`, `office_furniture`); price is statistically significant but practically negligible. |

**Business priority:** Olist should prioritize **delivery reliability and regional operational performance**, starting with the states where a high late-delivery rate meets meaningful order volume, and investigate the product categories with unusually high dissatisfaction. Acquisition channel remains relevant for acquisition strategy, but not as a standalone predictor of future seller performance.

**A note on scope:** of the 842 sellers acquired through the Marketing Funnel, only 380 (45.13%) are observed actually selling in the E-Commerce dataset. This is treated as a documented finding, not a data error — see [`docs/data_sources.md`](docs/data_sources.md) for the full explanation. It also means the Q1 conclusion is conditioned on sellers who made at least one sale, which is a survivorship limitation, not a neutral sample.

A fourth question (cross-dimension comparison by acquisition channel) was originally scoped but dropped: given the time available, the project prioritized depth on three well-supported questions over breadth across four. See [`docs/problem_statement.md`](docs/problem_statement.md) for the full scope decision.

## Statistical approach

Every business conclusion is backed by a formal test, not a visual reading of a chart:

| Test | Used for | Result |
|---|---|---|
| Shapiro-Wilk | Normality of seller GMV across acquisition channels | Rejected normality (p < 0.001 for all four channels) |
| One-way ANOVA | Seller GMV across the four main acquisition channels | F = 0.64, p = 0.59 — not significant |
| Kruskal-Wallis | Same comparison, without the normality assumption | H = 3.09, p = 0.38 — same conclusion, confirming the ANOVA result is not an artefact of the failed assumption |
| Welch's t-test | Review score, on-time vs late deliveries | t = 89.4, p < 0.001 — significant |
| One-way ANOVA | Review score across product categories, and price across review scores | Both significant, but with much smaller practical differences than delivery |

Significance level α = 0.05 throughout. All three factors in Q3 are statistically significant at ~100k orders, so findings are ranked by the size of the observed difference rather than by p-value alone.

## Repository structure

```
├── data/
│   ├── raw/              # Original Kaggle CSVs, untouched
│   └── processed/        # Cleaned datasets exported from Notebook 01
├── notebooks/
│   ├── 01_data_wrangling_cleaning.ipynb    # Cleaning, validation, relational checks
│   ├── 02_eda_business_analysis.ipynb      # EDA, hypothesis testing, business conclusions
│   └── 03_sql_python_integration.ipynb     # Python → MySQL → SQL analysis → validation
├── sql/
│   ├── olist_business_analysis.sql         # Standalone SQL business queries
│   └── erd_olist.mwb                       # Entity-relationship diagram (MySQL Workbench)
├── tableau/              # CSV extracts prepared for the Tableau dashboard
├── dashboards/           # Tableau workbook (.twb / .twbx)
├── presentation/         # Final presentation deck and narrative
├── docs/
│   ├── problem_statement.md   # Business questions, hypotheses, scope
│   ├── data_sources.md        # Dataset origin, tables, row counts
│   ├── data_dictionary.md     # Keys, relationships, cleaning decisions
│   ├── kpi_definitions.md     # Metric definitions used across notebooks/SQL/dashboard
│   └── recommendations.md     # Full set of business recommendations
└── requirements.txt
```

## Tech stack

- **Python** (pandas, numpy, scipy, matplotlib, seaborn) — data cleaning, EDA, statistical hypothesis testing
- **SQL / MySQL** (SQLAlchemy, PyMySQL) — relational modeling and business queries, including CTEs and window functions (`RANK() OVER`, `SUM() OVER`) for state-level prioritisation; cross-validated against the Python results
- **Tableau** — seven-sheet interactive dashboard with cross-filtering, covering marketplace overview, acquisition channel performance, regional delivery and category-level satisfaction

## Deliverables

| Deliverable | Location |
|---|---|
| Cleaning & validation | [`notebooks/01_data_wrangling_cleaning.ipynb`](notebooks/01_data_wrangling_cleaning.ipynb) |
| EDA & hypothesis testing | [`notebooks/02_eda_business_analysis.ipynb`](notebooks/02_eda_business_analysis.ipynb) |
| SQL integration & validation | [`notebooks/03_sql_python_integration.ipynb`](notebooks/03_sql_python_integration.ipynb) |
| Business SQL queries | [`sql/olist_business_analysis.sql`](sql/olist_business_analysis.sql) |
| Tableau dashboard | [`dashboards/`](dashboards/) |
| Final presentation | [`presentation/`](presentation/) |
| Business recommendations | [`docs/recommendations.md`](docs/recommendations.md) |

## Data sources

Two public datasets published by Olist on Kaggle (real, anonymized operational data, ~100k orders from 2016–2018), joined through `closed_deals.seller_id`. Full details, table-by-table row counts and match rates in [`docs/data_sources.md`](docs/data_sources.md).

## Setup & reproducibility

**Prerequisites:** Python 3.11+ and a running local MySQL server (only needed for Notebook 03).

1. Clone the repo and install dependencies:
   ```bash
   git clone https://github.com/estefaniabarrosa/olist-end-to-end-data-analytics.git
   cd olist-end-to-end-data-analytics
   pip install -r requirements.txt
   ```
2. Run the notebooks **in order** — each one depends on the outputs of the previous one:
   - `01_data_wrangling_cleaning.ipynb` reads `data/raw/` and writes the cleaned CSVs to `data/processed/`.
   - `02_eda_business_analysis.ipynb` reads `data/processed/` and produces the EDA, hypothesis tests and business conclusions.
   - `03_sql_python_integration.ipynb` uploads the cleaned data to a local MySQL database (`olist_project`) and reproduces the core metrics in SQL. When run, it will prompt for your local MySQL password via `getpass` — no credentials are stored in the notebook or the repo.
3. The standalone SQL queries in `sql/olist_business_analysis.sql` can be run directly against the `olist_project` database once Notebook 03 has created it.

Note: both `data/raw/` and `data/processed/` are committed so the notebooks can be run without an external download. This makes the repository large (~220 MB); a production setup would keep raw data out of version control and fetch it from source instead.

## Documentation

| File | Contents |
|---|---|
| [`docs/problem_statement.md`](docs/problem_statement.md) | Business context, research questions, hypotheses, analysis techniques |
| [`docs/data_sources.md`](docs/data_sources.md) | Dataset origin, tables, row counts, how the two datasets connect |
| [`docs/data_dictionary.md`](docs/data_dictionary.md) | Primary keys, relationships, cleaning/renaming decisions |
| [`docs/kpi_definitions.md`](docs/kpi_definitions.md) | Definition and status of every metric used across notebooks, SQL and the dashboard |
| [`docs/recommendations.md`](docs/recommendations.md) | Full set of business recommendations, including the two not covered in the presentation |

## Limitations & next steps

**Limitations**

- **Coverage** — acquisition findings apply only to the 380 observable sellers (45.1%), not all 842 acquired. Because the sample is conditioned on having made at least one sale, channels that lose sellers before their first sale would not be visible in this comparison.
- **Recency** — the data spans 2016–2018; logistics and market conditions have likely changed since.
- **Granularity** — order-level data cannot isolate whether a delay originated with the seller, the carrier, or Olist.
- **Association, not causation** — the delivery/satisfaction relationship is strong and consistent, but this analysis does not establish causality.

**Next steps**

- Multivariate regression isolating delivery, category and price effects on review score together.
- Root-cause investigation into the 462 unmatched acquired sellers — the biggest open question.
- Seller-level cohort analysis, extending the window-function queries: do sellers with poor early delivery performance improve as they mature?

## Project status

Complete. Data cleaning, EDA, hypothesis testing, SQL/Python integration, the Tableau dashboard and the final presentation are all delivered and documented in this repository.
