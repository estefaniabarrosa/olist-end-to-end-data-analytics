# Problem Statement

## Business context

Olist connects sellers with customers through its Brazilian e-commerce marketplace. This project analyzes both marketplace activity (E-Commerce dataset) and the Marketing Funnel (seller acquisition dataset) to understand how seller acquisition connects with commercial performance, operational performance, and customer satisfaction.

**Scope limitation:** of the 842 sellers acquired through the Marketing Funnel, only 380 are observed in the E-Commerce dataset. Any analysis connecting acquisition to downstream marketplace performance (Q1 and Q4) applies only to this observable subset — the remaining 462 sellers are not assumed to be errors; their absence from the marketplace data is a finding to note, not a gap to fill.

## Main business question

How can Olist use data to improve seller acquisition, marketplace performance and customer satisfaction through data-driven business decisions?

## Research questions

### Q1 — Seller acquisition and commercial performance

Which acquisition channels bring sellers that generate stronger marketplace performance after conversion?

**H0:** Seller commercial performance does not differ significantly across acquisition channels.
**H1:** Seller commercial performance differs significantly across acquisition channels.

### Q2 — Marketplace delivery performance

How reliable is delivery performance, and are there meaningful regional differences?

**H0:** Delivery performance does not differ significantly across regions.
**H1:** Delivery performance differs significantly across regions.

### Q3 — Customer satisfaction

Which factors are most associated with lower review scores: delivery delays, product category, or price?

**H0:** Delivery delays, product category, and price are not significantly associated with review scores.
**H1:** At least one of these factors is significantly associated with review scores.

### Q4 — Acquisition, performance and satisfaction

Do sellers acquired through different channels show different downstream marketplace performance and customer experience?

**H0:** Acquisition channel is not significantly associated with differences in seller commercial performance, operational performance, or customer satisfaction.
**H1:** At least one seller performance dimension differs significantly across acquisition channels.

## Analysis technique per question

| Question | Primary technique |
|---|---|
| Q1 | Group comparison (Mann-Whitney/Kruskal-Wallis) on commercial metrics by `origin` / `lead_type`, on the 380-seller observable subset |
| Q2 | Descriptive stats + group comparison on delivery metrics by region (customer/seller state) |
| Q3 | Correlation and hypothesis testing between review_score and delivery delay, category, price |
| Q4 | Cross-dimension comparison of commercial, operational and satisfaction metrics by acquisition channel, on the 380-seller observable subset |

## Notes

This document defines the problem and questions only. Metric definitions live in the Business Metrics Dictionary inside `notebooks/02_eda_business_analysis.ipynb`, and will be summarized in the README once the analysis is complete.
