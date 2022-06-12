{{
    config(
        MATERIALIZED = 'view'
    )
}}

with src_greenery_products as (
    select * from {{source('src_greenery','products')}} 
    )
,

renamed_recast as (
    SELECT
        product_id as product_guid
        , name as product_name
        , price as product_price
        , inventory as inventory_quantity
    FROM src_greenery_products
)

select * from renamed_recast