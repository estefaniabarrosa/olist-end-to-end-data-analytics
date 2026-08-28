# Olist End-to-End Data Analytics

End-to-end data analytics project using **Python, SQL and Tableau** to analyze Olist's Brazilian marketplace ecosystem — connecting seller acquisition, marketplace performance and customer satisfaction into a single data-driven story.

## Business context

Olist connects sellers with customers through its Brazilian e-commerce marketplace. This project analyzes both marketplace activity (E-Commerce dataset) and the seller acquisition funnel (Marketing Funnel dataset) to answer one main question:

> **How can Olist use data to improve seller acquisition, marketplace performance and customer satisfaction through data-driven business decisions?**

Full scope, hypotheses and analysis techniques are documented in [`docs/problem_statement.md`](docs/problem_statement.md).

## Research questions & key findings

| # | Question | Key finding |
|---|---|---|
| **Q1** | Which acquisition channels bring sellers with stronger commercial performance? | `organic_search` sellers show descriptively higher GMV than `paid_search`, but the difference is **not statistically significant**. Acquisition channel alone should not be used to predict seller value. |
| **Q2** | How reliable is delivery performance across regions? | Delivery speed **differs significantly** across Brazilian states — geography is a real operational factor, and slower delivery doesn't always mean less reliable delivery. |
| **Q3** | Which factors most affect customer satisfaction: delivery, category, or price? | Delivery performance has the strongest relationship: **37.8%** of 1-star reviews involve a late delivery, vs. only **3.0%** of 5-star reviews. Category matters too (e.g. `fashion_male_clothing`, `office_furniture`); price has a statistically significant but practically small effect. |

**Business priority:** Olist should prioritize **delivery reliability and regional operational performance**, and investigate the product categories with unusually high dissatisfaction. Acquisition channel remains relevant for acquisition strategy, but not as a standalone predictor of future seller performance.

**A note on scope:** of the 842 sellers acquired through the Marketing Funnel, only 380 (45.13%) are observed actually selling in the E-Commerce dataset. This is treated as a documented finding, not a data error — see [`docs/data_sources.md`](docs/data_sources.md) for the full explanation.

A fourth question (cross-dimension comparison by acquisition channel) was originally scoped but dropped: given the time available, the project prioritized depth on three well-supported questions over breadth across four. See [`docs/problem_statement.md`](docs/problem_statement.md) for the full scope decision.

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
├── docs/
│   ├── problem_statement.md   # Business questions, hypotheses, scope
│   ├── data_sources.md        # Dataset origin, tables, row counts
│   ├── data_dictionary.md     # Keys, relationships, cleaning decisions
│   └── kpi_definitions.md     # Metric definitions used across notebooks/SQL/dashboard
└── requirements.txt
```

## Tech stack

- **Python** (pandas, numpy, scipy, matplotlib, seaborn) — data cleaning, EDA, statistical hypothesis testing
- **SQL / MySQL** (SQLAlchemy, PyMySQL) — relational modeling and business queries, cross-validated against the Python results
- **Tableau** — dashboard for delivery performance and customer satisfaction *(in progress — CSV extracts are ready in `tableau/`, published dashboard link to be added here once complete)*

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

## Documentation

| File | Contents |
|---|---|
| [`docs/problem_statement.md`](docs/problem_statement.md) | Business context, research questions, hypotheses, analysis techniques |
| [`docs/data_sources.md`](docs/data_sources.md) | Dataset origin, tables, row counts, how the two datasets connect |
| [`docs/data_dictionary.md`](docs/data_dictionary.md) | Primary keys, relationships, cleaning/renaming decisions |
| [`docs/kpi_definitions.md`](docs/kpi_definitions.md) | Definition and status of every metric used across notebooks, SQL and the dashboard |

## Project status

Data cleaning, EDA, hypothesis testing and SQL/Python integration are complete. The Tableau dashboard is the last piece in progress — this README will be updated with the published link once it's ready.
