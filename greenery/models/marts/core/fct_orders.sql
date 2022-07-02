{{
    config(
        materialized = 'table'
    )
}}

SELECT
    int_orders_with_promo.order_guid,
    int_orders_with_promo.order_status,
    dim_users.full_name,
    dim_users.email,
    dim_users.phone_number,
    dim_users.state,
    dim_users.country,
    dim_users.zipcode,
    int_order_items_per_order_agg.items_ordered,
    int_orders_with_promo.ordered_at_utc,
    int_orders_with_promo.order_cost as gross_order_amount_usd,
    int_orders_with_promo.discount_usd as discount_usd,
    int_orders_with_promo.order_cost - int_orders_with_promo.discount_usd as net_order_amount_usd ,
    int_orders_with_promo.shipping_cost,
    int_orders_with_promo.order_cost - int_orders_with_promo.discount_usd + int_orders_with_promo.shipping_cost as order_total,
    int_orders_with_promo.shipping_service,
    int_orders_with_promo.estimated_delivery_at_utc,
    int_orders_with_promo.delivered_date_utc
FROM
    {{ref('int_orders_with_promo')}}
LEFT JOIN {{ref('dim_users')}} on dim_users.user_guid = int_orders_with_promo.user_guid
LEFT JOIN {{ref('int_order_items_per_order_agg')}} on int_order_items_per_order_agg.order_guid = int_orders_with_promo.order_guid