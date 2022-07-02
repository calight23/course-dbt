{{
    config(
        materialized = 'table'
    )
}}

select
    *
FROM
    {{ref('stg_greenery__products')}}