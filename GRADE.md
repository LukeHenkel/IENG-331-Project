# Milestone 1 Grade

| Criterion | Score | Max |
|-----------|------:|----:|
| Data Quality Audit | 3 | 3 |
| Query Depth & Correctness | 2 | 3 |
| Business Reasoning & README | 2 | 3 |
| Git Practices | 3 | 3 |
| Code Walkthrough | 3 | 3 |
| **Total** | **13** | **15** |

## Data Quality Audit (3/3)
`data_quality.sql` executes cleanly and is the most complete piece of work in the repo. It is well-structured with six separate CTEs covering: row counts for all 9 tables, NULL rate profiling for a key column, orphaned foreign key detection (orders → customers), date range coverage for two timestamp fields, monthly gap detection using `LAG()` window function, and duplicate detection. This is exactly the kind of systematic, multi-dimensional profiling the rubric calls for. Full credit.

## Query Depth & Correctness (2/3)
Four analytical query files exist (without `.sql` extension, stored as plain files inside named folders). Only one executes without errors:

- **ABC_Inventory_Classification** — Runs successfully. 2 CTEs, joins across `order_items`, `orders`, and `products`, and aggregation. However, the described Pareto classification (A/B/C tiers using cumulative revenue %) is not implemented — the file ends at a ranked revenue list with no window-function-based tier assignment.
- **Cohort_Retention_Analysis** — Does not execute. Parser error on lines 37–39: `CASE WHEN ... THEN 1 ELSE 0)` is missing the `END` keyword in all three retention SUM expressions. The logic is well-conceived (4 CTEs, date diff calculations, cohort grouping), and the error is a minor syntax slip.
- **Delivery_time_analysis_by_Geography** — Does not execute. Two bugs: `DATE DIFF(...)` should be `DATE_DIFF(...)` (space in function name), and a column is referenced as `order_estimated_customer_date_customer_date` (duplicated suffix). 3 CTEs, multi-table join, aggregation by state.
- **Seller_Performance_Scorecard** — Does not execute. Missing comma between `oi.seller_id` and `AVG(...)` in the `seller_reviews` CTE, and `sr.seller.id` should be `sr.seller_id`. This is the most sophisticated query: 4 CTEs, `RANK()` window function, 4-way join across `order_items`, `orders`, `order_reviews`, and a derived scorecard CTE.

Three of four analytical files have syntax errors preventing execution. The ambition and structure are strong — errors are minor and fixable — but correctness is required for full credit.

## Business Reasoning & README (2/3)
The README identifies four meaningful, specific business questions (cohort retention, seller performance scoring, ABC inventory classification, geographic delivery analysis) and explains the key SQL concepts applied to each. The stated goal — filtering to delivered orders only for business accuracy — reflects genuine analytical reasoning. However, the README does not discuss actual findings, does not acknowledge limitations (e.g., the dataset's one-sided customer-order model making true retention rare), and does not explain alternative approaches considered. The "Key Concepts" bullet lists read more like a technical checklist than a narrative about what was learned from the data.

## Git Practices (3/3)
Approximately 30 commits with clear, incremental messages that document logical progression: e.g., "First orders" → "Join second orders onto first" → "30, 60, 90 day second orders" → "Display and round 2 decimals for 30,60,90". The data quality script shows similarly stepwise commits ("add audit queries" → "add null rate checks" → "add orphan foreign key checks" → "add monthly gap detection using window functions" → "add duplicate detection checks"). Merges from remote are present, showing normal collaborative workflow. Excellent git hygiene.
