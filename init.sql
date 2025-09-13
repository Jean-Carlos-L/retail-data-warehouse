-- ======================================================
-- Modelo en estrella para Retail Sales Data
-- Usando surrogate keys enteros en dimensiones
-- ======================================================

DROP TABLE IF EXISTS fact_sales CASCADE;
DROP TABLE IF EXISTS dim_customer CASCADE;
DROP TABLE IF EXISTS dim_product CASCADE;
DROP TABLE IF EXISTS dim_payment CASCADE;
DROP TABLE IF EXISTS dim_date CASCADE;
DROP TABLE IF EXISTS dim_mall CASCADE;

-- ======================
-- Dimensión Cliente
-- ======================
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    gender VARCHAR(10),
    age INT
);

-- ======================
-- Dimensión Producto
-- ======================
CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    price NUMERIC(10,2),
    quantity INT
);

-- ======================
-- Dimensión Pago
-- ======================
CREATE TABLE dim_payment (
    payment_id SERIAL PRIMARY KEY,
    payment_method VARCHAR(20),
);

-- ======================
-- Dimensión Fecha
-- ======================
CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    date DATE,
    year INT,
    month INT,
    day INT,
    day_of_week INT,
    quarter INT
);

-- ======================
-- Dimensión Mall
-- ======================
CREATE TABLE dim_mall (
    mall_id SERIAL PRIMARY KEY,
    shopping_mall VARCHAR(100)
);

-- ======================
-- Tabla de Hechos: Ventas
-- ======================
CREATE TABLE fact_sales (
    invoice_no VARCHAR(20) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    payment_id INT NOT NULL,
    mall_id INT NOT NULL,
    date_id INT NOT NULL,
    total_amount NUMERIC(12,2),

    -- Definición de llaves foráneas
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES dim_customer(customer_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES dim_product(product_id),
    CONSTRAINT fk_payment FOREIGN KEY (payment_id) REFERENCES dim_payment(payment_id),
    CONSTRAINT fk_mall FOREIGN KEY (mall_id) REFERENCES dim_mall(mall_id),
    CONSTRAINT fk_date FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);
