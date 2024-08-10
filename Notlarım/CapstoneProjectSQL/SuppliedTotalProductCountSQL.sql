SELECT s.supplier_id, s.company_name, SUM(p.unit_in_stock) AS total_units
FROM public.products p
JOIN public.suppliers s ON p.supplier_id = s.supplier_id
GROUP BY s.supplier_id, s.company_name
ORDER BY total_units DESC;
