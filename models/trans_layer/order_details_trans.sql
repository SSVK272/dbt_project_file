{{
    config(
        materialized = 'table',
        alias = 'order_details',
        tags='everyday'
    )
}}

with customer as(
    select * from {{ ref('customer_stg') }}
),
orders as(
    select * from {{ ref('orders_stg') }}
),
lineitem as(
    select * from {{ ref('lineitem_stg') }}
),
part as(
    select * from {{ ref('part_stg') }}
)

SELECT 
       sha2(array_to_string(array_construct(o.o_orderkey,p.p_partkey,c.c_custkey,o.o_orderdate,l.l_shipdate),'^^^^')) as dwhash_key,
       o.o_orderkey,
       p.p_partkey,
       c.c_custkey,
       c.c_name,
       c.c_phone,
       c.c_acctbal,
       c.c_acctbal as balance_amount,
       p.p_name,
       p.p_brand,
       o.o_orderdate,
       o.o_orderpriority,
       l.l_quantity as qty,
       p.p_retailprice as price,
       l.l_extendedprice,
       ( qty * price ) as calc_price,
       case
         when ( qty * price ) = l.l_extendedprice then 'Matching'
         else 'Not Matching'
       end as Price_Check_Flag,
       l.l_linestatus,
       l.l_shipdate,
       l.l_shipmode
from   customer c
       inner join orders o
               on ( c.c_custkey = o.o_custkey )
       inner join lineitem l
               on ( l.l_orderkey = o.o_orderkey )
       inner join part p
               on ( p.p_partkey = l.l_partkey ) 
