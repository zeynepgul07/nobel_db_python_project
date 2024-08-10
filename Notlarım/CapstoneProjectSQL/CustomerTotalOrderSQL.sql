SELECT cu.customer_id, cu.company_name, COUNT(o.order_id) AS total_orders, SUM(od.unit_price * od.quantity) AS total_amount
FROM public.orders o
JOIN public.customers cu ON o.customer_id = cu.customer_id
JOIN public.order_details od ON o.order_id = od.order_id
GROUP BY cu.customer_id, cu.company_name
ORDER BY total_amount DESC;
