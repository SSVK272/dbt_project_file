{{
    config(
        materialazed = 'view',
        alias = 'order_details'
    )

}}

select * from {{ ref('order_details_trans') }}