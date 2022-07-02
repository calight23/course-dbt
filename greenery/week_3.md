## What is our overall conversion rate?
# Answer: 62%
``
select sum(checkout)::float / count(distinct session_guid)::float from dbt.dbt_chris_l.fct_events
``

## What is our conversion rate by product?
# Answer: 

``
with product_sessions as (
select * from dbt.dbt_chris_l.fct_events WHERE product_name IS NOT NULL)

select product_name,sum(add_to_cart)::float / count(distinct session_guid) from product_sessions group by 1
``

## Create a macro to simplify part of a model(s)
# Answer: 

## Add a post hook to your project to apply grants to the role “reporting”. Create reporting role first by running CREATE ROLE reporting in your database instance.
# Answer: Done!

## Install a package (i.e. dbt-utils, dbt-expectations) and apply one or more of the macros to your project
# Answer: dbt-utils installed

## Show (using dbt docs and the model DAGs) how you have simplified or improved a DAG using macros and/or dbt packages.
# Answer: 


