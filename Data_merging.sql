-- 🔹===================================================================
-- 🔷 MEMBENTUK TABEL ANALISIS UTAMA
-- Tujuan:
-- Menggabungkan seluruh tabel yang sudah dibersihkan menjadi satu tabel analisa komprehensif
-- yang berisi informasi transaksi, produk, cabang, stok, dan perhitungan laba.
-- 🔹===================================================================

CREATE OR REPLACE TABLE `rakaminacademybigdataanalyst.AnalysisDataRakamin.transaction_analysis` AS
SELECT
  -- 🧾 IDENTITAS TRANSAKSI
  -- Setiap transaksi diidentifikasi dengan transaction_id
  TRIM(CAST(t.transaction_id AS STRING)) AS transaction_id,
  t.transaction_date AS date,
  TRIM(CAST(t.branch_id AS STRING)) AS branch_id,
  c.branch_name,
  c.kota,
  c.provinsi,

  -- ⭐ RATING CABANG DAN CUSTOMER
  -- Mengambil rating cabang dari tabel kantor_cabang dan nama pelanggan dari tabel transaksi
  c.rating AS rating_cabang,
  t.customer_name,

  -- 📦 INFORMASI PRODUK
  -- Menghubungkan product_id dari tabel transaksi dengan nama produk dari tabel produk
  TRIM(CAST(t.product_id AS STRING)) AS product_id,
  p.product_name,

  -- 📊 DATA INVENTORI
  -- Menampilkan stok opname dari tabel inventory untuk produk terkait
  i.opname_stock,

  -- 💰 INFORMASI HARGA DAN DISKON
  SAFE_CAST(t.price AS FLOAT64) AS actual_price,
  SAFE_CAST(t.discount_percentage AS FLOAT64) AS discount_percentage,

  -- 📈 PERSENTASE GROSS LABA
  -- Mengelompokkan margin keuntungan berdasarkan rentang harga
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
    WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
    WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
    WHEN t.price > 500000 THEN 0.30
    ELSE 0
  END AS persentase_gross_laba,

  -- 🧮 PERHITUNGAN HARGA SETELAH DISKON
  -- Rumus: harga × (1 - diskon%)
  (t.price * (1 - IFNULL(t.discount_percentage, 0)/100)) AS nett_sales,

  -- 💹 PERHITUNGAN LABA BERSIH
  -- Rumus: nett_sales × persentase_gross_laba
  (t.price * (1 - IFNULL(t.discount_percentage, 0)/100)) *
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
    WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
    WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
    WHEN t.price > 500000 THEN 0.30
    ELSE 0
  END AS nett_profit,

  -- ⭐ RATING TRANSAKSI DARI CUSTOMER
  t.rating AS rating_transaksi

-- 🔹===================================================================
-- 🔷 SUMBER DATA DAN PROSES JOIN
-- Tujuan: Menggabungkan data dari empat tabel cleaned agar saling melengkapi
-- 🔹===================================================================

FROM `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_final_transaction_cleaned` AS t     -- Tabel utama
LEFT JOIN `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_product_cleaned` AS p          -- Data produk
  ON t.product_id = p.product_id
LEFT JOIN `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_kantor_cabang_cleaned` AS c    -- Data cabang
  ON t.branch_id = c.branch_id
LEFT JOIN `rakaminacademybigdataanalyst.CleanedDataRakamin.kf_inventory_cleaned` AS i        -- Data stok
  ON t.product_id = i.product_id;
