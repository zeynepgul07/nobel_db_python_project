SELECT p.product_id, p.product_name, AVG(od.quantity) AS average_quantity
FROM public.order_details od
JOIN public.products p ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_quantity DESC;
