SELECT cu.customer_id, cu.company_name, SUM(od.discount * od.quantity * od.unit_price) AS total_discount
FROM public.orders o
JOIN public.customers cu ON o.customer_id = cu.customer_id
JOIN public.order_details od ON o.order_id = od.order_id
GROUP BY cu.customer_id, cu.company_name
ORDER BY total_discount DESC;
