{{
    config(
        materialized = 'table'
    )
}}

    select sum(stg_greenery__order_items.quantity_ordered) as items_ordered,stg_greenery__order_items.order_guid as order_guid
    from {{ref('stg_greenery__order_items')}}
    group by 2