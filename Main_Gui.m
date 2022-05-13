function varargout = Main_Gui(varargin)
% MAIN_GUI MATLAB code for Main_Gui.fig
%      MAIN_GUI, by itself, creates a new MAIN_GUI or raises the existing
%      singleton*.
%
%      H = MAIN_GUI returns the handle to a new MAIN_GUI or the handle to
%      the existing singleton*.
%
%      MAIN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_GUI.M with the given input arguments.
%
%      MAIN_GUI('Property','Value',...) creates a new MAIN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_Gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_Gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_Gui

% Last Modified by GUIDE v2.5 30-Mar-2022 23:41:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_Gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_Gui_OutputFcn, ...
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


% --- Executes just before Main_Gui is made visible.
function Main_Gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_Gui (see VARARGIN)

% Choose default command line output for Main_Gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_Gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_Gui_OutputFcn(hObject, eventdata, handles) 
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
global im
 [fname,pname] = uigetfile('*.jpg','*.png','Please Select  Image ');
 F1= [pname '\' fname];
text=[pname fname];
set(handles.edit1,'String',text);
im=imread(F1);
 axes(handles.axes1)
 imshow(im);



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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

  h = figure;
  load classifier
    while ishandle(h)
       camera = webcam;
        net = squeezenet;
        featureLayer='fire9-concat';
        YourImage = snapshot(camera);
        axes(handles.axes1)
        image(YourImage)
         img2=cropface(YourImage);
        imageSize = net.Layers(1).InputSize;
        augmentedTestSet = augmentedImageDatastore(imageSize, img2, 'ColorPreprocessing', 'gray2rgb');
        testFeatures = activations(net, augmentedTestSet, featureLayer, ...
        'MiniBatchSize', 32, 'OutputAs', 'columns');
        % Pass CNN image features to trained classifier
            YPred = predict(classifier, testFeatures, 'ObservationsIn', 'columns');
            disp(YPred)
             set(handles.edit2,'String',YPred);
            
            drawnow
    end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global database
database=1;
disp(database);
% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
database=2;
disp(database);


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3
database=3;
disp(database);


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
  
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
blash=get(handles.redo,'SelectedObject')
whatever=get(blash,'string')


blash_cnn=get(handles.CNN,'SelectedObject')
whatever_CNN=get(blash_cnn,'string')

% KNN Classfier

%%% AlexNet and KNN

if (whatever=="JAFFA" && whatever_CNN=="AlexNet")
load info_alexnet/JAFFA/info_Knn
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit3,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="AlexNet")
load info_alexnet/CK/info_Knn
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit3,'String',accuracy);
end


% sequeenze and KNN
if (whatever=="JAFFA" && whatever_CNN=="Squenzee")
load info_sequenzee/JAFFA/info_Knn
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit3,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="Squenzee")
load info_sequenzee/CK/info_Knn
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit3,'String',accuracy);
end


%%% googlenet and KNN

if (whatever=="JAFFA" && whatever_CNN=="GoogleNet")
load info_googlenet/JAFFA/info_Knn
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit3,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="GoogleNet")
load info_googlenet/CK/info_Knn
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit3,'String',accuracy);
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

blash=get(handles.redo,'SelectedObject')
whatever=get(blash,'string')


blash_cnn=get(handles.CNN,'SelectedObject')
whatever_CNN=get(blash_cnn,'string')

% KNN Classfier

%%% AlexNet and SVM

if (whatever=="JAFFA" && whatever_CNN=="AlexNet")
load info_alexnet/JAFFA/info_SVM
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit4,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="AlexNet")
load info_alexnet/CK/info_SVM
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit4,'String',accuracy);
end


% sequeenze and SVM
if (whatever=="JAFFA" && whatever_CNN=="Squenzee")
load info_sequenzee/JAFFA/info_SVM
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit4,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="Squenzee")
load info_sequenzee/CK/info_SVM
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit4,'String',accuracy);
end


%%% googlenet and SVM

if (whatever=="JAFFA" && whatever_CNN=="GoogleNet")
load info_googlenet/JAFFA/info_SVM
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit4,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="GoogleNet")
load info_googlenet/CK/info_SVM
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit4,'String',accuracy);
end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

blash=get(handles.redo,'SelectedObject')
whatever=get(blash,'string')

blash_cnn=get(handles.CNN,'SelectedObject')
whatever_CNN=get(blash_cnn,'string')

% KNN Classfier
%%% AlexNet and Tree

if (whatever=="JAFFA" && whatever_CNN=="AlexNet")
load info_alexnet/JAFFA/info_tree
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit5,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="AlexNet")
load info_alexnet/CK/info_tree
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit5,'String',accuracy);
end


% sequeenze and Tree
if (whatever=="JAFFA" && whatever_CNN=="Squenzee")
load info_sequenzee/JAFFA/info_tree
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit5,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="Squenzee")
load info_sequenzee/CK/info_tree
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit5,'String',accuracy);
end


%%% googlenet and TREE

if (whatever=="JAFFA" && whatever_CNN=="GoogleNet")
load info_googlenet/JAFFA/info_tree
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit5,'String',accuracy);
end

if (whatever=="CK" && whatever_CNN=="GoogleNet")
load info_googlenet/CK/info_tree
cm= confusionchart(C);
[PRTable,accuracy] = helperPrecisionRecall(C)
set(handles.edit5,'String',accuracy);
end

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
