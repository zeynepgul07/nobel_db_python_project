SELECT r.region_description, COUNT(o.order_id) AS total_orders, SUM(od.unit_price * od.quantity) AS total_amount
FROM public.orders o
JOIN public.employees e ON o.employee_id = e.employee_id
JOIN public.region r ON e.region = r.region_id
JOIN public.order_details od ON o.order_id = od.order_id
GROUP BY r.region_description
ORDER BY total_amount DESC;
