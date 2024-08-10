 ---Aylık Bazda En Çok Satılan Ürünler--

WITH MonthlyProductSales AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS OrderMonth,
        p.product_name,
        SUM(od.quantity) AS TotalQuantity
    FROM
        order_details od
    JOIN
        orders o ON od.order_id = o.order_id
    JOIN
        products p ON od.product_id = p.product_id
    GROUP BY
        OrderMonth, p.product_name
),
RankedProductSales AS (
    SELECT
        OrderMonth,
        product_name,
        TotalQuantity,
        RANK() OVER (PARTITION BY OrderMonth ORDER BY TotalQuantity DESC) AS Rank
    FROM
        MonthlyProductSales
)
SELECT
    OrderMonth,
    product_name,
    TotalQuantity
FROM
    RankedProductSales
WHERE
    Rank = 1
ORDER BY
    OrderMonth;

----Ürün- Kategory ve fiyATLAR---
    SELECT 
    c.category_name,
    p.product_name,
    p.unit_price
FROM 
    products p
JOIN 
    categories c ON p.category_id = c.category_id
ORDER BY 
    c.category_name, p.unit_price DESC; cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc


---Kategori Bazında En Çok Satılccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccanccccccccccccccccccccccccccccccccc Ürünler---

WITH CategoryProductSales AS (
    SELECT
        cat.category_name,
        p.product_name,cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
        SUM(od.quantity) AS TotalQuantity
    FROMccccccccccccccccccccccccccccccccccccccccccccccccccccccc
        order_details od
    JOIN
        products p ON od.product_id = p.product_id
    JOIN
        categories cat ON p.category_id = cat.category_id
    GROUP BY
        cat.category_name, p.product_name
),
RankedCategoryProductSales AS (
    SELECT
        category_name,
        product_name,
        TotalQuantity,
        RANK() OVER (PARTITION BY category_name ORDER BY TotalQuantity DESC) AS Rank
    FROM
        CategoryProductSales
)
SELECT
    category_name,
    product_name,
    TotalQuantity
FROM
    RankedCategoryProductSales
WHERE
    Rank = 1
ORDER BY
    category_name;


    ----İndirimlerin Satışlara Etkisi----

SELECT
    p.product_name,
    SUM(od.quantity) AS TotalQuantity,
    ROUND(SUM(od.unit_price * od.quantity)::numeric, 2) AS TotalGrossSales,
    ROUND(SUM(od.unit_price * od.quantity * od.discount)::numeric, 2) AS TotalDiscountAmount,
    ROUND(SUM(od.unit_price * od.quantity * (1 - od.discount))::numeric, 2) AS TotalNetSales,
    ROUND((SUM(od.unit_price * od.quantity * (1 - od.discount)) / SUM(od.unit_price * od.quantity) * 100)::numeric, 2) AS DiscountedSalesPercentage
FROM
    order_details od
JOIN
    products p ON od.product_id = p.product_id
GROUP BY
    p.product_name
ORDER BY
    TotalNetSales DESC;



