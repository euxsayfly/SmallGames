function varargout = untitled1(varargin)
% UNTITLED1 M-file for untitled1.fig
%      UNTITLED1, by itself, creates a new UNTITLED1 or raises the existing
%      singleton*.
%
%      H = UNTITLED1 returns the handle to a new UNTITLED1 or the handle to
%      the existing singleton*.
%
%      UNTITLED1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED1.M with the given input arguments.
%
%      UNTITLED1('Property','Value',...) creates a new UNTITLED1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled1

% Last Modified by GUIDE v2.5 27-Jul-2011 16:07:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled1_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled1_OutputFcn, ...
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


% --- Executes just before untitled1 is made visible.
function untitled1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled1 (see VARARGIN)
warning off all
axes(handles.axes1);
beijing=imread('4.JPG');   
imshow(beijing);
axis off;
[y,Fs,bits] = wavread('dangong.wav');   % 获取音乐数据
ao = analogoutput('winsound');          % 建立硬件对象
addchannel(ao,[1]);                     % 创建声音输出通道
set(ao,'SampleRate',Fs);                % 设置采样率
data1 =y(:,1);                          % 双声道
putdata(ao,[data1]);                    % 往声卡堆音乐数据
start(ao);                              % 输出音乐数据
handles.ao=ao; 
% Choose default command line output for untitled1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% x=handles.x;
% y=handles.y;
% ww=handles.ww;
ao=handles.ao; 
stop(ao)
cla
close(gcf);
untitled2

% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
% ball1=line(10,10,'color','r','marker','.','erasemode','xor','markersize',60);
axes(handles.axes1);
beijing=imread('4.JPG');   
imshow(beijing);
currPt = get(gca, 'CurrentPoint');
x = currPt(1,1);
y = currPt(1,2);
ww=[310,390];
line([ww(1)-15,x],[ww(2),y-15],'Color','k','LineWidth',4,'clipping','on','erasemode','xor','marker','o','markersize',5); %上线
line([ww(1)+12,x+15],[ww(2),y],'Color','k','LineWidth',4,'clipping','on','erasemode','xor','marker','o','markersize',5);  %下线
line([x,x],[y,y],'Color','r','LineWidth',15,'clipping','on','erasemode','xor','marker','o','markersize',15);  %下线
save jin x y ww

