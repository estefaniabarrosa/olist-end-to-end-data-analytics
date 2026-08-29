# Recommendations

Each recommendation follows Finding → So what → Action → Impact, prioritized by impact vs. effort. Full narrative and limitations context in `docs/presentation_narrative.md`.


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

