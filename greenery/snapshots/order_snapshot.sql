{% snapshot orders_snapshot %}

{{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols=['status','estimated_delivery_at','order_total'],
    )
}}

select * from {{ source('src_greenery', 'orders') }}

{% endsnapshot %}