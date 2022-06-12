{{
    config(
        MATERIALIZED = 'view'
    )
}}

with src_greenery_addresses as (
    select * from {{source('src_greenery','addresses')}} 
    )
,

renamed_recast as (
    SELECT
        address_id as address_guid
        , address as street_address
        , zipcode
        , state
        , country
    FROM src_greenery_addresses
)

select * from renamed_recast