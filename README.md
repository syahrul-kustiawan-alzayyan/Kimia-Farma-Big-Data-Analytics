🧠 Kimia Farma – Big Data Analytics Project
Data-Driven Performance Review (2020–2023)

📌 Project Overview

Proyek ini merupakan simulasi peran sebagai Big Data Analytics Intern di Kimia Farma, yang berfokus pada analisis kinerja bisnis dan pertumbuhan perusahaan periode 2020–2023.

Analisis dilakukan menggunakan Google BigQuery sebagai platform pemrosesan data utama, serta Looker Studio untuk visualisasi hasil dalam bentuk dashboard interaktif.

Tujuan dari proyek ini adalah untuk:

Mengevaluasi tren pendapatan dan profitabilitas cabang.

Mengidentifikasi gap antara reputasi cabang (rating) dan pengalaman pelanggan (transaksi).

Menyediakan insight strategis untuk mendukung pengambilan keputusan berbasis data (data-driven decision making).

📂 Project Structure

Repository ini berisi tiga file utama:

File	Deskripsi
01_data_cleaning.sql	Query BigQuery untuk proses pembersihan (cleaning) keempat tabel utama.
02_data_merging.sql	Query BigQuery untuk penggabungan tabel cleaned, perhitungan nett sales, gross profit, dan pembuatan tabel analisa utama.
KimiaFarma_Dashboard.pdf	Tangkapan layar atau dokumentasi dari dashboard Looker Studio (Performance Analytics Dashboard).
🧾 Dataset Description

Analisis dilakukan menggunakan empat dataset utama Kimia Farma yang disimpan dalam format .csv dan diimpor ke BigQuery:

Dataset	Deskripsi	Primary Key
kf_final_transaction	Data transaksi cabang (tanggal, pelanggan, produk, harga, diskon, rating).	transaction_id
kf_product	Master data produk (nama produk, kategori, harga standar).	product_id
kf_inventory	Data stok dan opname per produk per cabang.	product_id
kf_kantor_cabang	Data cabang Kimia Farma (nama, lokasi, kategori, rating).	branch_id
🧹 Data Cleaning Process (01_data_cleaning_bigquery.sql)

Proses pembersihan data dilakukan untuk memastikan setiap tabel memiliki format yang konsisten dan bebas dari error.
Langkah-langkah utama:

Menghapus duplikasi data dengan DISTINCT.

Membersihkan spasi berlebih menggunakan TRIM().

Mengonversi tipe data menggunakan SAFE_CAST().

Menangani nilai NULL dan data tidak valid.

Menstandarkan format tanggal, teks, dan angka.

Output dari tahap ini adalah empat tabel cleaned:

kf_final_transaction_cleaned

kf_product_cleaned

kf_inventory_cleaned

kf_kantor_cabang_cleaned

🔗 Data Integration & Analysis (02_data_analysis_bigquery.sql)

Tahap ini menggabungkan keempat tabel cleaned menjadi satu tabel analisa komprehensif bernama:
rakaminacademybigdataanalyst.AnalysisDataRakamin.transaction_analysis

Langkah-langkah utama:

Menggabungkan data menggunakan LEFT JOIN berdasarkan key product_id dan branch_id.

Menambahkan kolom analitik seperti:

nett_sales → harga setelah diskon

persentase_gross_laba → margin laba berdasarkan rentang harga

nett_profit → laba bersih berdasarkan perhitungan nett_sales × persentase_gross_laba

Menghasilkan tabel final yang siap digunakan untuk dashboard analitik.

📊 Dashboard: Performance Analytics

Dashboard dibuat menggunakan Google Looker Studio untuk memvisualisasikan insight utama hasil analisis.

Fitur dashboard:

📈 Tren Pendapatan 2020–2023

💸 Profit per Provinsi

⭐ Top 5 Cabang dengan Rating Tertinggi namun Transaksi Terendah

🏆 Persentase Gross Laba per Wilayah

🔍 Filter interaktif berdasarkan tahun, provinsi, dan kategori cabang

Preview Dashboard:
🔗 Lihat Dashboard di Looker Studio
 (link dapat disesuaikan)

💡 Key Insights

Terdapat peningkatan pendapatan signifikan pada periode 2022–2023.

Beberapa cabang dengan rating tinggi memiliki volume transaksi rendah — menunjukkan gap antara reputasi dan performa.

Produk dengan harga di atas Rp300.000 memiliki margin laba tertinggi.

Dashboard ini dapat digunakan manajemen untuk menganalisis performa cabang dan merencanakan strategi bisnis berbasis data.

🧠 Tools & Technologies
Kategori	Teknologi yang Digunakan
Data Platform	Google BigQuery
Visualization	Google Looker Studio
Language	SQL (Standard BigQuery)
Data Source	CSV Files (RawDataRakamin)
Hosting	Google Cloud Platform (GCP)
👨‍💻 Author

Syahrul Kustiawan Al Zayyan
📍 Garut, Jawa Barat
🎓 Informatics Engineering – Intelligent Systems
📧 syahrulkustiawanalzayyan@gmail.com

🔗 LinkedIn
