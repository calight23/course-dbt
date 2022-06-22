{{
    config(
        materialized = 'table'
    )
}}

SELECT
    stg_greenery__users.user_guid,
    Concat(stg_greenery__users.first_name,' ',stg_greenery__users.last_name) as full_name,
    stg_greenery__users.email,
    stg_greenery__users.phone_number,
    stg_greenery__addresses.state,
    stg_greenery__addresses.country,
    stg_greenery__addresses.zipcode,
    stg_greenery__users.created_at_utc,
    stg_greenery__users.updated_at_utc
FROM
    {{ref('stg_greenery__users')}}
left join {{ref('stg_greenery__addresses')}} -- can we assume user to address is 1:1? Do people order to different addresses?
    on stg_greenery__addresses.address_guid = stg_greenery__users.address_guid
