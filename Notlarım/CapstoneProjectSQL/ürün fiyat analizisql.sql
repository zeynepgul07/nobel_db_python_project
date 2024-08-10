ALTER TABLE public.orders
ADD CONSTRAINT fk_ship_via
FOREIGN KEY (ship_via) REFERENCES public.shippers (shipper_id);

ALTER TABLE public.order_details
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id) REFERENCES public.products (product_id);

ALTER TABLE public.customercustomerdemo
ADD CONSTRAINT fk_customer_type_id
FOREIGN KEY (customer_type_id) REFERENCES public.customerdemographics (customer_type_id);

---ÜRÜN-FİYAT ANALİZİ

----ortalama fiyat

SELECT AVG(unit_price) AS AveragePrice
FROM products;

-- En Pahalı Ürünler
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 5;

-- En Ucuz Ürünler
SELECT  product_name, unit_price
FROM products
ORDER BY unit_price ASC
LIMIT 5;

---Fiyat dağılımı

SELECT 
    CASE 
        WHEN unit_price < 10 THEN '0-10'
        WHEN unit_price BETWEEN 10 AND 20 THEN '10-20'
        WHEN unit_price BETWEEN 20 AND 30 THEN '20-30'
        WHEN unit_price BETWEEN 30 AND 40 THEN '30-40'
        ELSE '40+' 
    END AS PriceRange,
    COUNT(*) AS ProductCount
FROM products
GROUP BY PriceRange
ORDER BY PriceRange;


---Ürünlerin maksimum, minimum ve ortalama fiyatları


SELECT 
    MIN (unit_price) AS MinPrice,
    MAX (unit_price) AS MaxPrice,
    AVG (unit_price) AS AvgPrice
FROM products;

--Ürün Fiyatları ve Kategoriler

SELECT 
    c.category_name,
    p.product_name,
    p.unit_price
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
ORDER BY 
    c.category_name, p.unit_price DESC;








