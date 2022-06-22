{{
    config(
        materialized = 'table'
    )
}}

with session_start_and_end as (
    SELECT
        stg_greenery__events.session_guid as session_guid_s,
        min( stg_greenery__events.event_created_at_utc) as session_started_utc,
        max( stg_greenery__events.event_created_at_utc) as session_ended_utc
    FROM {{ref('stg_greenery__events')}}
        GROUP BY 1
),

events_agg as (
SELECT
    stg_greenery__events.session_guid as session_guid_z,
    stg_greenery__events.user_guid,
    count(DISTINCT stg_greenery__events.event_guid) as number_of_events
FROM 
    {{ref('stg_greenery__events')}}
    GROUP BY 1,2
)

SELECT
    events_agg.session_guid_z as session_guid,
    events_agg.user_guid,
    events_agg.number_of_events,
    session_start_and_end.session_started_utc as session_start_utc, 
    session_start_and_end.session_ended_utc as session_end_utc
FROM
    events_agg
LEFT JOIN session_start_and_end on session_start_and_end.session_guid_s = events_agg.session_guid_z
