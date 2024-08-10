SELECT cu.customer_id, cu.company_name, p.product_name
FROM public.orders o
JOIN public.order_details od ON o.order_id = od.order_id
JOIN public.products p ON od.product_id = p.product_id
JOIN public.customers cu ON o.customer_id = cu.customer_id
ORDER BY cu.company_name, p.product_name;
