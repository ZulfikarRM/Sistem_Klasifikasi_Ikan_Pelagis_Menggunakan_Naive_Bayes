function varargout = naivebayes(varargin)
% NAIVEBAYES MATLAB code for naivebayes.fig
%      NAIVEBAYES, by itself, creates a new NAIVEBAYES or raises the existing
%      singleton*.
%
%      H = NAIVEBAYES returns the handle to a new NAIVEBAYES or the handle to
%      the existing singleton*.
%
%      NAIVEBAYES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAIVEBAYES.M with the given input arguments.
%
%      NAIVEBAYES('Property','Value',...) creates a new NAIVEBAYES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before naivebayes_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to naivebayes_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help naivebayes

% Last Modified by GUIDE v2.5 26-Mar-2024 01:18:46  

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @naivebayes_OpeningFcn, ...
                   'gui_OutputFcn',  @naivebayes_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before naivebayes is made visible.
function naivebayes_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to naivebayes (see VARARGIN)

% Choose default command line output for naivebayes
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes naivebayes wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.axes1)
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes2)
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes3)
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.pushbutton2,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton3,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton4,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton5,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton6,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])


% --- Outputs from this function are returned to the command line.
function varargout = naivebayes_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png; *.*','All Files'},'Select Image File');
    % Memeriksa apakah pengguna telah membatalkan pemilihan citra
    if isequal(filename,0) || isequal(pathname,0)
        % Pengguna membatalkan pemilihan citra, tampilkan pesan peringatan
        msgbox('Pemilihan citra dibatalkan.', 'Peringatan', 'warn');
    else
        Info = imfinfo(fullfile(pathname,filename));
        %dapetin alamat dan nama gambar
        if Info.BitDepth == 1
            msgbox('Citra masukan harus citra RGB atau Grayscale');
            return
        else Info.BitDepth = 8
            gambarTest = imread(fullfile(pathname,filename));
            %baca gambar yang sudah dipilih
            axes(handles.axes1)%tempat tampil di axes1
            cla('reset')
            imshow(gambarTest)
        end
        handles.gambarTest = gambarTest;
        handles.gambarTest2 = gambarTest;
        guidata(hObject,handles);
        set(handles.pushbutton2,'Enable','on', 'BackgroundColor', [0.5 0.5 0.5], 'ForegroundColor', [1 1 1])
        set(handles.pushbutton4,'Enable','on', 'BackgroundColor', [0.64 0.08 0.18], 'ForegroundColor', [1 1 1])
    end
catch ME
    % Tangani kesalahan dan tampilkan pesan kesalahan
    errordlg(['Error: ', ME.message], 'Error', 'modal');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gambarTest = handles.gambarTest;
gscale = rgb2gray(gambarTest);
axes(handles.axes2)
cla('reset')
imshow(gscale)
handles.gscale = gscale;
guidata(hObject,handles);
set(handles.pushbutton3,'Enable','on', 'BackgroundColor', [0.5 0.5 0.5], 'ForegroundColor', [1 1 1])

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gscale = handles.gscale;
sgment = im2bw(gscale,graythresh(gscale));
axes(handles.axes3)
cla('reset')
imshow(sgment)
handles.sgment = sgment;
guidata(hObject,handles);
set(handles.pushbutton5,'Enable','on', 'BackgroundColor', [0.85 0.33 0.1], 'ForegroundColor', [1 1 1])


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes2)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
axes(handles.axes3)
cla('reset')
set(gca,'XTick',[])
set(gca,'YTick',[])
set(handles.text7, 'String', 'Hasil')
data_tabel = get(handles.uitable1, 'Data'); % Menggunakan handle untuk mengakses data tabel
% Mengubah data tabel menjadi array kosong
data_tabel_baru = cell(size(data_tabel)); % Membuat array sel kosong dengan ukuran yang sama
set(handles.uitable1, 'Data', data_tabel_baru); % Mengatur data tabel menjadi array kosong

data_tabel = get(handles.uitable2, 'Data'); % Menggunakan handle untuk mengakses data tabel
% Mengubah data tabel menjadi array kosong
data_tabel_baru = cell(size(data_tabel)); % Membuat array sel kosong dengan ukuran yang sama
set(handles.uitable2, 'Data', data_tabel_baru); % Mengatur data tabel menjadi array kosong
set(handles.pushbutton2,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton3,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton4,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton5,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])
set(handles.pushbutton6,'Enable','off', 'BackgroundColor', [0.8 0.8 0.8], 'ForegroundColor', [0 0 0])


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, ~, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gscale = handles.gscale;
gambarTest = handles.gambarTest;

% Menghitung GLCM
glcm = graycomatrix(gscale, 'Offset', [0 1; -1 1; -1 0; -1 -1]);
normalizedGLCM = glcm / sum(glcm(:));

% Ekstraksi fitur tekstur dari GLCM
stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});

% Pastikan fitur GLCM memiliki ukuran yang benar
fitur_glcm = [mean(stats.Contrast), mean(stats.Correlation), mean(stats.Energy), mean(stats.Homogeneity)];

% Tampilkan data fitur GLCM di tabel
data = get(handles.uitable1,'Data');
data{1,1} = num2str(stats.Contrast(1));
data{1,2} = num2str(stats.Contrast(2));
data{1,3} = num2str(stats.Contrast(3));
data{1,4} = num2str(stats.Contrast(4));
data{2,1} = num2str(stats.Correlation(1));
data{2,2} = num2str(stats.Correlation(2));
data{2,3} = num2str(stats.Correlation(3));
data{2,4} = num2str(stats.Correlation(4));
data{3,1} = num2str(stats.Energy(1));
data{3,2} = num2str(stats.Energy(2));
data{3,3} = num2str(stats.Energy(3));
data{3,4} = num2str(stats.Energy(4));
data{4,1} = num2str(stats.Homogeneity(1));
data{4,2} = num2str(stats.Homogeneity(2));
data{4,3} = num2str(stats.Homogeneity(3));
data{4,4} = num2str(stats.Homogeneity(4));
set(handles.uitable1, 'Data', data)

% Ekstraksi fitur warna dari RGB
red = mean(mean(gambarTest(:,:,1)));
green = mean(mean(gambarTest(:,:,2)));
blue = mean(mean(gambarTest(:,:,3)));
fitur_rgb = [red, green, blue];
% Mengonversi citra ke dalam format HSV
hsv_image = rgb2hsv(gambarTest);

% Normalisasi RGB
normalizedRGB = double(gambarTest) / 255;

% Mendapatkan saluran warna Hue, Saturation, dan Value
H = hsv_image(:,:,1);
S = hsv_image(:,:,2);
V = hsv_image(:,:,3);

% Pastikan fitur HSV memiliki ukuran yang benar
fitur_hsv = [mean(H(:)), mean(S(:)), mean(V(:))];
disp(fitur_hsv);

% Tampilkan data fitur HSV di tabel
uitable2 = findobj('Tag', 'uitable2');

%data2 = get(handles.uitable2,'Data');
data = [H(:), S(:), V(:)];

% Memperbarui data dalam tabel
uitable2.Data = data;

% Simpan fitur ke handles untuk digunakan di pushbutton6
handles.fiturGlcm = fitur_glcm;
handles.fiturHSV = fitur_hsv;
guidata(hObject,handles);
set(handles.pushbutton6,'Enable','on', 'BackgroundColor', [0.85 0.33 0.1], 'ForegroundColor', [1 1 1])

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Memuat model yang telah dilatih
load('model_nb.mat');

%Ambil fitur GLCM dan HSV dari GUI
fiturGlcm = handles.fiturGlcm;
fiturHSV = handles.fiturHSV;

% Pastikan fitur GLCM dan HSV memiliki jumlah baris yang benar
if size(fiturGlcm, 1) ~= 1 || size(fiturGlcm, 2) ~= 4
    error(['Ukuran fitur GLCM tidak benar. Ukuran fitur GLCM: ', mat2str(size(fiturGlcm))]);
end
if size(fiturHSV, 1) ~= 1 || size(fiturHSV, 2) ~= 3
    error(['Ukuran fitur HSV tidak benar. Ukuran fitur HSV: ', mat2str(size(fiturHSV))]);
end

% Gabungkan fitur GLCM dan HSV menjadi satu baris fitur
fitur = [fiturGlcm, fiturHSV];

% Prediksi hasil klasifikasi dan probabilitas tiap kelas
[hasil_prediksi, score] = predict(model_nb, fitur);
% Ambil label kelas dan hitung akurasi, presisi, recall
kelas = categories(model_nb.ClassNames);
total_score = sum(score); % Total score (probabilitas) untuk setiap kelas
% Konversi hasil prediksi menjadi string
hasil_string = sprintf('Prediksi: %s\n', char(hasil_prediksi));
for i = 1:numel(kelas)
    hasil_string = sprintf('%s%s Akurasi: %.2f%%\n', hasil_string, kelas{i}, score(i) * 100);
end
% Tampilkan hasil prediksi di edit text di GUI
set(handles.text7, 'String', hasil_string);


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
