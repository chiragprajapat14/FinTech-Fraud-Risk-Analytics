# FinTech Credit Card Fraud Detection & Risk Analytics

## 📌 Project Overview
This repository implements an end-to-end data analytics framework modeling a neobank's credit transaction ledger. The analysis targets credit limit breaches, high-risk unverified compliance profiles, velocity multi-swipe attack sequences, and cross-border anti-money laundering (AML) revenue leakage.

The project demonstrates advanced database optimization queries used to shield company operating margins from bad actors and compliance defaults.

## 🛠️ Tech Stack & Advanced SQL Highlights
* **Core Framework**: MySQL Engine
* **Advanced Commands Demonstrated**:
  * High-Frequency Sequence Tracking (`LAG() OVER (PARTITION BY ... ORDER BY)`)
  * Global Risk Distribution Ratios (`SUM(x) / SUM(SUM(x)) OVER()`)
  * Relational Financial Risk Ceilings (`HAVING SUM(amount) > 0.80 * Limit`)
  * String Multi-Category Aggregations (`GROUP_CONCAT(DISTINCT ... SEPARATOR)`)
  * Secure Multi-Table Joins linking transaction logs, card tiers, and customer KYC sheets.

---

## 📊 Database Architecture Design
The architecture runs across three highly secure relational tables:
1. **`bank_customers`**: Master client record storing credit bureau scores and KYC identification statuses.
2. **`credit_cards`**: Product inventory card profiles mapping tier groupings (Signature, Gold) and monthly limits.
3. **`card_transactions`**: Live transactional stream ledger recording dispute flags, swipe values, timestamps, and merchant codes.

---

## 🔍 Strategic Banking Metrics Resolved

### 1. High-Frequency Velocity Multi-Swipe Tracker
* **Business Target**: Detect stolen cards being run through quick successive swipes before automated blocks kick in. Uses sequential window tracking (`LAG()`) to bring the immediately preceding timestamp side-by-side on the same row.

### 2. Credit Wall Limit Breaker Dashboard
* **Business Target**: Expose accounts approaching or exceeding their legal card limit pool. Evaluates aggregated balances (`SUM(amount)`) against an 80% contract ceiling to flag high default risks early.

### 3. Geopolitical Fraud Flight Matrix
* **Business Target**: Map international fraud hotspots for AML teams. Computes the exact global percentage contribution (`SUM/SUM OVER()`) of stolen funds exiting into separate foreign jurisdictions.

### 4. Client Consumption Profile Sheets
* **Business Target**: Fuel target cash-back promotion engines with customer spend habits. Packs distinct transaction codes into a clean horizontal profile text string (`GROUP_CONCAT`).

### 5. Unverified High-Exposure Compliance Alarms
* **Business Target**: Shield the firm from regulatory compliance fines. Isolates unverified accounts (`KYC = 'Pending'`) attempting extreme transaction values (`MAX(amount) > 1000`).

---

## 🚀 How to Deploy & Verify
1. Initialize the financial ledgers by executing the setup lines inside `schema.sql`.
2. Populate the mockup data containing disputed records and cross-border limits.
3. Run the analysis scripts inside `queries.sql` to generate active fraud investigation grids.
