{{
    config(
        materialized = 'table'
    )
}}

with funnel_points as (
    SELECT 
        session_guid
        , sum(page_view) as page_view
        , sum(add_to_cart) as add_to_cart
        , sum(checkout) as checkout
    FROM
    {{ref('fct_events')}}
    GROUP BY 1
)

SELECT
    int_events_agg.session_guid as session_guid,
    dim_users.full_name,
    dim_users.state,
    dim_users.country,
    int_events_agg.number_of_events,
    int_events_agg.session_start_utc,
    int_events_agg.session_end_utc,
    page_view,
    add_to_cart,
    checkout
FROM
    {{ref('int_events_agg')}}
LEFT JOIN {{ref('dim_users')}} on dim_users.user_guid = int_events_agg.user_guid
LEFT JOIN funnel_points on funnel_points.session_guid = int_events_agg.session_guid
