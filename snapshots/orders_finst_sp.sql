{% snapshot orders_finst_sp %}

{{
    config(
      target_database='dw_dev',
      target_schema='dw_dev_sp',
      unique_key='dwhash_key',

      strategy='timestamp',
      updated_at='updated_dt',
    )
}}

select * from {{ ref('order_finst_trans') }}

{% endsnapshot %}
