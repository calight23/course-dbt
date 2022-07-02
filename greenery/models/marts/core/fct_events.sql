{%- set event_types = dbt_utils.get_column_values(table=ref('stg_greenery__events'), column='event_type') -%}

select
    stg_greenery__events.session_guid
    , stg_greenery__events.user_guid
    , dim_products.product_name
    , stg_greenery__events.event_created_at_utc
    {%- for event_type in event_types -%}
    , CASE WHEN stg_greenery__events.event_type = '{{event_type}}' THEN 1 ELSE 0 END as {{event_type}}
    {%- endfor -%}
    , stg_greenery__events.event_guid
FROM
    {{ref('stg_greenery__events')}}
LEFT JOIN {{ref('dim_products')}} on dim_products.product_guid = stg_greenery__events.product_guid