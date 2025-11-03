-- 🔹===================================================================
-- 1️⃣ MELIHAT DATA AWAL DARI SETIAP TABEL RAW
-- Tujuan: Mengecek struktur, tipe data, dan contoh isi sebelum analisis
-- 🔹===================================================================

-- 📦 Tabel Produk: Berisi informasi produk dan kategorinya
SELECT *
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_product`
LIMIT 10;

-- 🏢 Tabel Kantor Cabang: Berisi detail setiap cabang termasuk rating
SELECT *
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_kantor_cabang`
LIMIT 10;

-- 💳 Tabel Transaksi: Menyimpan data transaksi yang menjadi tabel utama
SELECT *
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_final_transaction`
LIMIT 10;

-- 📦 Tabel Inventori: Menyimpan stok barang di setiap cabang
SELECT *
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_inventory`
LIMIT 10;


-- 🔹===================================================================
-- 2️⃣ MENGHITUNG JUMLAH BARIS DARI SETIAP TABEL
-- Tujuan: Mengetahui ukuran data dan memastikan tidak ada anomali
-- 🔹===================================================================

SELECT 'kf_product' AS table_name, COUNT(*) AS total_rows
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_product`
UNION ALL
SELECT 'kf_kantor_cabang' AS table_name, COUNT(*) AS total_rows
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_kantor_cabang`
UNION ALL
SELECT 'kf_final_transaction' AS table_name, COUNT(*) AS total_rows
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_final_transaction`
UNION ALL
SELECT 'kf_inventory' AS table_name, COUNT(*) AS total_rows
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_inventory`;


-- 🔹===================================================================
-- 3️⃣ PEMBERSIHAN DATA (DATA CLEANING)
-- Tujuan: Membuat versi data yang bersih, konsisten, dan bebas duplikasi
-- 🔹===================================================================


-- 🧼 a. Membersihkan Data Produk
-- Langkah-langkah:
-- - Hapus baris duplikat dengan DISTINCT
-- - Trim spasi berlebih
-- - Ubah tipe harga ke FLOAT agar bisa dihitung
-- - Hapus baris dengan nilai NULL
CREATE OR REPLACE TABLE `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_product_cleaned` AS
SELECT DISTINCT
  TRIM(product_id) AS product_id,
  TRIM(product_name) AS product_name,
  TRIM(product_category) AS product_category,
  SAFE_CAST(price AS FLOAT64) AS price
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_product`
WHERE product_id IS NOT NULL
  AND product_name IS NOT NULL
  AND price IS NOT NULL;


-- 🧼 b. Membersihkan Data Inventory
-- - Ubah tipe data ke STRING agar konsisten antar tabel
-- - Hapus NULL dan duplikat
-- - Trim teks dan ubah stok menjadi integer
CREATE OR REPLACE TABLE `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_inventory_cleaned` AS
SELECT DISTINCT
  CAST(inventory_id AS STRING) AS inventory_id,
  CAST(branch_id AS STRING) AS branch_id,
  CAST(product_id AS STRING) AS product_id,
  TRIM(product_name) AS product_name,
  SAFE_CAST(opname_stock AS INT64) AS opname_stock
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_inventory`
WHERE product_id IS NOT NULL
  AND branch_id IS NOT NULL
  AND opname_stock IS NOT NULL;


-- 🧼 c. Membersihkan Data Kantor Cabang
-- - Pastikan tidak ada NULL pada ID dan nama cabang
-- - Trim teks dan ubah rating ke FLOAT untuk analisis numerik
CREATE OR REPLACE TABLE `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_kantor_cabang_cleaned` AS
SELECT DISTINCT
  CAST(branch_id AS STRING) AS branch_id,
  TRIM(branch_category) AS branch_category,
  TRIM(branch_name) AS branch_name,
  TRIM(kota) AS kota,
  TRIM(provinsi) AS provinsi,
  SAFE_CAST(rating AS FLOAT64) AS rating
FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_kantor_cabang`
WHERE branch_id IS NOT NULL
  AND branch_name IS NOT NULL;


-- 🧼 d. Membersihkan Data Transaksi (Tabel Utama)
-- - Tabel ini menjadi pusat analisa dengan key: transaction_id
-- - Menstandarkan tipe tanggal, membersihkan NULL, dan menghapus outlier (harga <= 0)
CREATE OR REPLACE TABLE `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_final_transaction_cleaned` AS
SELECT DISTINCT
  TRIM(CAST(transaction_id AS STRING)) AS transaction_id,
  TRIM(CAST(product_id AS STRING)) AS product_id,
  TRIM(CAST(branch_id AS STRING)) AS branch_id,
  TRIM(CAST(customer_name AS STRING)) AS customer_name,

  -- 🔧 Konversi tanggal secara aman ke format DATE
  CASE
    WHEN TYPEOF(date) = 'STRING' THEN SAFE.PARSE_DATE('%Y-%m-%d', CAST(date AS STRING))
    WHEN TYPEOF(date) = 'DATE' THEN CAST(date AS DATE)
    WHEN TYPEOF(date) = 'TIMESTAMP' THEN DATE(CAST(date AS TIMESTAMP))
    WHEN TYPEOF(date) = 'DATETIME' THEN DATE(CAST(date AS DATETIME))
    ELSE NULL
  END AS transaction_date,

  -- 🔢 Ubah tipe data ke FLOAT64 agar siap dianalisis
  SAFE_CAST(price AS FLOAT64) AS price,
  SAFE_CAST(discount_percentage AS FLOAT64) AS discount_percentage,
  SAFE_CAST(rating AS FLOAT64) AS rating

FROM `rakaminacademybigdataanalyst.RawDataRakamin.kf_final_transaction`
WHERE product_id IS NOT NULL
  AND branch_id IS NOT NULL
  AND SAFE_CAST(price AS FLOAT64) IS NOT NULL
  AND SAFE_CAST(price AS FLOAT64) > 0;
