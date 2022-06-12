{{
    config(
        MATERIALIZED = 'view'
    )
}}

with src_greenery_events as (
    select * from {{source('src_greenery','events')}} 
    )
,

renamed_recast as (
    SELECT
        event_id as event_guid
        , session_id as session_guid
        , user_id as user_guid
        , page_url
        , created_at as event_created_at_utc
        , event_type
        , order_id as order_guid
        , product_id as product_guid
    FROM src_greenery_events
)

select * from renamed_recast