function varargout = untitled2(varargin)
% UNTITLED2 M-file for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 27-Jul-2011 17:40:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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


% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)
warning off all
axes(handles.axes1);
beijing=imread('6.JPG');   
imshow(beijing);
hold on
axis off;
global ww x y 
load jin
y1=ww(2);
x1=ww(1);
v0=0.25*sqrt((y1-y)*(y1-y)+(x1-x)*(x1-x));
alpha=-(180*atan((ww(2)-y)/(ww(1)-x))/pi);
g=9.8;
tEnd=2.7*(v0*sin(alpha*pi/180))/g;
t=linspace(0,tEnd,100);
xx=v0*cos(alpha*pi/180)*t;
yy=v0*sin(alpha*pi/180)*t-0.5*g*t.^2;
pause(0.5);
xxx=10*xx+315;
yyy=-10*yy+385;
if y<390
    msgbox({'你想撞死我么！'},'提示');
else
    if xxx(25)<314
        plot(xxx,yyy,'LineWidth',6)
        msgbox({'猪在那边呢，你打反了！'},'提示');
    else
        if isempty(find(yyy<2))==0
            plot(xxx,yyy,'LineWidth',6);
            msgbox({'我又不是打飞机的炮弹，低点！'},'提示');
        else
            if xxx<900   % 将地面以下的曲线隐藏掉
                xxxx=xxx(1:length(find(yyy<482)));
                yyyy=yyy(1:length(find(yyy<482)));
                plot(xxxx,yyyy,'.-r',xxxx(5:5:end),yyyy(5:5:end),'ow','LineWidth',2);
                set(findobj(get(gca,'Children'),'Color','w'),'LineWidth',5);%设置不同的线宽
            else
                if isempty(find(xxx>960))==0
                    if isempty(find(yyy<230))==0 %不撞，从最上面穿过去
                    else %肯定碰撞
                        xxxxx=xxx(1:length(find(xxx<960)));
                        yyyyy=yyy(1:length(find(xxx<960)));
                        plot(xxxxx,yyyyy,'.-r',xxxxx(5:5:end),yyyyy(5:5:end),'ow','LineWidth',2);
                        set(findobj(get(gca,'Children'),'Color','w'),'LineWidth',5);%设置不同的线宽
%                         axes(handles.axes3);
%                         xiaotu=imread('5.jpg');
%                         imshow(xiaotu);
%                         set(handles.axes3,'Position',[xxx,yyy,10,3.84])
%                         axes(handles.axes1);
                    end
                else  %肯定碰撞
                    plot(xxx,yyy,'.-r',xxx(5:5:end),yyy(5:5:end),'ow','LineWidth',2);
                    set(findobj(get(gca,'Children'),'Color','w'),'LineWidth',5);%设置不同的线宽
                end
            end
        end
    end
end

axes(handles.axes2);
fangzi=imread('7.JPG');   
imshow(fangzi);
% plot(xxx,yyy,'LineWidth',6)
% hold on
% plot(320*ones(1,200),400*rand(1,200),'LineWidth',2) % 竖线
% plot(1200*rand(1,200),52*ones(1,200),'LineWidth',2) % 横线
% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on mouse press over figure background.
function figure1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over figure background, over a disabled or
% --- inactive control, or over an axes background.
function figure1_WindowButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


