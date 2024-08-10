SELECT c.category_name, p.product_name
FROM public.products p
JOIN public.categories c ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;
