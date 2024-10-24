WITH stg_orders AS (
  SELECT
    ORDER_ID,
    CUSTOMER_ID,
    ORDER_DATE,
    DAYS_SINCE_ORDERED,
    IS_STATUS_PENDING,
    STATUS
  FROM {{ ref('stg_orders') }}
), stg_payments AS (
  SELECT
    PAYMENT_ID,
    ORDER_ID,
    PAYMENT_METHOD,
    STATUS,
    PAYMENT_AMOUNT,
    CREATED_AT
  FROM {{ ref('stg_payments') }}
), join_1 AS (
  SELECT
    stg_payments.PAYMENT_ID,
    stg_payments.ORDER_ID,
    stg_payments.PAYMENT_METHOD,
    stg_payments.STATUS,
    stg_payments.PAYMENT_AMOUNT,
    stg_payments.CREATED_AT,
    stg_orders.ORDER_ID AS ORDER_ID_1,
    stg_orders.CUSTOMER_ID,
    stg_orders.ORDER_DATE,
    stg_orders.DAYS_SINCE_ORDERED,
    stg_orders.IS_STATUS_PENDING,
    stg_orders.STATUS AS STATUS_1
  FROM stg_payments
  JOIN stg_orders
    ON stg_payments.ORDER_ID = stg_orders.ORDER_ID
), aggregation_1 AS (
  SELECT
    ORDER_ID AS ORDER_ID,
    SUM(PAYMENT_AMOUNT) AS sum_PAYMENT_AMOUNT
  FROM join_1
  GROUP BY
    1
)
SELECT
  *
FROM aggregation_1