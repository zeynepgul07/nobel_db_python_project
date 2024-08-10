

CREATE TABLE geolocation(	
			geolocation_zip_code_prefix	INT,
			geolocation_lat	FLOAT,
			geolocation_lng	FLOAT,
			geolocation_city	VARCHAR(30),
			geolocation_state	VARCHAR(10)
);
COPY geolocation FROM 'C:\Users\zeyne\OneDrive\Masaüstü\SQL PROJE ÇALIŞMASI\olist_geolocation_dataset.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE order_items (	
				order_id	VARCHAR(100),
				order_item_id	INT,
				product_id	VARCHAR(100),
				seller_id	VARCHAR(100),
				shipping_limit_date	TIMESTAMP,
				price	DECIMAL,
				freight_value	DECIMAL,
				PRIMARY KEY (order_id,order_item_id)
);

COPY order_items FROM 'C:\Users\zeyne\OneDrive\Masaüstü\SQL PROJE ÇALIŞMASI\.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE product_category (	
		        product_category_name  VARCHAR(100),
	            product_category_name_english VARCHAR(100)

);

\ product_category FROM 'C:\Program Files\PostgreSQL\16\data\SqlProject\product_category_name_translation' DELIMITER ',' CSV HEADER;


\copy product_category FROM 'D:\Program Files\PostgreSQL\16\data\SqlProject\product_category_name_translation.csv' DELIMITER ',' CSV HEADER;
