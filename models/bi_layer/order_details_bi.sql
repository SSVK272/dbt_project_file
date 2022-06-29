{{
    config(
        materialazed = 'view',
        alias = 'order_details'
    )

}}

select 
    O_ORDERKEY,
    P_PARTKEY,
    C_CUSTKEY,
    C_NAME,
    P_NAME,
    P_BRAND,
    O_ORDERDATE,
    O_ORDERPRIORITY,
    QTY,
    PRICE,
    L_EXTENDEDPRICE,
    CALC_PRICE,
    PRICE_CHECK_FLAG,
    L_LINESTATUS,
    L_SHIPDATE,
    L_SHIPMODE
 from {{ ref('order_details_trans') }}
 