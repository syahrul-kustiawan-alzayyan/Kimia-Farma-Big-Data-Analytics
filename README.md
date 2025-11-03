# 🧠 **Kimia Farma – Big Data Analytics Project**  
### *Data-Driven Performance Review (2020–2023)*  

![Kimia Farma Logo](https://upload.wikimedia.org/wikipedia/commons/b/b2/Kimia_Farma_logo.svg)

---

## 📌 **Project Overview**
Proyek ini merupakan simulasi peran sebagai **Big Data Analytics Intern di Kimia Farma**, yang berfokus pada analisis kinerja bisnis dan pertumbuhan perusahaan periode **2020–2023**.  

Analisis dilakukan menggunakan **Google BigQuery** sebagai platform pemrosesan data utama, serta **Looker Studio** untuk visualisasi hasil dalam bentuk dashboard interaktif.  

🎯 **Tujuan utama proyek ini:**
- Mengevaluasi **tren pendapatan dan profitabilitas cabang**.  
- Mengidentifikasi **gap antara reputasi cabang (rating)** dan **pengalaman pelanggan (transaksi)**.  
- Memberikan **insight strategis** untuk mendukung pengambilan keputusan berbasis data.  

---

## 📂 **Project Structure**

| File | Deskripsi |
|------|------------|
| 🧹 `01_data_cleaning_bigquery.sql` | Query BigQuery untuk proses pembersihan (cleaning) empat tabel utama. |
| 🔗 `02_data_analysis_bigquery.sql` | Query BigQuery untuk penggabungan tabel cleaned, perhitungan nett sales, gross profit, dan pembuatan tabel analisa utama. |
| 📊 `KimiaFarma_Dashboard.pdf` | Dokumentasi atau tangkapan layar dari dashboard Looker Studio (Performance Analytics Dashboard). |

---

## 🧾 **Dataset Description**

Analisis dilakukan menggunakan empat dataset utama Kimia Farma yang disimpan dalam format `.csv` dan diimpor ke **BigQuery**.

| Dataset | Deskripsi | Primary Key |
|----------|------------|--------------|
| 💳 `kf_final_transaction` | Data transaksi cabang (tanggal, pelanggan, produk, harga, diskon, rating). | `transaction_id` |
| 📦 `kf_product` | Master data produk (nama produk, kategori, harga standar). | `product_id` |
| 🏢 `kf_kantor_cabang` | Data cabang Kimia Farma (nama, lokasi, kategori, rating). | `branch_id` |
| 📦 `kf_inventory` | Data stok dan opname per produk per cabang. | `product_id` |

---

## 🧹 **Data Cleaning Process** (`01_data_cleaning_bigquery.sql`)

Proses **data cleaning** dilakukan agar seluruh tabel memiliki format yang konsisten dan bebas dari error sebelum analisis dilakukan.  

🧾 **Langkah-langkah utama:**
- Menghapus **duplikasi** data dengan `DISTINCT`.  
- Membersihkan **spasi berlebih** menggunakan `TRIM()`.  
- Mengonversi tipe data menggunakan `SAFE_CAST()`.  
- Menangani **nilai NULL** dan data tidak valid.  
- Menstandarkan **format tanggal, teks, dan angka**.  

📤 **Output dari tahap ini:**
- `kf_final_transaction_cleaned`  
- `kf_product_cleaned`  
- `kf_inventory_cleaned`  
- `kf_kantor_cabang_cleaned`

---

## 🔗 **Data Integration & Analysis** (`02_data_analysis_bigquery.sql`)

Tahap berikutnya adalah **penggabungan data** untuk membentuk tabel analisa utama bernama:  
`rakaminacademybigdataanalyst.AnalysisDataRakamin.transaction_analysis`

🧩 **Langkah-langkah utama:**
- Menggabungkan tabel cleaned menggunakan `LEFT JOIN` berdasarkan key `product_id` dan `branch_id`.  
- Menambahkan kolom analitik seperti:
  - 💵 **`nett_sales`** → harga setelah diskon  
  - 📈 **`persentase_gross_laba`** → margin laba berdasarkan rentang harga  
  - 💹 **`nett_profit`** → laba bersih hasil perhitungan `nett_sales × persentase_gross_laba`  
- Menghasilkan satu tabel final yang siap digunakan untuk **query analitik dan dashboard visualisasi**.

---

## 📊 **Dashboard: Performance Analytics**

Dashboard dibuat menggunakan **Google Looker Studio** untuk memvisualisasikan hasil analisa.  

✨ **Fitur utama dashboard:**
- 📈 *Tren Pendapatan (2020–2023)*  
- 💸 *Profit per Provinsi*  
- ⭐ *Top 5 Cabang dengan Rating Tertinggi namun Transaksi Terendah*  
- 🏆 *Persentase Gross Laba per Wilayah*  
- 🔍 *Filter interaktif* berdasarkan tahun, provinsi, dan kategori cabang  

📎 **Preview Dashboard:**  
[🔗 Lihat di Google Looker Studio](https://lookerstudio.google.com/) *(link dapat disesuaikan dengan dashboard kamu)*  

---

## 💡 **Key Insights**

1. 📊 Pendapatan meningkat signifikan pada periode **2022–2023**.  
2. ⭐ Beberapa cabang dengan **rating tinggi** justru memiliki volume transaksi rendah — menunjukkan adanya **gap reputasi vs performa bisnis**.  
3. 💰 Produk dengan **harga di atas Rp300.000** memiliki margin laba tertinggi.  
4. 📈 Dashboard ini membantu manajemen dalam **memonitor performa cabang** dan merancang strategi peningkatan penjualan berbasis data.  

---

## 🧠 **Tools & Technologies**

| Kategori | Teknologi yang Digunakan |
|-----------|---------------------------|
| ☁️ **Data Platform** | Google BigQuery |
| 📊 **Visualization** | Google Looker Studio |
| 🧾 **Language** | SQL (Standard BigQuery) |
| 📂 **Data Source** | CSV Files (RawDataRakamin) |
| 🖥️ **Hosting** | Google Cloud Platform (GCP) |

---

## 👨‍💻 **Author**

**Syahrul Kustiawan Al Zayyan**  
📍 *Garut, Jawa Barat*  
🎓 *Informatics Engineering – Intelligent Systems*  
📧 **syahrulkustiawanalzayyan@gmail.com**  
🔗 [**LinkedIn**](https://www.linkedin.com/in/syahrul-al-zayyan)

---

## 📜 **License**

This project is created for **educational and portfolio purposes only**.  
All datasets are part of the **Rakamin Academy Big Data Analytics Simulation Dataset** and do not represent real company data.

---
