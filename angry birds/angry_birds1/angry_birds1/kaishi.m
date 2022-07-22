function varargout = kaishi(varargin)
% KAISHI M-file for kaishi.fig
%      KAISHI, by itself, creates a new KAISHI or raises the existing
%      singleton*.
%
%      H = KAISHI returns the handle to a new KAISHI or the handle to
%      the existing singleton*.
%
%      KAISHI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KAISHI.M with the given input arguments.
%
%      KAISHI('Property','Value',...) creates a new KAISHI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kaishi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kaishi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kaishi

% Last Modified by GUIDE v2.5 25-Jul-2011 23:36:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kaishi_OpeningFcn, ...
                   'gui_OutputFcn',  @kaishi_OutputFcn, ...
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

% --- Executes just before kaishi is made visible.
function kaishi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kaishi (see VARARGIN)
warning off all
axes(handles.axes1);
beijing=imread('1.JPG');   
imshow(beijing);
anniu=imread('2.jpg');
set(handles.pushbutton1,'cdata',anniu);
anniu2=imread('3.jpg');
set(handles.pushbutton2,'cdata',anniu2);
[y,Fs,bits] = wavread('music.wav');   % 获取音乐数据
ao = analogoutput('winsound');        % 建立硬件对象
addchannel(ao,[1]);                   % 创建声音输出通道
set(ao,'SampleRate',Fs);              % 设置采样率
data1 =y(:,1);                        % 双声道
putdata(ao,[data1]);                  % 往声卡堆音乐数据
start(ao);                            % 输出音乐数据
handles.ao=ao; 

% Choose default command line output for kaishi
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kaishi wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = kaishi_OutputFcn(hObject, eventdata, handles) 
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
close(gcf);
untitled1;

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ao=handles.ao; 
stop(ao);
close(gcf);
