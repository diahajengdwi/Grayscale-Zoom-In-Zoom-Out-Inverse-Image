function varargout = Tugas(varargin)
% TUGAS MATLAB code for Tugas.fig
%      TUGAS, by itself, creates a new TUGAS or raises the existing
%      singleton*.
%
%      H = TUGAS returns the handle to a new TUGAS or the handle to
%      the existing singleton*.
%
%      TUGAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUGAS.M with the given input arguments.
%
%      TUGAS('Property','Value',...) creates a new TUGAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Tugas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Tugas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Tugas

% Last Modified by GUIDE v2.5 15-Feb-2018 10:22:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tugas_OpeningFcn, ...
                   'gui_OutputFcn',  @Tugas_OutputFcn, ...
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


% --- Executes just before Tugas is made visible.
function Tugas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tugas (see VARARGIN)

% Choose default command line output for Tugas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tugas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tugas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnbrowse.
function btnbrowse_Callback(hObject, eventdata, handles)
% hObject    handle to btnbrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[namafile, formatfile] = uigetfile({'*.jpg','*.png'}, 'Pilih Gambar'); %memilih gambar
global image
image = imread([formatfile, namafile]); %membaca gambar
guidata(hObject, handles);
axes(handles.axes1); %memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar


% --- Executes on button press in btngray.
function btngray_Callback(hObject, eventdata, handles)
% hObject    handle to btngray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
merah =image(:,:,1); % hanya berisi piksel warna merah
ijo = image(:,:,2);% hanya berisi piksel warna merah
biru = image(:,:,3); % hanya berisi piksel warna merah

%ubah warna ke abu2
abu = (0.3 * merah) + (0.5 * ijo) + (0.2 * biru);
image = abu;
axes(handles.axes1); %memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar


% --- Executes on button press in btnin.
function btnin_Callback(hObject, eventdata, handles)
% hObject    handle to btnin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
s = size(image);
f1 = 200;
s2=s*f1;
k=1;
l=1;
for (i=1:f1:s2)
    for( j=1:f1:s2)
        C(i,j)= image(k,l);
        l=l+1;
    end
    l=1;
    k=k+1;
end

for (i=1:f1:s2)
    for (j=2:f1:s2-1)
        C(i,j)= [C(i,j-1)+ C(i, j+1)]*0.5;
    end
end

for(j=1:f1:s2)
    for(i=2:f1:s2-1)
        C(i,j)=[C(i-1,j)+C(i+1,j)]*0.5;
    end
end

for (i=2:f1:s2-1)
    for (j=2:f1:s2-1)
        C(i,j)= [C(i,j-1)+ C(i, j+1)]*0.5;
    end
end
image = C;
axes(handles.axes1); %memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar


% --- Executes on button press in btnout.
function btnout_Callback(hObject, eventdata, handles)
% hObject    handle to btnout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
% ukuran gambar 512X512 --> 256x256 piksel
area=uint8(zeros(256,256));
% menduplikasikan data citra asli
d=zeros(512,512);
for i=1:512;
    for j=1:512;
        d(i,j)=image(i,j);
    end
end
%kompresi dari 512x512 ke 256x256 piksel
for b_asli=1:256
    for k_asli=1:256
        temp=0; dummy=0;
        for b_baru=1:2
            for k_baru=1:2
                dummyb=((b_asli-1)*2 + b_baru);
                dummyk= ((k_asli-1)*2 + k_baru);
                dummy=d(dummyb,dummyk);
                temp=temp+dummy;
            end
        end
        temp=round(temp/4);
        area(b_asli,k_asli)=temp;
    end
end
image = area;
axes(handles.axes1); %memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar


% --- Executes on button press in btninverse.
function btninverse_Callback(hObject, eventdata, handles)
% hObject    handle to btninverse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
nilai = uint8(image);
baris = size(nilai,1);
kolom = size(nilai,2);
for i = 1 : baris
    for j = 1 : kolom
        temp = 255 - nilai(i,j);
        nilai(i,j) = temp;
    end
end
image = nilai;
axes(handles.axes1); %memilih plotori sebagai letak gambar yang dimunculkan
imshow(image); %memunculkan gambar