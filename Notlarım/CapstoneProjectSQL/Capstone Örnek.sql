--ÜRÜN-FİYAT ANALİZİ

-- Ürün Ekibi, şirket fiyatlandırma stratejisine ilişkin yıllık incelemeleri şu anki ürünlerin fiyatlarını ve hangi fiyat aralığında kaç ürün olduğunu görmek istiyor.

-- Onlara yardımcı olmak için sizden aşağıdaki bilgileri içeren bir ürün listesi vermenizi istediler:
-- 1. Ürün Adı
-- 2. Birim Fiyatı
-- 3. Hangi fiyat aralığında olduğu
-- 4. İlgili fiyat aralığında kaç tane ürünümüz var

WITH DATA AS (
        SELECT product_name,
               unit_price,
               CASE WHEN unit_price < 10                  THEN '0-10'
                    WHEN unit_price >= 10 AND unit_price < 20  THEN '10-20'
                    WHEN unit_price >= 20 AND unit_price < 30  THEN '20-30'
                    WHEN unit_price >= 30 AND unit_price < 40  THEN '30-40'
                    WHEN unit_price >= 40 AND unit_price < 50  THEN '40-50'
                    WHEN unit_price >= 50 AND unit_price < 60  THEN '50-60'
                    WHEN unit_price >= 60 AND unit_price < 70  THEN '60-70'
                    WHEN unit_price >= 70 AND unit_price < 80  THEN '70-80'
                    WHEN unit_price >= 80 AND unit_price < 90  THEN '80-90'
                    WHEN unit_price >= 90 AND unit_price < 100 THEN '90-100'
                    WHEN unit_price >= 100                THEN '100+'
                     END AS price_segment
          FROM products
       ) 
  SELECT 
       product_name,
       unit_price,
       price_segment,
       count(product_name) OVER (PARTITION BY price_segment) AS segment_product_count
  FROM DATA ;
 
 
--Finans Ekibi, hangi ürünlerin birim fiyatının arttığını öğrenmek istiyor.

WITH cte_price AS ( 
SELECT
	d.product_id,
	p.product_name,
	ROUND(LEAD(d.unit_price) OVER (PARTITION BY p.product_name ORDER BY o.order_date)::NUMERIC,2) AS current_price,
	ROUND(LAG(d.unit_price) OVER (PARTITION BY p.product_name ORDER BY o.order_date)::NUMERIC,2) AS previous_unit_price
FROM products AS p
INNER JOIN order_details AS d
ON p.product_id = d.product_id
INNER JOIN orders AS o
ON d.order_id = o.order_id
)
SELECT
	c.product_name,
	c.current_price,
	c.previous_unit_price,
	ROUND(100*(c.current_price - c.previous_unit_price)/c.previous_unit_price) AS percentage_increase
FROM cte_price AS c
WHERE c.current_price != c.previous_unit_price
GROUP BY 
	c.product_name,
	c.current_price,
	c.previous_unit_price


--PERFORMANS ANALİZİ
-- Lojistik Ekibi, 1998 yılında hangi ülkelerde iyi performans gösterdiklerini belirlemek için performanslarının geçmişe dönük bir incelemesini yapmak istiyor.
-- Aşağıdaki bilgileri içeren ülkelerin bir listesini sağlayın:

-- 1. Sipariş tarihi ile sevkiyat tarihi arasındaki ortalama gün sayısı (yalnızca 2 ondalık olacak şekilde biçimlendirilmiştir)
-- 2. Toplam sipariş sayısı 


SELECT ship_country,
       round(avg(extract(DAY FROM (shipped_date - order_date) * INTERVAL '1 DAY'))::NUMERIC,2) AS average_days_between_order_shipping,
       count(*) AS total_number_orders
  FROM orders
 WHERE extract(YEAR FROM order_date) = 1998
 GROUP BY ship_country
 ;



-- Satış Ekibi, çalışanların performanslarını ölçmek için bir KPI listesi oluşturmak istiyor.
-- Sizden çalışanların bir listesini vermenizi istediler:
-- 1. tam adları
-- 2. iş unvanları
-- 3. indirim hariç toplam satış tutarI
-- 4. toplam sipariş sayısı
-- 5. toplam giriş sayısı
-- 6. giriş başına ortalama tutarları 
-- 7. sipariş başına ortalama tutarları 
-- 8. toplam indirim tutarı 
-- 9. indirim dahil toplam satış tutarı 
-- 10. toplam indirim yüzdeleri 


WITH cte_kpi AS (
SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS employee_full_name,
	e.title AS employee_title,
	ROUND( SUM(d.quantity * d.unit_price)::NUMERIC, 2) AS total_sale_amount_excluding_discount,
    COUNT(DISTINCT d.order_id) AS total_number_orders,
    COUNT(d.*) AS total_number_entries, ROUND( SUM(d.discount*(d.quantity * d.unit_price))::NUMERIC, 2) AS total_discount_amount,
	ROUND( SUM((1 - d.discount)*(d.quantity * d.unit_price))::NUMERIC, 2) AS total_sale_amount_including_discount
FROM orders AS o
INNER JOIN employees AS e
ON o.employee_id = e.employee_id
INNER JOIN order_details AS d
ON d.order_id = o.order_id
INNER JOIN products AS p
ON d.product_id = p.product_id
GROUP BY 
	employee_full_name,
	employee_title
)
SELECT 
	employee_full_name,
	employee_title,
	total_sale_amount_excluding_discount,
	total_number_orders,
	total_number_entries,
	ROUND(
		SUM(total_sale_amount_excluding_discount/total_number_entries),
		   2) AS average_amount_per_entry,
	ROUND(
		SUM(total_sale_amount_excluding_discount/total_number_orders),
		   2) AS average_amount_per_order,
	total_discount_amount,
	total_sale_amount_including_discount,
	SUM(ROUND(
		(total_sale_amount_excluding_discount-total_sale_amount_including_discount)/total_sale_amount_excluding_discount*100,
		2)) AS total_discount_percentage
FROM cte_kpi
GROUP BY
	employee_full_name,
	employee_title,
	total_sale_amount_excluding_discount,
	total_number_orders,
	total_number_entries,
	total_sale_amount_including_discount,
	total_discount_amount
ORDER BY total_sale_amount_including_discount DESC;
