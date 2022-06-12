# Project 1
## How many users do we have?

```
select count(distinct user_guid) from dbt.dbt_chris_l.stg_greenery__users
```

### Answer:
*130*

## On average, how many orders do we receive per hour? 


```
with orders_per_day_per_hour as (
  select 
    date(ordered_at_utc) as date,
    date_part('hour',ordered_at_utc) as hour,
    count(distinct order_guid) as orders
  from dbt.dbt_chris_l.stg_greenery__orders 
    group by 1,2
  )
select avg(orders) from orders_per_day_per_hour
```

### Answer:
*7.5*

## On average, how long does an order take from being placed to being delivered? 


```
with delivered_orders as (
  select
    order_guid
    , ordered_at_utc
    , estimated_delivery_at_utc
    , age(estimated_delivery_at_utc, ordered_at_utc) as delivery_time 
  from dbt.dbt_chris_l.stg_greenery__orders
    where lower(order_status) = 'delivered' and estimated_delivery_at_utc IS NOT NULL
    )
select avg(delivery_time) from delivered_orders
```

### Answer:
*2 days*

## How many users have only made one purchase? Two purchases? Three+ purchases?

```
with orders_per_user as (
  select
    user_guid
    , count(distinct order_guid) as orders
  from dbt.dbt_chris_l.stg_greenery__orders
    group by user_guid
    )
  select
    sum(CASE WHEN orders = 1 then 1 else 0 END) as one_order
    , sum(CASE WHEN orders = 2 then 1 else 0 END) as two_orders
    , sum(CASE WHEN orders >= 3 then 1 else 0 END) as three_plus_orders
      from orders_per_user
```

### Answer:
*25*
*28*
*71*

## On average, how many unique sessions do we have per hour?

```
  with sessions_per_hour as (
    select
      date(event_created_at_utc) as session_date
      , date_part('hour',event_created_at_utc) as hour
      , count(distinct session_guid) as sessions
    from dbt.dbt_chris_l.stg_greenery__events
      group by 1,2)
    select avg(sessions) from sessions_per_hour
```

### Answer:
*16*