
select top 10 name,sum(net_amount) as total_revenue,sum(quantity)as quantity from DWH.F_sales s join DWH.product_dim p on p.product_key = s.product_key  group by name order by sum(net_amount) desc
/*top 10 selling products*/

SELECT
  d.month_name,
  d.year,
  COUNT(DISTINCT order_key)          AS total_orders,
  sum(net_amount)  as total_revenue
FROM DWH.F_sales s join DWH.dim_date d on s.date_key = d.date_KEY 
GROUP BY
  d.month_name,d.year
ORDER BY
 sum(net_amount) desc

 /* total salses for each month*/


WITH ranked_sales AS (
  SELECT
    c.first_name,
    COUNT(DISTINCT s.order_key)   AS total_orders,
    SUM(s.net_amount)             AS total_revenue,
    d.[year],
    ROW_NUMBER() OVER (
      PARTITION BY d.[year]
      ORDER BY COUNT(DISTINCT s.order_key) DESC
    )                             AS rn
  FROM DWH.F_sales AS s
  JOIN DWH.customer_dim AS c
    ON s.customer_key = c.customer_key
  LEFT JOIN DWH.dim_date AS d
    ON s.date_key = d.date_key
  GROUP BY
    d.[year],
    c.first_name
)
SELECT
  first_name,
  total_orders,
  total_revenue,
  [year]
FROM ranked_sales
WHERE rn = 1
ORDER BY [year];

/*top  cuetomer make orders for each year*/



select p.name,AVG(r.ratings) from DWH.F_ratings r join DWh.product_dim p on r.product_key = p.product_key group by p.name having (AVG(r.ratings) <= 2) 

/* product that have avr(rating) <=2 */

select  format(Return_date,'yyyy') as year,reason,sum(amount_refunded) total_refunded ,p.name 
from DWH.F_returns r join DWH.product_dim p on r.product_key = p.product_key 
group by  format(Return_date,'yyyy'),reason,p.name 
having sum(amount_refunded) > 0
order by format(Return_date,'yyyy') 

/*total amount of refunded for each product and year and reason*/

select   c.campaign_name,format(order_date,'yyyy') as year ,isnull(sum(m.net_revenue),0) total_revenue
from DWH.F_marketing_effectiveness m right join DWH.campaign_dim c on c.campaign_key = m.markting_id 
group by c.campaign_name,format(order_date,'yyyy')

/* total revenue for each marketing_camaign and year */
















