-- 						TASK 1
-- As a product owner i need Report on the following Paramter
-- Month
-- Product Name
-- Variant
-- Sold quantity
-- Gross Price Per Item
-- Gross Price Total
select date,
fs.product_code,
dp.product,
dp.variant,
sold_quantity,
gross_price as gross_price_per_item,
sold_quantity*gross_price as gross_price_total
from fact_sales_monthly fs
join dim_Product dp on fs.product_code = dp.product_code
join fact_gross_price fgp on fgp.product_code = fs.product_code and get_fiscal_year(fs.date) = fgp.fiscal_year
where get_fiscal_year(date) = 2021 and customer_code=90002002 limit 10000;


-- 						TASK 2
-- The reports needs the following fields
-- 1. Months
-- 2. The gross sales amount for croma India 

-- Getting croma india customer id
select customer_code from dim_customer where customer like "croma";

-- Executing Final Query
select date,ROUND(sum(sold_quantity*gross_price),2) as total_gross_sales_monthly from fact_sales_monthly fsm
join fact_gross_price gsp on fsm.product_code = gsp.product_code and 
gsp.fiscal_year = get_fiscal_year(fsm.date)
where customer_code = 90002002
group by date
ORDER BY date asc;

-- 							TASK 3
-- Generate a yearly report for Croma India where there are two columns
-- 1. Fiscal Year
-- 2. Total Gross Sales amount In that year from Croma

select get_fiscal_year(date) as fiscal_year,
ROUND(sum(sold_quantity*gross_price),2) as total_gross_sales_monthly from fact_sales_monthly fsm
join fact_gross_price gsp on fsm.product_code = gsp.product_code and 
gsp.fiscal_year = get_fiscal_year(fsm.date)
where customer_code = (select customer_code from dim_customer where customer like "croma")
group by get_fiscal_year(date);