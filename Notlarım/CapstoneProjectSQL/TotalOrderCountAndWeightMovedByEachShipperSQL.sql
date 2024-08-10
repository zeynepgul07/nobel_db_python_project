SELECT sh.shipper_id, sh.company_name, COUNT(o.order_id) AS total_orders, SUM(o.freight) AS total_freight
FROM public.orders o
JOIN public.shippers sh ON o.ship_via = sh.shipper_id
GROUP BY sh.shipper_id, sh.company_name
ORDER BY total_freight DESC;
