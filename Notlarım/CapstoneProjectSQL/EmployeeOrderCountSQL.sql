SELECT e.employee_id, e.last_name, e.first_name, COUNT(o.order_id) AS total_orders
FROM public.orders o
JOIN public.employees e ON o.employee_id = e.employee_id
GROUP BY e.employee_id, e.last_name, e.first_name
ORDER BY total_orders DESC;
