--Hangi şehirlerdeki müşteriler daha çok alışveriş yapıyor? 
--Müşterinin şehrini en çok sipariş verdiği şehir olarak belirleyip analizi ona göre yapınız. 
--Örneğin; Sibel Çanakkale’den 3, Muğla’dan 8 ve İstanbul’dan 10 sipariş olmak üzere 3 farklı şehirden sipariş veriyor. 
--Sibel’in şehrini en çok sipariş verdiği şehir olan İstanbul olarak seçmelisiniz ve Sibel’in yaptığı siparişleri 
--İstanbul’dan 21 sipariş vermiş şekilde görünmelidir.


WITH customer_orders AS (
    SELECT 
        c.customer_unique_id, 
        c.customer_city, 
        COUNT(o.order_id) AS order_count
    FROM 
        public.customers AS c
    JOIN 
        public.orders AS o ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_unique_id, c.customer_city
)
SELECT * FROM customer_orders;

WITH customer_orders AS (
    SELECT 
        c.customer_unique_id, 
        c.customer_city, 
        COUNT(o.order_id) AS order_count
    FROM 
        public.customers AS c
    JOIN 
        public.orders AS o ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_unique_id, c.customer_city
), ranked_customer_orders AS (
    SELECT 
        customer_unique_id, 
        customer_city, 
        order_count,
        RANK() OVER (PARTITION BY customer_unique_id ORDER BY order_count DESC) as rank
    FROM 
        customer_orders
)
SELECT * FROM ranked_customer_orders WHERE rank = 1 ORDER BY order_count DESC;

WITH customer_orders AS (
    SELECT 
        c.customer_unique_id, 
        c.customer_city, 
        COUNT(o.order_id) AS order_count
    FROM 
        public.customers AS c
    JOIN 
        public.orders AS o ON c.customer_id = o.customer_id
    GROUP BY 
        c.customer_unique_id, c.customer_city
), ranked_customer_orders AS (
    SELECT 
        customer_unique_id, 
        customer_city, 
        order_count,
        RANK() OVER (PARTITION BY customer_unique_id ORDER BY order_count DESC) as rank
    FROM 
        customer_orders
), top_customer_orders AS (
    SELECT 
        customer_city, 
        SUM(order_count) AS total_orders
    FROM 
        ranked_customer_orders
    WHERE 
        rank = 1
    GROUP BY 
        customer_city
)
SELECT * FROM top_customer_orders ORDER BY total_orders DESC;


WITH customer_city_orders AS (
    SELECT
        c.customer_unique_id,
        c.customer_city,
        COUNT(*) AS order_count
    FROM
        public.customers AS c
    JOIN
        public.orders AS o ON c.customer_id = o.customer_id
    GROUP BY
        c.customer_unique_id, c.customer_city
),
max_order_cities AS (
    SELECT
        customer_unique_id,
        customer_city,
        order_count,
        RANK() OVER (PARTITION BY customer_unique_id ORDER BY order_count DESC) AS city_rank
    FROM
        customer_city_orders
)
SELECT
    m.customer_unique_id,
    m.customer_city AS most_ordered_city,
    SUM(c.order_count) AS total_orders_in_most_ordered_city
FROM
    max_order_cities AS m
JOIN
    customer_city_orders AS c ON m.customer_unique_id = c.customer_unique_id
WHERE
    m.city_rank = 1
GROUP BY
    m.customer_unique_id, m.customer_city
	
	




