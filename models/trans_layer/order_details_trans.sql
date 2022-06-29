{{
    config(
        materialized = 'table',
        alias = 'order_details'
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
       p.p_name,
       p.p_brand,
       o.o_orderdate,
       o.o_orderpriority,
       l.l_quantity    AS qty,
       p.p_retailprice AS price,
       l.l_extendedprice,
       ( qty * price ) AS calc_price,
       CASE
         WHEN ( qty * price ) = l.l_extendedprice THEN 'Matching'
         ELSE 'Not Matching'
       end             AS Price_Check_Flag,
       l.l_linestatus,
       l.l_shipdate,
       l.l_shipmode
FROM   customer c
       INNER JOIN orders o
               ON ( c.c_custkey = o.o_custkey )
       INNER JOIN lineitem l
               ON ( l.l_orderkey = o.o_orderkey )
       INNER JOIN part p
               ON ( p.p_partkey = l.l_partkey ) 
