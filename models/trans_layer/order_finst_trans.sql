{{
    config(
        materialized='table',
        alias='order_finst',
        tags="everyday"
    )
}}

with orders as(
    select * from {{ ref('orders_stg') }}
),
customer as(
    select * from {{ ref('customer_stg') }}
)
select 
    sha2(array_to_string(array_construct(c.c_custkey,o.o_orderkey,o.o_orderdate),'^^^^')) as dwhash_key,
    c.c_custkey,
    c.c_name,
    c.c_phone,
    c.c_address,
    o.o_orderkey,
    o.o_orderdate,
    o.o_orderpriority,
    o.o_totalprice as price_in_rupee,
    {{ rupee_to_dollars('price_in_rupee') }} as price_in_dollars,
    current_timestamp as updated_dt
from 
    customer c 
    inner join orders o
    on (c.c_custkey=o.o_custkey)
