WITH orders AS (
    SELECT
        order_id,
        customer_id,
    FROM
        {{ ref('stg_jaffle_shop__orders') }}
),

payments AS (
    SELECT
        order_id,
        SUM(amount) AS amount
    FROM
        {{ ref("stg_stripe__payments") }}
    WHERE
        status = 'success'
    GROUP BY
        order_id
)

SELECT
    orders.order_id,
    orders.customer_id,
    COALESCE(payments.amount, 0) AS amount
FROM
    orders
LEFT JOIN
    payments USING (order_id)