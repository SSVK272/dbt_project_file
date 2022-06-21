{{
    config(
        materialized='table',
        alias = 'orders_discount'
        ) 
}}

select 
        o_orderkey,
        o_custkey,
        c_name,
        c_mktsegment,
        o_totalprice,
        {{ calc_dis(c_mktsegment,o_totalprice) }} as net_price,
        o_orderpriority,
        o_shippriority,
        o_comment 
from {{ ref('customer_stg') }} c
inner join 
{{ ref('orders_stg') }} o
on (c.c_custkey=o.o_custkey)

