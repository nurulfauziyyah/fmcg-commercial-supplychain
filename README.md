# FMCG Commercial & Supply Chain Analytics

End-to-end FMCG analytics project that integrates data engineering, business intelligence, demand forecasting, and automated reporting to identify revenue growth opportunities, improve marketing effectiveness, and optimize supply chain performance.

## Project Overview

This project simulates a real-world Fast-Moving Consumer Goods (FMCG) analytics environment by combining:

- Data Warehousing with PostgreSQL
- Interactive Business Intelligence Dashboard using Power BI
- Demand Forecasting using Holt-Winters Time Series Model
- Automated PDF Reporting using Python

The objective is to transform raw sales and inventory data into actionable business insights across three key domains:

1. Sales Performance
2. Marketing & Promotion Effectiveness
3. Supply Chain & Inventory Risk

---

## Business Problems

### Sales

Forecasting results indicate a potential decline in future sales volume if current business conditions remain unchanged.

### Marketing

Promotional campaigns generate inconsistent results across product categories and regions, leading to inefficient marketing spending.

### Supply Chain

Inventory risk remains critically high across categories and locations, increasing the likelihood of stockouts and operational inefficiencies.

---

## Dataset

Synthetic FMCG dataset consisting of 1,000 records.

### Features

| Variable | Description |
|-----------|-------------|
| Date | Transaction date |
| Product_Category | Beverages, Snacks, Dairy, Household, Personal Care |
| Sales_Volume | Units sold |
| Price | Product price |
| Promotion | Promotion status (0/1) |
| Store_Location | Urban, Suburban, Rural |
| Weekday | Day of week |
| Supplier_Cost | Procurement cost |
| Replenishment_Lead_Time | Supplier lead time |
| Stock_Level | Available inventory |

---

## Data Architecture

```text
Raw Data
    │
    ▼
PostgreSQL
├── Raw Schema
├── Staging Schema
└── Warehouse Schema
    ├── Fact_Sales
    ├── Fact_Inventory
    ├── Dim_Date
    ├── Dim_Promotion
    ├── Dim_Product
    └── Dim_Store
    │
    ▼
Python Forecasting & Automated PDF Reporting
    │
    ▼
Power BI Dashboard
```

---

## Analytics Workflow

### 1. Data Engineering

- Data ingestion into PostgreSQL
- ETL process from Raw → Staging → Warehouse
- Star schema implementation

### 2. Business Intelligence

Power BI dashboard development covering:

- Sales Performance Analysis
- Promotion Effectiveness
- Inventory Monitoring
- Supply Chain Risk Assessment

### 3. Forecasting

Model:
- Holt-Winters Exponential Smoothing

Performance:
- MAPE: 6.24%
- RMSE: 2,487

Forecast Horizon:
- 12 Months

### 4. Automated Reporting

Python-generated PDF reports summarizing:

- Sales Trends
- Forecast Results
- Promotion Performance
- Inventory Risk Analysis

---

## Key Insights

### Sales

- Sales volume is projected to decline over the next 12 months.
- Proactive commercial strategies are required to sustain growth.

### Promotion

- Snacks gain significant promotional uplift.
- Dairy experiences negative promotional impact.
- Overall promotional sales show minimal improvement compared to non-promotional sales.

### Supply Chain

- 89% of observations are classified as High Risk inventory conditions.
- Beverages and Dairy show the highest inventory vulnerability.
- Rural locations experience the most severe inventory stagnation.

---

## Recommendations

### Sales

- Expand General Trade (GT) penetration
- Improve product availability
- Strengthen demand generation initiatives

### Marketing

- Reallocate budget toward high-performing categories
- Redesign underperforming campaigns
- Optimize regional promotional strategies

### Supply Chain

- Implement Just-in-Time (JIT) replenishment
- Apply dynamic safety stock policies
- Integrate demand forecasting into inventory planning

---

## Expected Business Impact

| Area | Impact |
|--------|--------|
| Sales | +3–5% annual sales growth |
| Marketing | +5–8% promotion ROI |
| Supply Chain | 5–10% reduction in stockout risk |

---

## Tech Stack

### Database
- PostgreSQL

### Analytics
- Python
- Pandas
- NumPy
- Statsmodels

### Visualization
- Power BI

### Reporting
- Python PDF Automation

```

---

## Author

Nurul – Statistics Fresh Graduate | Data Analytics | Business Intelligence | Forecasting | Supply Chain Analytics
