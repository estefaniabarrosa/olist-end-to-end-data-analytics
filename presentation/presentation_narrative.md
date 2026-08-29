# Presentation Narrative, Recommendations & Limitations

This document is the bridge between the analysis (Notebooks 1-3, SQL, dashboard) and the presentation deck. It answers: what's the one thing we want the audience to remember, what should Olist actually do about it, and what are we honest about not knowing.

---

## 1. Narrative arc

### The one key message

> **Olist's biggest lever for customer satisfaction isn't who sells or what they charge — it's whether the order arrives on time. That single factor explains more of the gap between a 1-star and a 5-star review than seller acquisition channel or price ever did.**

### Opening hook

*"Only 3% of 5-star reviews involve a late delivery. For 1-star reviews, that number is 37.8% — more than 12 times higher."*

This is the number that reframes the whole presentation: the audience assumes the interesting story is about *which sellers* or *which marketing channel* — the data says the interesting story is about *logistics*.

### The 5-beat arc

1. **Context** — Olist runs a marketplace connecting ~3,000 Brazilian sellers to customers. Growth depends on three things working together: acquiring the right sellers, delivering reliably, and keeping customers happy.
2. **Problem** — With limited time and budget, which of these three actually moves the needle, and where should Olist focus first? We tested this directly against ~100k real orders instead of assuming.
3. **Investigation** — Three research questions, each tested with real hypothesis testing (Kruskal-Wallis, ANOVA, group comparisons), not just descriptive charts: does acquisition channel predict seller performance? Does delivery performance vary by region? What actually drives review scores?
4. **Turning point** — The variable everyone assumes matters — acquisition channel — turned out to have **no statistically significant relationship** with seller GMV. The variable that looks like an operational afterthought — delivery timing — turned out to be the dominant, statistically confirmed driver of satisfaction, and it varies sharply by region (e.g. Roraima: 29.3 avg delivery days, 12.2% late rate).
5. **Resolution** — Stop treating acquisition channel as a proxy for seller quality. Start treating delivery reliability — especially in the worst-performing states — as the highest-leverage investment for customer experience.

### The 3 insights that carry the story

*(Everything else in the analysis is real and documented, but these are the three the presentation should be built around — cut the rest to appendix slides.)*

1. Delivery timeliness is the strongest, most actionable driver of customer satisfaction (37.8% vs. 3.0%).
2. Delivery performance varies significantly by region — this is where operational fixes should be targeted first, not applied uniformly.
3. Acquisition channel does *not* significantly predict seller commercial performance — it should stop being used as a seller-quality signal.

### Closing line

> *"Olist doesn't have an acquisition problem. It has a delivery problem wearing an acquisition costume — and that's exactly the kind of finding that changes where a company spends its next dollar."*

---

## 2. Recommendations

Each recommendation follows Finding → So what → Action → Impact, prioritized by impact vs. effort.

### 1. Fix delivery reliability in the worst-performing states first — **Priority 1: High impact, medium effort**

- **Finding:** Late deliveries are associated with a review score of 2.57 vs. 4.29 for on-time deliveries, and appear in 37.8% of 1-star reviews vs. 3.0% of 5-star reviews.
- **So what:** Delivery reliability is the single highest-leverage lever Olist has for customer satisfaction — more than category curation or pricing.
- **Action:** Set a late-delivery monitoring/alert threshold by state; prioritize renegotiating logistics/carrier terms in the worst-performing states first (e.g. states combining high delivery times with high late rates, such as Roraima).
- **Impact:** Even a moderate reduction in late-delivery rate in the bottom 3-5 states should measurably lift average review scores, given how steep the score gap is between on-time and late orders.
- **Owner:** Operations / Logistics team.

### 2. Treat delivery as a regional problem, not a national average — **Priority 2: High impact, medium-high effort**

- **Finding:** Delivery time and late-delivery rate differ significantly across customer states (confirmed statistically, not just descriptively).
- **So what:** A single national SLA hides the fact that some regions are performing fine and others are badly underperforming — averaging them together wastes effort on the wrong places.
- **Action:** Segment carrier and fulfillment strategy by region; start with states that combine high order volume with high late-delivery rate, where fixing delivery affects the most customers.
- **Impact:** Targeted regional intervention reaches the customers most affected without renegotiating national contracts across the board.
- **Owner:** Regional Operations leads.

### 3. Audit the specific product categories with elevated dissatisfaction — **Priority 3 (quick win): Medium impact, low-medium effort**

- **Finding:** Categories including `fashion_male_clothing`, `office_furniture`, `audio` and `construction_tools_safety` show disproportionately high negative review rates, even accounting for sample size.
- **So what:** Some dissatisfaction is category-specific, not delivery-specific — likely a product-quality or fulfillment issue within those categories that a logistics fix won't touch.
- **Action:** Audit sellers and products within these categories for quality or fulfillment problems; consider category-specific seller vetting or quality standards.
- **Impact:** Improves satisfaction in exactly the pockets where delivery fixes alone won't move the needle.
- **Owner:** Category management / Seller quality team.

### 4. Stop using acquisition channel as a seller-quality signal — **Priority 1 (quick win): Low effort, correction**

- **Finding:** Acquisition channel shows no statistically significant relationship with seller GMV, despite descriptive differences between channels.
- **So what:** Using "which channel brought this seller" to justify marketing spend or predict seller value isn't supported by the data.
- **Action:** Remove acquisition channel as a standalone seller-quality proxy in marketing/ops reporting; if channel-based evaluation continues, pair it with actual post-onboarding performance data.
- **Impact:** Avoids misallocating marketing budget and evaluation effort based on a signal that doesn't predict what it's assumed to predict.
- **Owner:** Marketing / Seller Acquisition team.

### 5. Investigate the 462 "missing" acquired sellers — **Priority 2 (quick win): Medium impact, low effort**

- **Finding:** Of the 842 sellers acquired through the Marketing Funnel, 462 (54.9%) never appear in the marketplace transaction data.
- **So what:** A majority of acquired sellers may be dormant, stuck in onboarding, or simply unmatched due to a tracking gap — either way, acquisition spend may be going to sellers who never sell.
- **Action:** Reconcile `seller_id` matching first to rule out a data-linkage issue; if the gap is real, investigate onboarding friction as the likely cause.
- **Impact:** Could recover marketing ROI insight or surface a fixable onboarding bottleneck — currently unknown, which is itself the finding worth presenting.
- **Owner:** Marketing Ops + Data team.

---

## 3. Limitations, assumptions & next steps

### Data limitations

- **Coverage:** only 380 of 842 (45.1%) sellers acquired through the Marketing Funnel are observable in the marketplace data. Q1 and any acquisition-linked finding apply only to this observable subset, not the full acquired population.
- **Recency:** the dataset spans 2016-2018. Olist's logistics partners, market conditions and seller base have likely changed materially since — findings describe that period, not necessarily today.
- **Granularity:** review scores and delivery dates are recorded at the order level, not the delivery-leg or carrier level — we can't isolate whether a delay was the seller's, the carrier's, or Olist's fulfillment process.
- **No repeat-purchase or churn data:** we can measure review scores but not whether dissatisfaction translates into a customer leaving the platform.

### Methodological assumptions

- Statistical tests used a standard significance threshold (α = 0.05); no multiple-comparison correction was applied across the three research questions, which is a limitation specifically relevant to the "acquisition channel is not significant" finding.
- "Negative review" is defined as a score of 1 or 2; "late delivery" is defined against Olist's own estimated delivery date, not a customer-stated expectation.
- Category-level analysis was restricted to categories with at least 100 reviewed orders, to avoid small-sample noise — smaller categories were not evaluated and could hide their own patterns.

### What I would do with 3 more months

- Build a multivariate model (regression, not just single-factor group comparisons) to isolate the effects of delivery time, category and price on review score simultaneously, controlling for confounds the current pairwise tests can't separate.
- Investigate the 462 unmatched Marketing Funnel sellers directly (data-linkage issue vs. genuine non-conversion).
- Add a time dimension: is regional delivery performance improving, worsening, or converging across the 2016-2018 window?
- Connect the dashboard live to the database instead of static CSV exports, and extend the SQL analysis with window functions for seller-level cohort/retention behavior.

### 2-3 concrete next analyses

1. A regression model predicting review score from delivery time, category, price and region together — separating out what the current one-factor-at-a-time tests can't.
2. A seller-level cohort analysis: do sellers who start out with late deliveries stay late, or improve over their lifetime on the platform? (Needs SQL window functions — ties directly to extending the current SQL analysis.)
3. A root-cause investigation into the 462 unmatched acquired sellers — the single biggest unresolved question this project surfaced.
