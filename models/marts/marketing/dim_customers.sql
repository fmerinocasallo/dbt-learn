WITH customers AS (
    SELECT
        *
    FROM
        {{ ref('stg_jaffle_shop__customers') }}
),

orders AS (
    SELECT
        *
    FROM
        {{ ref('stg_jaffle_shop__orders') }} AS stg_jaffle_shop__orders
    INNER JOIN
        {{ ref('fct_orders') }} USING (order_id, customer_id)
),

customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS number_of_orders,
        SUM(amount) AS lifetime_value
    FROM
        orders
    GROUP BY
        customer_id
)

SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    customer_orders.first_order_date,
    customer_orders.most_recent_order_date,
    COALESCE(customer_orders.number_of_orders, 0) AS number_of_orders,
    COALESCE(customer_orders.lifetime_value, 0) AS lifetime_value,
FROM
    customers
LEFT JOIN
    customer_orders USING (customer_id)