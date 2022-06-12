{{
    config(
        MATERIALIZED = 'view'
    )
}}

with src_greenery_promos as (
    select * from {{source('src_greenery','promos')}} 
    )
,

renamed_recast as (
    SELECT
        promo_id as promo_guid
        , discount as promo_discount
        , status as promo_status
    FROM src_greenery_promos
)

select * from renamed_recast