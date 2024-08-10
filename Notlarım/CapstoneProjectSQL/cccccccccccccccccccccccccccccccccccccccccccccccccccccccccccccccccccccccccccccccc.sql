---OVERVİEW--

--Brüt satış--

SELECT
    o.order_id,
    o.order_date,
    od.product_id,
    p.product_name,
    od.unit_price,
    od.quantity,
    (od.unit_price * od.quantity) AS GrossSales
FROM
    order_details od
JOIN
    orders o ON od.order_id = o.order_id
JOIN
    products p ON od.product_id = p.product_id
ORDER BY
    o.order_id;

--tüm siparişler için toplam brüt satışlar--

SELECT
    SUM(od."unit_price" * od."quantity") AS "TotalGrossSales"
FROM
    "order_details" od;

---her sipariş içişn toplam brüt satışlar--

SELECT
    o."order_id",
    SUM(od."unit_price" * od."quantity") AS "TotalGrossSales"
FROM
    "order_details" od
JOIN
    "orders" o ON od."order_id" = o."order_id"
GROUP BY
    o."order_id"
ORDER BY
    o."order_id";


----- Net Satışlar (Tüm Siparişler için Toplam)----

SELECT
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS TotalNetSales
FROM
    order_details od;

-----Her Sipariş İçin Toplam Net Satışlar----

SELECT
    o.order_id,
    SUM(od.unit_price * od.quantity * (1 - od.discount)) AS TotalNetSales
FROM
    order_details od
JOIN
    orders o ON od.order_id = o.order_id
GROUP BY
    o.order_id
ORDER BY
    o.order_id;

-----Çalışan sayısı----

SELECT COUNT(*) AS EmployeeCount
FROM employees;

---şehirlere göre çalışan sayısı---

SELECT city, COUNT(*) AS EmployeeCount
FROM employees
GROUP BY city

---pozisyona göreçalışan sayısı---

SELECT title, COUNT(*) AS EmployeeCount
FROM employees
GROUP BY title;


----Toplam Sipariş Miktarı---

SELECT SUM(od.quantity) AS TotalOrderQuantity
FROM order_details od;

----Her Sipariş İçin Toplam Miktar---

SELECT od.order_id, SUM(od.quantity) AS TotalOrderQuantity
FROM order_details od
GROUP BY od.order_id
ORDER BY od.order_id;

----Her Müşteri İçin Toplam Sipariş Miktarı---

SELECT o.customer_id, SUM(od.quantity) AS TotalOrderQuantity
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY o.customer_id;

----Her Ürün İçin Toplam Sipariş Miktarı----

SELECT od.product_id, SUM(od.quantity) AS TotalOrderQuantity
FROM order_details od
GROUP BY od.product_id
ORDER BY od.product_id;ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc

---Toplam İndirim Tutarını Hesaplama---

SELECT SUM(od.unit_price * od.quantity * od.discount) AS TotalDiscount
FROM order_details od;

--Her Sipariş İçin Toplam İndirim Tutarı--

SELECT od.order_id, SUM(od.unit_price * od.quantity * od.discount) AS TotalDiscount
FROM order_details od
GROUP BY od.order_id
ORDER BY od.order_id;

---Her Müşteri İçin Toplam İndirim Tutarı--

SELECT o.customer_id, SUM(od.unit_price * od.quantity * od.discount) AS TotalDiscount
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
GROUP BY o.customer_id
ORDER BY o.customer_id;

---Her Ürün İçin Toplam İndirim Tutarı---

SELECT od.product_id, SUM(od.unit_price * od.quantity * od.discount) AS TotalDiscount
FROM order_details od
GROUP BY od.product_id
ORDER BY od.product_id;

---Müşteri Sayısı---

SELECT COUNT(*) AS CustomerCount
FROM customers;

----Tedarikçi Sayısını Hesaplama----

SELECT COUNT(*) AS SupplierCount
FROM suppliers;



