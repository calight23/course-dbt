# Project 2
## What is our user repeat rate?
Note: Repeat Rate = Users who purchased 2 or more times / users who purchased
### Answer: 
79.8%

``
with total_orders_per_user as (
select
  count(distinct order_guid) orders_per_user,
  full_name
from dbt.dbt_chris_l.fct_orders
group by 2) 

select
  sum(case when orders_per_user > 1 then 1.00 else 0 end) / count(distinct full_name) as repeat_rate
  from total_orders_per_user
``

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
Note: This is a hypothetical question vs. something we can analyze in our Greenery data set. Think about what exploratory analysis you would do to approach this question.
### Answer: 
Likely: Multiple orders, promos, delivery timing, events
Not likely: delivery timing, events


## Create a marts folder, so we can organize our models, with the following subfolders for business units. Within each marts folder, create intermediate models and dimension/fact models. Explain the marts models you added. Why did you organize the models in the way you did?
### Answer: 
Currently have everything in core as with int/dim models I made and data set we had that made the most sense. (probably missing something!)


## Use the dbt docs to visualize your model DAGs to ensure the model layers make sense. Paste in an image of your DAG from the docs. These commands will help you see the full DAG
### Answer:
Added to project submission!

## We added some more models and transformed some data! Now we need to make sure they’re accurately reflecting the data. Add dbt tests into your dbt project on your existing models from Week 1, and new models from the section above What assumptions are you making about each model? (i.e. why are you adding each test?) Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?
### Answer:
Didn't have time to do tests :(

## Your stakeholders at Greenery want to understand the state of the data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders about bad data getting through.
### Answer:
Would we setup some sort of scheduler to automatically run dbt? 

