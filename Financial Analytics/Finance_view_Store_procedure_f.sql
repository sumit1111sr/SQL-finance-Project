DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
IN fiscal_year int,
IN country varchar(10),
OUT market_badge varchar(10)
)
BEGIN
DECLARE qty int default 0;

select
sum(sold_quantity) into qty
from fact_sales_monthly fsm
join dim_customer dc on dc.customer_code = fsm.customer_code
where get_fiscal_year(fsm.date)=fiscal_year and dc.market= country;

if qty >500000 then
	set market_badge = "Gold";
else
	set market_badge = "Silver";
end if;
END$$
DELIMITER ;
