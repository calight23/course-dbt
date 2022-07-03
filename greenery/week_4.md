## How are our users moving through the product funnel?
# Answer: Page View (can have multiple page views in 1 session) -> Add to Cart (can have multiple add to cart events in 1 session) -> checkout (only 1 per session)

``
select 
  count(distinct session_guid),
  sum(case when page_view > 0 then 1 else 0 end) as page_view,
  sum(page_view) as number_page_views,
  sum(case when add_to_cart > 0 then 1 else 0 end) as add_to_cart,
  sum(add_to_cart) as number_add_to_cart,
  sum(case when checkout > 0 then 1 else 0 end) as checkout,
  sum(checkout) as number_checkout
from dbt.dbt_chris_l.fct_sessions
``

## Which steps in the funnel have largest drop off points?
# Answer: The checkout has the biggest drop off point and is something that should be examined further. Only 77% of people that add to cart actually end up checking out.

## dbt next steps for you 
# Answer: I plan on using what I have learned in this class to build 1.) build out a dbt project for our internal analytics and 2.) build models for tough to integrate tools like stripe for our users. 

