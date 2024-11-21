SELECT
    id AS payment_id,
    orderid AS order_id,
    status,
    amount
FROM
    `dbt-tutorial`.stripe.payment