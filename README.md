# Sistem Klasifikasi Jenis Ikan Pelagis Menggunakan Naive Bayes

Repositori ini berisi sistem klasifikasi jenis ikan pelagis berbasis MATLAB yang menggunakan metode Naive Bayes, berdasarkan fitur tekstur dan warna dari daging ikan. Proyek ini dirancang untuk mengklasifikasikan jenis ikan dengan menganalisis fitur gambar.

## Struktur Program

Struktur program mencakup beberapa folder dan file sebagai berikut:

- **Folder**:
  - `dataLatih`: Berisi data latih.
  - `Dataset`: Dataset asli, yang akan dibagi menjadi data latih dan data uji.
  - `dataUji`: Berisi data uji.

- **File**:
  - **File Excel**: Digunakan untuk menyimpan hasil ekstraksi fitur tekstur GLCM (Gray Level Co-occurrence Matrix) dan fitur warna HSV dari data latih.
  - **File Sumber MATLAB**:
    - `naivebayes.fig`: File GUI MATLAB yang mendefinisikan tata letak antarmuka.
    - `naivebayes.m`: Berisi logika untuk GUI.
    - `latihData.m`: Melatih model Naive Bayes menggunakan data latih.
    - `bagiData.m`: Membagi dataset menjadi data latih (`dataLatih`) dan data uji (`dataUji`).
    - `bacaData.m`: Membaca data citra dari data latih, mengekstraksi fitur, dan menyimpannya dalam file Excel.
    - **`confus.m`**: Menghitung dan menampilkan matriks kebingungan (confusion matrix) untuk menilai kinerja model klasifikasi. File ini berguna untuk mengukur akurasi prediksi, tingkat kesalahan, serta sensitivitas dan spesifisitas dari model Naive Bayes yang telah dilatih.

### Alur Program

1. **Mengunduh Dataset**: Unduh dataset dari link [Google Drive ini](https://drive.google.com/drive/folders/1jNO0aJZd_5BQ1ojhbP7jVRTSMqFqX1Tz) dan letakkan dalam folder `Dataset`.
2. **Pembagian Data**: Membagi dataset menjadi data latih dan data uji.
3. **Ekstraksi Fitur**: Mengekstrak fitur tekstur dan warna dari citra.
4. **Pelatihan Model**: Melatih model Naive Bayes menggunakan fitur yang telah diekstraksi.
5. **Klasifikasi**: Menggunakan model yang telah dilatih untuk mengklasifikasikan citra baru berdasarkan fitur tekstur dan warna.
6. **Evaluasi Model**: Menggunakan **`confus.m`** untuk menghasilkan matriks kebingungan, yang membantu dalam menilai kinerja model.

## Antarmuka Pengguna Grafis (GUI)

GUI memungkinkan pengguna berinteraksi dengan program secara visual dan mencakup berbagai tombol serta area tampilan:

1. **Unggah Citra**: Tombol "Buka Citra" memungkinkan pengguna untuk memasukkan citra.
2. **Pemrosesan Citra**:
   - **Konversi Grayscale**: Mengonversi citra yang diunggah menjadi grayscale.
   - **Segmentasi**: Melakukan segmentasi pada citra grayscale.
   - **Ekstraksi Fitur**: Mengekstraksi fitur tekstur dan warna, menampilkan hasilnya dalam tabel.
3. **Klasifikasi**: Setelah fitur diekstraksi, tombol "Klasifikasi" aktif untuk melakukan klasifikasi pada citra masukan.
4. **Evaluasi Klasifikasi**: Setelah klasifikasi selesai, **`confus.m`** dapat digunakan untuk menampilkan matriks kebingungan, yang menunjukkan tingkat akurasi klasifikasi.

## Persyaratan

- MATLAB dengan Image Processing Toolbox
- Pustaka atau dependensi yang diperlukan untuk fungsionalitas GUI

## Memulai

1. Clone repositori ini.
2. Buka MATLAB dan arahkan ke direktori proyek.
3. Jalankan GUI dengan membuka `naivebayes.fig` atau `naivebayes.m`.

## Mendapatkan Folder Dataset

Dataset yang digunakan dalam proyek ini dapat diunduh melalui link Google Drive berikut:

**[Link Google Drive Dataset](https://drive.google.com/drive/folders/1jNO0aJZd_5BQ1ojhbP7jVRTSMqFqX1Tz)**

1. Klik link di atas untuk membuka halaman Google Drive.
2. Pilih folder yang ingin diunduh, klik kanan, lalu pilih **"Download"** untuk mengunduh dataset ke komputer Anda.
3. Ekstrak folder jika diperlukan, dan pindahkan folder ke direktori proyek sesuai struktur yang dibutuhkan.
