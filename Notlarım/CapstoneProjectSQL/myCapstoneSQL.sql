#### CUSTOMER5
ALTER TABLE public.customers
ADD CONSTRAINT unique_customer_id UNIQUE (customer_id),
ALTER COLUMN customer_id SET NOT NULL;

-- Şimdi, order_id'yi PRIMARY KEY olarak ayarlayın
ALTER TABLE public.customers
ADD PRIMARY KEY (customer_id);


#### ORDERS
ALTER TABLE public.orders
ADD CONSTRAINT unique_order_id UNIQUE (order_id),
ALTER COLUMN order_id SET NOT NULL;

-- Şimdi, order_id'yi PRIMARY KEY olarak ayarlayın
ALTER TABLE public.customers
ADD PRIMARY KEY (order_id);


#### EĞER FOREGIN KEY EKLEMEK İSTERSEN BY KOMUT

ALTER TABLE public.orders 
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);


#### ORDER DETAILS
ALTER TABLE public.order_details
ALTER COLUMN order_id SET NOT NULL;

-- Şimdi, order_id'yi FOREIGN KEY olarak ayarlayın

ALTER TABLE public.order_details
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) 
REFERENCES public.orders(order_id);


#### EMPLOYEES
-- orders tablosundaki employee_id sütununu NOT NULL yapma
ALTER TABLE public.orders
ALTER COLUMN employee_id SET NOT NULL;

-- orders tablosundaki employee_id sütununu employees tablosundaki employee_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.orders
ADD CONSTRAINT fk_employee
FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


#### EMPLOYEE TERRITORIES

ALTER TABLE public.employeeterritories
ALTER COLUMN employee_id SET NOT NULL;

-- employeeterritories tablosundaki employee_id sütununu employees tablosundaki employee_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.employeeterritories
ADD CONSTRAINT fk_employee
FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);



#### TERRITORIES

-- employeeterritories tablosundaki territory_id sütununu NOT NULL yapma (isteğe bağlı)
ALTER TABLE public.employeeterritories
ALTER COLUMN territory_id SET NOT NULL;

-- employeeterritories tablosundaki territory_id sütununu territories tablosundaki territory_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.employeeterritories
ADD CONSTRAINT fk_territory
FOREIGN KEY (territory_id) REFERENCES public.territories(territory_id);


#### REGION

-- territories tablosundaki region_id sütununu NOT NULL yapma (isteğe bağlı)
ALTER TABLE public.territories
ALTER COLUMN region_id SET NOT NULL;

-- territories tablosundaki region_id sütununu regions tablosundaki region_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.territories
ADD CONSTRAINT fk_region
FOREIGN KEY (region_id) REFERENCES public.region(region_id);


####CATEGORİES

-- products tablosundaki category_id sütununu NOT NULL yapma (isteğe bağlı)
ALTER TABLE public.products
ALTER COLUMN category_id SET NOT NULL;

-- products tablosundaki category_id sütununu categories tablosundaki category_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.products
ADD CONSTRAINT fk_category
FOREIGN KEY (category_id) REFERENCES public.categories(category_id);

#### SUPPLIERS

-- products tablosundaki supplier_id sütununu NOT NULL yapma (isteğe bağlı)
ALTER TABLE public.products
ALTER COLUMN supplier_id SET NOT NULL;

-- products tablosundaki supplier_id sütununu suppliers tablosundaki supplier_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.products
ADD CONSTRAINT fk_suppliers
FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);

####CUSTOMERCUSTOMERDEMO

-- customercustomerdemo tablosundaki customer_id sütununu NOT NULL yapma (isteğe bağlı)
ALTER TABLE public.customercustomerdemo
ALTER COLUMN customer_id SET NOT NULL;

-- customercustomerdemo tablosundaki customer_id sütununu customers tablosundaki customer_id sütununa yabancı anahtar olarak bağlama
ALTER TABLE public.customercustomerdemo
ADD CONSTRAINT fk_customers
FOREIGN KEY (customer_id) REFERENCES public.customers(customer_id);

####SHİPPER

ALTER TABLE public.orders
ADD CONSTRAINT fk_ship_via
FOREIGN KEY (ship_via) REFERENCES public.shippers (shipper_id);


####ORDER_DETAİLS

ALTER TABLE public.order_details
ADD CONSTRAINT fk_product_id
FOREIGN KEY (product_id) REFERENCES public.products (product_id);

####CUSTOMERDEMOGRAPHİCS

ALTER TABLE public.customercustomerdemo
ADD CONSTRAINT fk_customer_type_id
FOREIGN KEY (customer_type_id) REFERENCES public.customerdemographics (customer_type_id);


----ÜRÜN-FİYAT ANALİZİ
--ortalama fiyat

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



























