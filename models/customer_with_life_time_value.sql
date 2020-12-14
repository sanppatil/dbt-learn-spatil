with orders as 
(
    select * from {{ref('stg_orders')}}
),
customers as 
(
    select * from {{ref('stg_customers')}}
),
payments as 
(
    select * from {{ref('stg_payments')}}
),

customer_orders as (
    select
        orders.customer_id,
        sum(Amount) as order_amount
    from orders
    left join payments using (order_id)
    group by
        1
),

final as (
    select
        customers.*,
        order_amount as life_time_value
    from customers
    left join customer_orders using (customer_id)
)

select * from final