
--STEP 3: Create table staging
CREATE TABLE staging.stg_sales AS
SELECT *
FROM raw.raw_sales;

--STEP 4: Create dimension table
--dim_date
CREATE TABLE warehouse.dim_date AS
SELECT DISTINCT
    date AS full_date,

    EXTRACT(YEAR FROM date) AS year,

    EXTRACT(QUARTER FROM date) AS quarter,

    EXTRACT(MONTH FROM date) AS month,

    TRIM(TO_CHAR(date, 'Month')) AS month_name,

    EXTRACT(WEEK FROM date) AS week,

    weekday,

    CASE
        WHEN weekday = 0 THEN 'Monday'
        WHEN weekday = 1 THEN 'Tuesday'
        WHEN weekday = 2 THEN 'Wednesday'
        WHEN weekday = 3 THEN 'Thursday'
        WHEN weekday = 4 THEN 'Friday'
        WHEN weekday = 5 THEN 'Saturday'
        WHEN weekday = 6 THEN 'Sunday'
    END AS weekday_name,

    CASE
        WHEN weekday IN (5,6)
        THEN 'Yes'
        ELSE 'No'
    END AS is_weekend

FROM staging.stg_sales;

ALTER TABLE warehouse.dim_date
ADD COLUMN date_key SERIAL PRIMARY KEY;

--dim_product
CREATE TABLE warehouse.dim_product AS
SELECT DISTINCT
    product_category
FROM staging.stg_sales;

ALTER TABLE warehouse.dim_product
ADD COLUMN product_key SERIAL PRIMARY KEY;

--dim_store
CREATE TABLE warehouse.dim_store AS
SELECT DISTINCT
    store_location
FROM staging.stg_sales;

ALTER TABLE warehouse.dim_store
ADD COLUMN store_key SERIAL PRIMARY KEY;

--dim_promotion
CREATE TABLE warehouse.dim_promotion AS
SELECT DISTINCT

    promotion AS promotion_flag,

    CASE
        WHEN promotion = 1
        THEN 'Promotion'
        ELSE 'No Promotion'
    END AS promotion_name

FROM staging.stg_sales;

ALTER TABLE warehouse.dim_promotion
ADD COLUMN promotion_key SERIAL PRIMARY KEY;

--Step 5: Create fact table
--fact_sales
CREATE TABLE warehouse.fact_sales AS
SELECT

    d.date_key,

    p.product_key,

    s.store_key,

    pr.promotion_key,

    st.sales_volume,

    st.price,

    st.supplier_cost,

    (st.sales_volume * st.price) AS revenue,

    (st.sales_volume * st.supplier_cost) AS cogs,

    (st.sales_volume * st.price)
    - (st.sales_volume * st.supplier_cost) AS gross_margin

FROM staging.stg_sales st

JOIN warehouse.dim_date d
    ON st.date = d.full_date

JOIN warehouse.dim_product p
    ON st.product_category = p.product_category

JOIN warehouse.dim_store s
    ON st.store_location = s.store_location

JOIN warehouse.dim_promotion pr
    ON st.promotion = pr.promotion_flag;

--fact_inventory
CREATE TABLE warehouse.fact_inventory AS
SELECT

    d.date_key,

    p.product_key,

    s.store_key,

    st.stock_level,

    st.replenishment_lead_time,

    ROUND(
        st.stock_level::numeric /
        NULLIF(st.sales_volume,0),
        2
    ) AS inventory_cover_days,

    CASE
        WHEN st.stock_level < st.sales_volume
        THEN 'High Risk'

        ELSE 'Normal'
    END AS stock_risk_flag

FROM staging.stg_sales st

JOIN warehouse.dim_date d
    ON st.date = d.full_date

JOIN warehouse.dim_product p
    ON st.product_category = p.product_category

JOIN warehouse.dim_store s
    ON st.store_location = s.store_location;