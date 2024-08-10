WITH order_delivery_time AS (
    SELECT
        oi.seller_id,
        o.order_id,
        EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 3600 AS delivery_hours
    FROM
        public.order_items AS oi
    JOIN
        public.orders AS o ON oi.order_id = o.order_id
    WHERE
        o.order_status = 'delivered' AND
        o.order_purchase_timestamp IS NOT NULL AND
        o.order_delivered_customer_date IS NOT NULL
)
SELECT
    seller_id,
    AVG(delivery_hours) AS avg_delivery_time
FROM
    order_delivery_time
GROUP BY
    seller_id
ORDER BY
    avg_delivery_time
LIMIT 5;



SELECT
    seller_id,
    AVG(delivery_hours) AS avg_delivery_time
INTO
    top_fastest_sellers
FROM
    (
        WITH order_delivery_time AS (
            SELECT
                oi.seller_id,
                o.order_id,
                EXTRACT(EPOCH FROM (o.order_delivered_customer_date - o.order_purchase_timestamp)) / 3600 AS delivery_hours
            FROM
                public.order_items AS oi
            JOIN
                public.orders AS o ON oi.order_id = o.order_id
            WHERE
                o.order_status = 'delivered' AND
                o.order_purchase_timestamp IS NOT NULL AND
                o.order_delivered_customer_date IS NOT NULL
        )
        SELECT
            seller_id,
            delivery_hours
        FROM
            order_delivery_time
    ) AS delivery_data
GROUP BY
    seller_id
ORDER BY
    avg_delivery_time
LIMIT 5;

