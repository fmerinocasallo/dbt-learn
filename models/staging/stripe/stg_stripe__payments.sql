SELECT
    id AS payment_id,
    orderid AS order_id,
    paymentmethod as payment_method,
    status,
    amount / 100 AS amount,  -- amount is stored in cents, convert it to dollars
    created as created_at
FROM
    `dbt-tutorial`.stripe.payment