{{
    config(
        materialized = 'table'
    )
}}

select
    stg_greenery__orders.order_guid,
    stg_greenery__orders.user_guid,
    stg_greenery__orders.ordered_at_utc,
    stg_greenery__orders.order_cost,
    stg_greenery__promos.promo_discount * stg_greenery__orders.order_cost as discount_usd,
    stg_greenery__orders.shipping_cost,
    stg_greenery__orders.tracking_guid,
    stg_greenery__orders.shipping_service,
    stg_greenery__orders.estimated_delivery_at_utc,
    stg_greenery__orders.delivered_date_utc,
    stg_greenery__orders.order_status
FROM 
    {{ref('stg_greenery__orders')}}
LEFT JOIN {{ref('stg_greenery__promos')}} on stg_greenery__promos.promo_guid = stg_greenery__orders.promo_guid
