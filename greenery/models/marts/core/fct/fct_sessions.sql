{{
    config(
        materialized = 'table'
    )
}}

SELECT
    int_events_agg.session_guid as session_guid,
    dim_users.full_name,
    dim_users.state,
    dim_users.country,
    int_events_agg.number_of_events,
    int_events_agg.session_start_utc,
    int_events_agg.session_end_utc
FROM
    {{ref('int_events_agg')}}
LEFT JOIN {{ref('dim_users')}} on dim_users.user_guid = int_events_agg.user_guid

