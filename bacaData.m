function label_kelas = bacaData()
    % Tentukan lokasi folder dataset
    folder_utama = 'dataLatih'; 
    
    % Baca daftar subfolder (kelas) dalam folder utama
    kelas = dir(folder_utama);
    kelas = kelas([kelas.isdir]);
    
    % Inisialisasi cell array untuk menyimpan citra, labelnya, dan nama file
    data_citra = {};
    label_kelas = {};
    file_names = {};  % Menyimpan nama file
    
    % Iterasi melalui setiap subfolder (kelas)
    for i = 1:numel(kelas)
        if ~strcmp(kelas(i).name, '.') && ~strcmp(kelas(i).name, '..')
            nama_kelas = kelas(i).name;
            folder_kelas = fullfile(folder_utama, nama_kelas);
            file_gambar = dir(fullfile(folder_kelas, '*.jpg')); % Sesuaikan ekstensi gambar
            
            for j = 1:numel(file_gambar)
                file_path = fullfile(folder_kelas, file_gambar(j).name);
                citra = imread(file_path);
                data_citra{end+1} = citra;
                label_kelas{end+1} = nama_kelas;
                file_names{end+1} = file_gambar(j).name;  % Simpan nama file
            end
        end
    end
    
    % Ekstraksi fitur seperti sebelumnya (GLCM, HSV)
    X = cat(4, data_citra{:});
    Y = categorical(label_kelas);
    
    fitur_glcm = zeros(numel(Y), 4);
    fitur_hsv = zeros(numel(Y), 3);
    
    for i = 1:numel(Y)
        % Ekstraksi fitur tekstur GLCM
        citra_gray = rgb2gray(X(:, :, :, i));
        glcm = graycomatrix(citra_gray, 'Offset', [0 1; -1 1; -1 0; -1 -1]);
        stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
        fitur_glcm(i, :) = [mean(stats.Contrast), mean(stats.Correlation), mean(stats.Energy), mean(stats.Homogeneity)];
        
        % Ekstraksi fitur warna HSV
        citra_hsv = rgb2hsv(X(:, :, :, i));
        hue = mean(mean(citra_hsv(:, :, 1)));
        saturation = mean(mean(citra_hsv(:, :, 2)));
        value = mean(mean(citra_hsv(:, :, 3)));
        fitur_hsv(i, :) = [hue, saturation, value];
    end
    
    % Pastikan nama file disimpan sebagai cell array dengan dimensi yang benar
    file_names = file_names';  % Transpose untuk membuat dimensi 480x1
    
    % Menggabungkan nama file dengan fitur GLCM
    file_names_glcm = cell(numel(file_names), 1);
    file_names_glcm(:) = file_names;  % Konversi file_names ke cell array yang konsisten
    
    % Simpan fitur tekstur GLCM ke file Excel dengan kolom nama file
    nama_file_glcm = 'fitur_dataset_glcm.xlsx';
    nama_kolom_glcm = {'NamaFile', 'Contrast', 'Correlation', 'Energy', 'Homogeneity'};
    tabel_fitur_glcm = array2table([file_names_glcm, num2cell(fitur_glcm)], 'VariableNames', nama_kolom_glcm);
    writetable(tabel_fitur_glcm, nama_file_glcm);
    
    % Simpan fitur warna HSV ke file Excel dengan kolom nama file
    nama_file_hsv = 'fitur_dataset_hsv.xlsx';
    nama_kolom_hsv = {'NamaFile', 'Hue', 'Saturation', 'Value'};
    tabel_fitur_hsv = array2table([file_names_glcm, num2cell(fitur_hsv)], 'VariableNames', nama_kolom_hsv);
    writetable(tabel_fitur_hsv, nama_file_hsv);
end
