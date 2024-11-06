function pengujianConfusionMatrix()
    % Tentukan lokasi folder data uji
    folder_utama = 'dataUji';

    % Baca daftar subfolder (kelas) dalam folder utama
    kelas = dir(folder_utama);
    kelas = kelas([kelas.isdir]);

    % Inisialisasi cell array untuk menyimpan citra dan labelnya
    data_citra = {};
    label_kelas = {};

    % Iterasi melalui setiap subfolder (kelas)
    for i = 1:numel(kelas)
        if ~strcmp(kelas(i).name, '.') && ~strcmp(kelas(i).name, '..')
            % Baca nama kelas dari nama subfolder
            nama_kelas = kelas(i).name;

            % Baca dan simpan gambar-gambar dari setiap subfolder (kelas)
            folder_kelas = fullfile(folder_utama, nama_kelas);
            file_gambar = dir(fullfile(folder_kelas, '*.jpg'));

            for j = 1:numel(file_gambar)
                file_path = fullfile(folder_kelas, file_gambar(j).name);
                citra = imread(file_path);
                data_citra{end+1} = citra;
                label_kelas{end+1} = nama_kelas;
            end
        end
    end

    % Ubah cell array menjadi matriks untuk menyimpan data citra
    X = cat(4, data_citra{:});
    Y = categorical(label_kelas);

    % Inisialisasi matriks untuk menyimpan fitur GLCM dan HSV
    fitur_glcm = zeros(numel(Y), 4);
    fitur_hsv = zeros(numel(Y), 3);

    % Ekstraksi fitur untuk setiap citra
    for i = 1:numel(Y)
        citra_gray = rgb2gray(X(:, :, :, i));
        glcm = graycomatrix(citra_gray, 'Offset', [0 1; -1 1; -1 0; -1 -1]);
        stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
        fitur_glcm(i, :) = [mean(stats.Contrast), mean(stats.Correlation), mean(stats.Energy), mean(stats.Homogeneity)];

        citra_hsv = rgb2hsv(X(:, :, :, i));
        hue = mean(mean(citra_hsv(:, :, 1)));
        saturation = mean(mean(citra_hsv(:, :, 2)));
        value = mean(mean(citra_hsv(:, :, 3)));
        fitur_hsv(i, :) = [hue, saturation, value];
    end

    % Gabungkan fitur GLCM dan HSV
    fitur = [fitur_glcm, fitur_hsv];

    % Muat model Naive Bayes
    load('model_nb.mat', 'model_nb');

    % Prediksi label menggunakan model Naive Bayes
    prediksi = predict(model_nb, fitur);

    % Hitung confusion matrix
    cm = confusionmat(Y, prediksi);

    % Tampilkan confusion matrix
    figure;
    confusionchart(Y, prediksi);
    title('Confusion Matrix');

    % Hitung metrik evaluasi
    TP = diag(cm);
    FP = sum(cm, 1)' - TP;
    FN = sum(cm, 2) - TP;
    TN = sum(cm(:)) - (TP + FP + FN);

    akurasi = sum(TP) / sum(cm(:)) * 100;
    recall = TP ./ (TP + FN) * 100;
    precision = TP ./ (TP + FP) * 100;

    % Tampilkan hasil di command window
    % Hitung akurasi rata-rata per kelas
    akurasi_rata2 = mean((TP + TN) ./ (TP + TN + FP + FN) * 100);
    fprintf('Akurasi rata-rata per kelas: %.2f%%\n', akurasi_rata2);
    fprintf('Recall rata-rata: %.2f%%\n', mean(recall, 'omitnan'));
    fprintf('Precision rata-rata: %.2f%%\n', mean(precision, 'omitnan'));

    for i = 1:length(TP)
        akurasi_kelas = (TP(i) + TN(i)) / (TP(i) + TN(i) + FP(i) + FN(i)) * 100;
        fprintf('Kelas %d - TP: %d, TN: %d, FP: %d, FN: %d, Akurasi: %.2f%%, Recall: %.2f%%, Precision: %.2f%%\n', ...
            i, TP(i), TN(i), FP(i), FN(i), akurasi_kelas, recall(i), precision(i));
    end

    % Simpan confusion matrix sebagai gambar
    saveas(gcf, 'confusion_matrix.jpg');

    % Simpan metrik ke file Excel
    tabel_cm = array2table(cm, 'VariableNames', categories(Y), 'RowNames', categories(Y));
    writetable(tabel_cm, 'confusion_matrix.xlsx', 'WriteRowNames', true);

    tabel_metrik = table(TP, TN, FP, FN, recall, precision, 'VariableNames', ...
        {'TP', 'TN', 'FP', 'FN', 'Recall', 'Precision'});
    writetable(tabel_metrik, 'metrik_evaluasi.xlsx');
end
