% 1. Baca data fitur tekstur GLCM dan warna HSV dari file Excel
nama_file_glcm = 'fitur_dataset_glcm.xlsx';  % Ganti dengan nama file GLCM yang telah disimpan
nama_file_hsv = 'fitur_dataset_hsv.xlsx';    % Ganti dengan nama file HSV yang telah disimpan

% Membaca fitur dari file Excel sebagai tabel dan melewati kolom pertama (Nama File)
tabel_glcm = readtable(nama_file_glcm);  % Membaca sebagai tabel
tabel_hsv = readtable(nama_file_hsv);    % Membaca sebagai tabel

% Konversi tabel menjadi matriks numerik, mulai dari kolom kedua (melewati kolom Nama File)
fitur_glcm = table2array(tabel_glcm(:, 2:end));  % Ambil semua kolom kecuali kolom pertama (Nama File)
fitur_hsv = table2array(tabel_hsv(:, 2:end));    % Ambil semua kolom kecuali kolom pertama (Nama File)

% 2. Gabungkan fitur GLCM dan HSV menjadi satu matriks
fitur = [fitur_glcm, fitur_hsv];  % Gabungkan fitur GLCM dan HSV

% 3. Baca label kelas dari data yang telah dipersiapkan sebelumnya
label_kelas = bacaData();  % Fungsi ini membaca label kelas dari data yang sudah dipersiapkan sebelumnya

% 4. Ubah label kelas menjadi vektor
label_kelas = categorical(label_kelas);

% 5. Pastikan bahwa jumlah sampel (baris) dalam matriks fitur sama dengan jumlah label kelas
assert(size(fitur, 1) == numel(label_kelas), 'Jumlah sampel tidak sesuai dengan jumlah label kelas');

% Tentukan konfigurasi model Naive Bayes
distribusi_probabilitas = 'normal';  % Anda dapat mengubah distribusi probabilitas sesuai kebutuhan
opsi_model = statset('Display','iter');  % Opsi tambahan, seperti menampilkan iterasi, jika diperlukan

% Latih model Naive Bayes menggunakan data fitur gabungan dan label kelas
model_nb = fitcnb(fitur, label_kelas, 'DistributionNames', distribusi_probabilitas);

% Tampilkan model yang telah dilatih
disp(model_nb);

% Hitung akurasi model
kesalahan = resubLoss(model_nb);
akurasi = (1 - kesalahan) * 100;
fprintf('Akurasi Model Naive Bayes: %.2f%%\n', akurasi);

% Simpan model ke dalam satu file
save('model_nb.mat', 'model_nb');
