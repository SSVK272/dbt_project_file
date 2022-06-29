{{
    config(
        materialized = 'table',
        alias = 'lineitem_sm'
    )
}}

-- only air_mode,ship_mode delivery will be delayed

select 
    l_orderkey,
    l_shipdate,
    l_shipmode,
    {{ chk_sm(l_shipmode) }} as delay_flg
    from 
    {{ ref('lineitem_stg') }} l
