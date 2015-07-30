function varargout = NEC_PM25_141030(varargin)
% NEC_PM25_141030 MATLAB code for NEC_PM25_141030.fig
%      NEC_PM25_141030, by itself, creates a new NEC_PM25_141030 or raises the existing
%      singleton*.
%
%      H = NEC_PM25_141030 returns the handle to a new NEC_PM25_141030 or the handle to
%      the existing singleton*.
%
%      NEC_PM25_141030('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEC_PM25_141030.M with the given input arguments.
%
%      NEC_PM25_141030('Property','Value',...) creates a new NEC_PM25_141030 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NEC_PM25_141030_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NEC_PM25_141030_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NEC_PM25_141030

% Last Modified by GUIDE v2.5 18-May-2015 09:40:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NEC_PM25_141030_OpeningFcn, ...
                   'gui_OutputFcn',  @NEC_PM25_141030_OutputFcn, ...
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


% --- Executes just before NEC_PM25_141030 is made visible.
function NEC_PM25_141030_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure

% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NEC_PM25_141030 (see VARARGIN)

% Choose default command line output for NEC_PM25_141030
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NEC_PM25_141030 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NEC_PM25_141030_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure

% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)

% handles    structure with handles and user data (see GUIDATA)

%set(handles.text2,'String','adf');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text2.
% --- Executes on button press in Button_run.
function Button_run_Callback(hObject, eventdata, handles)
% hObject    handle to Button_run (see GCBO)

% handles    structure with handles and user data (see GUIDATA)

global conn;
global Timer_1;
global Timer_2;
global Timer_1S;
global Timer_Tlen;
global DATA_LEN;

DATA_LEN=10;    %每次读取和计算的数据量



%启动time
Timer_1 = timer('TimerFcn', {@timerCallback,handles}, 'ExecutionMode', 'fixedDelay', 'Period',30);
start(Timer_1);

Timer_2 = timer('TimerFcn', {@timerCallback2,handles}, 'ExecutionMode', 'fixedDelay', 'Period',1);
start(Timer_2);

set( handles.Button_run, 'Enable', 'off' );


%--------------------读数据定时器函数-----------------------------------
function timerCallback(obj, event,handles) %hEdit handles.edit1
global conn;
global Timer_Tlen;
global DATA_LEN;

DATA_LEN=str2num(get(handles.edit19,'String'));
Timer_1=1/(3600*24);                                                %1秒的时间
Timer_Tlen=Timer_1*30*DATA_LEN;                                     %计算数据包的时间


databaseurl = 'jdbc:mysql://123.127.186.198:3306/aqmonitor';                   % SQLServer2008数据库url
driver = 'com.mysql.jdbc.Driver';                                              % SQLServer2008jdbc驱动
username = 'aqm_read';                                                         % 数据库使用名
password = 'Fen.Nu%$502';                                                      % 数据库密码
databasename = 'aqmonitor';                                                    % 数据库名
conn = database(databasename, username, password, driver, databaseurl);        % 连接数据库
ping(conn)
SQL=conn.AutoCommit;


%times_tart=datenum('2014-12-22 10:50:00','yyyy-mm-dd HH:MM:SS');
times_tart=now;                                                     %读取系统当前时间
datestr(times_tart,31)                                              %显示时间

 set(handles.text_Stime,'String',datestr(times_tart-Timer_Tlen,31)); %显示开始时间和结束时间
 set(handles.text_Etime,'String',datestr(times_tart,31));
 
for i2=1:33
    device_ID_bufe=0;%清空IDbufe
    %读取设置参数
    if(get(handles.chec_device_1, 'Value')==1 && i2==1)
    device_ID_bufe=get(handles.device_id_1, 'String');
    end
    if(get(handles.chec_device_2, 'Value')==1 && i2==2)
    device_ID_bufe=get(handles.device_id_2, 'String');
    end
    if(get(handles.chec_device_3, 'Value')==1 && i2==3)
    device_ID_bufe=get(handles.device_id_3, 'String');
    end
    if(get(handles.chec_device_4, 'Value')==1 && i2==4)
    device_ID_bufe=get(handles.device_id_4, 'String');
    end
    if(get(handles.chec_device_5, 'Value')==1 && i2==5)
    device_ID_bufe=get(handles.device_id_5, 'String');
    end
    if(get(handles.chec_device_6, 'Value')==1 && i2==6)
    device_ID_bufe=get(handles.device_id_6, 'String');
    end
    if(get(handles.chec_device_7, 'Value')==1 && i2==7)
    device_ID_bufe=get(handles.device_id_7, 'String');
    end
    if(get(handles.chec_device_8, 'Value')==1 && i2==8)
    device_ID_bufe=get(handles.device_id_8, 'String');
    end
    if(get(handles.chec_device_9, 'Value')==1 && i2==9)
    device_ID_bufe=get(handles.device_id_9, 'String');
    end
    if(get(handles.chec_device_10, 'Value')==1 && i2==10)
    device_ID_bufe=get(handles.device_id_10, 'String');
    end
    if(get(handles.chec_device_11, 'Value')==1 && i2==11)
    device_ID_bufe=get(handles.device_id_11, 'String');
    end
    if(get(handles.chec_device_12, 'Value')==1 && i2==12)
    device_ID_bufe=get(handles.device_id_12, 'String');
    end
    if(get(handles.chec_device_13, 'Value')==1 && i2==13)
    device_ID_bufe=get(handles.device_id_13, 'String');
    end
    if(get(handles.chec_device_14, 'Value')==1 && i2==14)
    device_ID_bufe=get(handles.device_id_14, 'String');
    end
    if(get(handles.chec_device_15, 'Value')==1 && i2==15)
    device_ID_bufe=get(handles.device_id_15, 'String');
    end
    if(get(handles.chec_device_16, 'Value')==1 && i2==16)
    device_ID_bufe=get(handles.device_id_16, 'String');
    end
    if(get(handles.chec_device_17, 'Value')==1 && i2==17)
    device_ID_bufe=get(handles.device_id_17, 'String');
    end
    if(get(handles.chec_device_18, 'Value')==1 && i2==18)
    device_ID_bufe=get(handles.device_id_18, 'String');
    end
    if(get(handles.chec_device_19, 'Value')==1 && i2==19)
    device_ID_bufe=get(handles.device_id_19, 'String');
    end
    if(get(handles.chec_device_20, 'Value')==1 && i2==20)
    device_ID_bufe=get(handles.device_id_20, 'String');
    end
    
    if(get(handles.chec_device_21, 'Value')==1 && i2==21)
    device_ID_bufe=get(handles.device_id_21, 'String');
    end
    
    if(get(handles.chec_device_22, 'Value')==1 && i2==22)
    device_ID_bufe=get(handles.device_id_22, 'String');
    end
    if(get(handles.chec_device_23, 'Value')==1 && i2==23)
    device_ID_bufe=get(handles.device_id_23, 'String');
    end
    if(get(handles.chec_device_24, 'Value')==1 && i2==24)
    device_ID_bufe=get(handles.device_id_24, 'String');
    end
    if(get(handles.chec_device_25, 'Value')==1 && i2==25)
    device_ID_bufe=get(handles.device_id_25, 'String');
    end
    if(get(handles.chec_device_26, 'Value')==1 && i2==26)
    device_ID_bufe=get(handles.device_id_26, 'String');
    end
    if(get(handles.chec_device_27, 'Value')==1 && i2==27)
    device_ID_bufe=get(handles.device_id_27, 'String');
    end
    if(get(handles.chec_device_28, 'Value')==1 && i2==28)
    device_ID_bufe=get(handles.device_id_28, 'String');
    end
    if(get(handles.chec_device_29, 'Value')==1 && i2==29)
    device_ID_bufe=get(handles.device_id_29, 'String');
    end
    if(get(handles.chec_device_30, 'Value')==1 && i2==30)
    device_ID_bufe=get(handles.device_id_30, 'String');
    end
    if(get(handles.chec_device_31, 'Value')==1 && i2==31)
    device_ID_bufe=get(handles.device_id_31, 'String');
    end
    if(get(handles.chec_device_32, 'Value')==1 && i2==32)
    device_ID_bufe=get(handles.device_id_32, 'String');
    end
    if(get(handles.chec_device_33, 'Value')==1 && i2==33)
    device_ID_bufe=get(handles.device_id_33, 'String');
    end
    
    if(device_ID_bufe>0)                                                 %如果数据有效      
         %SQL语句
         SQL_select=strcat('select *from device_sample WHERE device_id=''',device_ID_bufe,'''and sample_time>=''',datestr(times_tart-Timer_Tlen,31),'''and sample_time<''',datestr(times_tart,31),'''');
         curs = exec(conn, SQL_select);                                     %查找检索
         cur = fetch(curs);                                                %通过 Transact-SQL 服务器游标检索特定行
         a = cur.data;                                                     %读取数据
         sql_SIZE=size(a);                                                  %读取数据大小
        
         if(sql_SIZE(2)>=20)                        %如果有数据（如果有数据列宽是20）
             for i=1:sql_SIZE(1)                    %数据放入缓存
                data_bufe(i,i2)=cell2mat(a(i,26));  %cell转换为doblue
                data_bufe(i,i2)=data_bufe(i,i2)/65536;
             end
             
             if(sql_SIZE(1)<DATA_LEN)                %如果数据不足20组，插前值补足
                 a=DATA_LEN-sql_SIZE(1);
                 for i3=sql_SIZE(1):DATA_LEN
                    data_bufe(i3,i2)=data_bufe(i3-1,i2);
                 end
             end
         end
    end
end
data_bufe(DATA_LEN,41)=0;                           %扩充矩阵大小，避免plot出错。

plot(data_bufe(1:DATA_LEN,1:40));                   %显示折线图
x1=strcat('1均值=',num2str(mean(data_bufe(1:DATA_LEN,1))));       %计算平均值
x2=strcat('2均值=',num2str(mean(data_bufe(1:DATA_LEN,2))));
x3=strcat('3均值=',num2str(mean(data_bufe(1:DATA_LEN,3))));
x4=strcat('4均值=',num2str(mean(data_bufe(1:DATA_LEN,4))));
x5=strcat('5均值=',num2str(mean(data_bufe(1:DATA_LEN,5))));
x6=strcat('6均值=',num2str(mean(data_bufe(1:DATA_LEN,6))));
x7=strcat('7均值=',num2str(mean(data_bufe(1:DATA_LEN,7))));
x8=strcat('8均值=',num2str(mean(data_bufe(1:DATA_LEN,8))));
x9=strcat('9均值=',num2str(mean(data_bufe(1:DATA_LEN,9))));
x10=strcat('10均值=',num2str(mean(data_bufe(1:DATA_LEN,10))));
x11=strcat('11均值=',num2str(mean(data_bufe(1:DATA_LEN,11))));       %计算平均值
x12=strcat('12均值=',num2str(mean(data_bufe(1:DATA_LEN,12))));
x13=strcat('13均值=',num2str(mean(data_bufe(1:DATA_LEN,13))));
x14=strcat('14均值=',num2str(mean(data_bufe(1:DATA_LEN,14))));
x15=strcat('15均值=',num2str(mean(data_bufe(1:DATA_LEN,15))));
x16=strcat('16均值=',num2str(mean(data_bufe(1:DATA_LEN,16))));
x17=strcat('17均值=',num2str(mean(data_bufe(1:DATA_LEN,17))));
x18=strcat('18均值=',num2str(mean(data_bufe(1:DATA_LEN,18))));
x19=strcat('19均值=',num2str(mean(data_bufe(1:DATA_LEN,19))));
x20=strcat('20均值=',num2str(mean(data_bufe(1:DATA_LEN,20))));
x21=strcat('21均值=',num2str(mean(data_bufe(1:DATA_LEN,21))));       %计算平均值
x22=strcat('22均值=',num2str(mean(data_bufe(1:DATA_LEN,22))));
x23=strcat('23均值=',num2str(mean(data_bufe(1:DATA_LEN,23))));
x24=strcat('24均值=',num2str(mean(data_bufe(1:DATA_LEN,24))));
x25=strcat('25均值=',num2str(mean(data_bufe(1:DATA_LEN,25))));
x26=strcat('26均值=',num2str(mean(data_bufe(1:DATA_LEN,26))));
x27=strcat('27均值=',num2str(mean(data_bufe(1:DATA_LEN,27))));
x28=strcat('28均值=',num2str(mean(data_bufe(1:DATA_LEN,28))));
x29=strcat('29均值=',num2str(mean(data_bufe(1:DATA_LEN,29))));
x30=strcat('30均值=',num2str(mean(data_bufe(1:DATA_LEN,30))));
x31=strcat('31均值=',num2str(mean(data_bufe(1:DATA_LEN,31))));       %计算平均值
x32=strcat('32均值=',num2str(mean(data_bufe(1:DATA_LEN,32))));
x33=strcat('33均值=',num2str(mean(data_bufe(1:DATA_LEN,33))));

legend(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25,x26,x27,x28,x29,x30,x31,x32,x33,-1);                      %添加图例的标注

% ------------ 手动刷新--------------
function pushbutton3_Callback(hObject, eventdata, handles)
timerCallback(hObject,eventdata,handles);

%--------------按键检测-----------------------
function figure1_KeyPressFcn(hObject, eventdata, handles)
%若检测到回车
if double(get(gcf,'CurrentCharacter'))==13
	timerCallback(hObject,eventdata,handles);
end

% --- --------------------窗口被建立------------------------------------
function figure1_CreateFcn(hObject, eventdata, handles)

global zhaozhi;
global conn;
global Timer_1S;
global Timer_Tlen;
global Timer_1;
global DATA_LEN;
global ss;
ss=0;

clc;


% --- --------------------窗口退出-----------------------------------
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)

% handles    structure with handles and user data (see GUIDATA)
global Timer_1;
global Timer_2;

stop(Timer_1);
stop(Timer_2);
disp('程序退出'); 


%--------------------进度条-------------------
function timerCallback2(obj, event,handles) %hEdit handles.edit1
global ss;
ss=ss+1;
set( handles.slider3, 'Value', ss );
if(ss>=30)ss=0;end
 
%全选
function checkbox45_Callback(hObject, eventdata, handles)
 if(get(handles.checkbox45, 'Value')==1)
     set(handles.chec_device_1,'Value',1);
     set(handles.chec_device_2,'Value',1);
     set(handles.chec_device_3,'Value',1);
     set(handles.chec_device_4,'Value',1);
     set(handles.chec_device_5,'Value',1);
     set(handles.chec_device_6,'Value',1);
     set(handles.chec_device_7,'Value',1);
     set(handles.chec_device_8,'Value',1);
     set(handles.chec_device_9,'Value',1);
     set(handles.chec_device_10,'Value',1);
     set(handles.chec_device_11,'Value',1);
     set(handles.chec_device_12,'Value',1);
     set(handles.chec_device_13,'Value',1);
     set(handles.chec_device_14,'Value',1);
     set(handles.chec_device_15,'Value',1);
     set(handles.chec_device_16,'Value',1);
     set(handles.chec_device_17,'Value',1);
     set(handles.chec_device_18,'Value',1);
     set(handles.chec_device_19,'Value',1);
     set(handles.chec_device_20,'Value',1);
     set(handles.chec_device_21,'Value',1);
     set(handles.chec_device_22,'Value',1);
     set(handles.chec_device_23,'Value',1);
     set(handles.chec_device_24,'Value',1);
     set(handles.chec_device_25,'Value',1);
     set(handles.chec_device_26,'Value',1);
     set(handles.chec_device_27,'Value',1);
     set(handles.chec_device_28,'Value',1);
     set(handles.chec_device_29,'Value',1);
     set(handles.chec_device_30,'Value',1);
     set(handles.chec_device_31,'Value',1);
     set(handles.chec_device_32,'Value',1);
     set(handles.chec_device_33,'Value',1);
 else
     set(handles.chec_device_1,'Value',0);
     set(handles.chec_device_2,'Value',0);
     set(handles.chec_device_3,'Value',0);
     set(handles.chec_device_4,'Value',0);
     set(handles.chec_device_5,'Value',0);
     set(handles.chec_device_6,'Value',0);
     set(handles.chec_device_7,'Value',0);
     set(handles.chec_device_8,'Value',0);
     set(handles.chec_device_9,'Value',0);
     set(handles.chec_device_10,'Value',0);
     set(handles.chec_device_11,'Value',0);
     set(handles.chec_device_12,'Value',0);
     set(handles.chec_device_13,'Value',0);
     set(handles.chec_device_14,'Value',0);
     set(handles.chec_device_15,'Value',0);
     set(handles.chec_device_16,'Value',0);
     set(handles.chec_device_17,'Value',0);
     set(handles.chec_device_18,'Value',0);
     set(handles.chec_device_19,'Value',0);
     set(handles.chec_device_20,'Value',0);
     set(handles.chec_device_21,'Value',0);
     set(handles.chec_device_22,'Value',0);
     set(handles.chec_device_23,'Value',0);
     set(handles.chec_device_24,'Value',0);
     set(handles.chec_device_25,'Value',0);
     set(handles.chec_device_26,'Value',0);
     set(handles.chec_device_27,'Value',0);
     set(handles.chec_device_28,'Value',0);
     set(handles.chec_device_29,'Value',0);
     set(handles.chec_device_30,'Value',0);
     set(handles.chec_device_31,'Value',0);
     set(handles.chec_device_32,'Value',0);
     set(handles.chec_device_33,'Value',0);
 end
    
 
 
 
 
 %----------------未使用函数----------------------
function device_id_1_CreateFcn(hObject, eventdata, handles)
function device_id_1_Callback(hObject, eventdata, handles)
function device_id_2_Callback(hObject, eventdata, handles)
function device_id_2_CreateFcn(hObject, eventdata, handles)
function device_id_3_Callback(hObject, eventdata, handles)
function device_id_3_CreateFcn(hObject, eventdata, handles)
function device_id_4_Callback(hObject, eventdata, handles)
function device_id_4_CreateFcn(hObject, eventdata, handles)
function device_id_5_Callback(hObject, eventdata, handles)
function device_id_5_CreateFcn(hObject, eventdata, handles)
function device_id_6_Callback(hObject, eventdata, handles)
function device_id_6_CreateFcn(hObject, eventdata, handles)
function device_id_7_Callback(hObject, eventdata, handles)
function device_id_7_CreateFcn(hObject, eventdata, handles)
function device_id_8_Callback(hObject, eventdata, handles)
function device_id_8_CreateFcn(hObject, eventdata, handles)
function device_id_9_Callback(hObject, eventdata, handles)
function device_id_9_CreateFcn(hObject, eventdata, handles)
function device_id_10_Callback(hObject, eventdata, handles)
function device_id_10_CreateFcn(hObject, eventdata, handles)
function chec_device_1_Callback(hObject, eventdata, handles)
function chec_device_2_Callback(hObject, eventdata, handles)
function chec_device_3_Callback(hObject, eventdata, handles)
function chec_device_4_Callback(hObject, eventdata, handles)
function chec_device_5_Callback(hObject, eventdata, handles)
function chec_device_6_Callback(hObject, eventdata, handles)
function chec_device_7_Callback(hObject, eventdata, handles)
function chec_device_8_Callback(hObject, eventdata, handles)
function chec_device_9_Callback(hObject, eventdata, handles)
function chec_device_10_Callback(hObject, eventdata, handles)


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
function slider3_CreateFcn(hObject, eventdata, handles)

function edit19_Callback(hObject, eventdata, handles)
function edit19_CreateFcn(hObject, eventdata, handles)



function device_id_11_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_11 as text
%        str2double(get(hObject,'String')) returns contents of device_id_11 as a double


% --- Executes during object creation, after setting all properties.
function device_id_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_13_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_13 as text
%        str2double(get(hObject,'String')) returns contents of device_id_13 as a double


% --- Executes during object creation, after setting all properties.
function device_id_13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_19_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_19 as text
%        str2double(get(hObject,'String')) returns contents of device_id_19 as a double


% --- Executes during object creation, after setting all properties.
function device_id_19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_12_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_12 as text
%        str2double(get(hObject,'String')) returns contents of device_id_12 as a double


% --- Executes during object creation, after setting all properties.
function device_id_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_14_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_14 as text
%        str2double(get(hObject,'String')) returns contents of device_id_14 as a double


% --- Executes during object creation, after setting all properties.
function device_id_14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_15_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_15 as text
%        str2double(get(hObject,'String')) returns contents of device_id_15 as a double


% --- Executes during object creation, after setting all properties.
function device_id_15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_16_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_16 as text
%        str2double(get(hObject,'String')) returns contents of device_id_16 as a double


% --- Executes during object creation, after setting all properties.
function device_id_16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_17_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_17 as text
%        str2double(get(hObject,'String')) returns contents of device_id_17 as a double


% --- Executes during object creation, after setting all properties.
function device_id_17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_18_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_18 as text
%        str2double(get(hObject,'String')) returns contents of device_id_18 as a double


% --- Executes during object creation, after setting all properties.
function device_id_18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_20_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_20 as text
%        str2double(get(hObject,'String')) returns contents of device_id_20 as a double


% --- Executes during object creation, after setting all properties.
function device_id_20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chec_device_11.
function chec_device_11_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_11


% --- Executes on button press in chec_device_12.
function chec_device_12_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_12


% --- Executes on button press in chec_device_13.
function chec_device_13_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_13


% --- Executes on button press in chec_device_14.
function chec_device_14_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_14


% --- Executes on button press in chec_device_15.
function chec_device_15_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_15


% --- Executes on button press in chec_device_16.
function chec_device_16_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_16


% --- Executes on button press in chec_device_17.
function chec_device_17_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_17


% --- Executes on button press in chec_device_18.
function chec_device_18_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_18


% --- Executes on button press in chec_device_19.
function chec_device_19_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_19


% --- Executes on button press in chec_device_20.
function chec_device_20_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_20



function device_id_21_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_21 as text
%        str2double(get(hObject,'String')) returns contents of device_id_21 as a double


% --- Executes during object creation, after setting all properties.
function device_id_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_23_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_23 as text
%        str2double(get(hObject,'String')) returns contents of device_id_23 as a double


% --- Executes during object creation, after setting all properties.
function device_id_23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_29_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_29 as text
%        str2double(get(hObject,'String')) returns contents of device_id_29 as a double


% --- Executes during object creation, after setting all properties.
function device_id_29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_22_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_22 as text
%        str2double(get(hObject,'String')) returns contents of device_id_22 as a double


% --- Executes during object creation, after setting all properties.
function device_id_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_24_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_24 as text
%        str2double(get(hObject,'String')) returns contents of device_id_24 as a double


% --- Executes during object creation, after setting all properties.
function device_id_24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_25_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_25 as text
%        str2double(get(hObject,'String')) returns contents of device_id_25 as a double


% --- Executes during object creation, after setting all properties.
function device_id_25_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_26_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_26 as text
%        str2double(get(hObject,'String')) returns contents of device_id_26 as a double


% --- Executes during object creation, after setting all properties.
function device_id_26_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_27_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_27 as text
%        str2double(get(hObject,'String')) returns contents of device_id_27 as a double


% --- Executes during object creation, after setting all properties.
function device_id_27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_28_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_28 as text
%        str2double(get(hObject,'String')) returns contents of device_id_28 as a double


% --- Executes during object creation, after setting all properties.
function device_id_28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_30_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_30 as text
%        str2double(get(hObject,'String')) returns contents of device_id_30 as a double


% --- Executes during object creation, after setting all properties.
function device_id_30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chec_device_21.
function chec_device_21_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_21


% --- Executes on button press in chec_device_22.
function chec_device_22_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_22


% --- Executes on button press in chec_device_23.
function chec_device_23_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_23


% --- Executes on button press in chec_device_24.
function chec_device_24_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_24


% --- Executes on button press in chec_device_25.
function chec_device_25_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_25


% --- Executes on button press in chec_device_26.
function chec_device_26_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_26


% --- Executes on button press in chec_device_27.
function chec_device_27_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_27


% --- Executes on button press in chec_device_28.
function chec_device_28_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_28


% --- Executes on button press in chec_device_29.
function chec_device_29_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_29


% --- Executes on button press in chec_device_30.
function chec_device_30_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_30



function device_id_31_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_31 as text
%        str2double(get(hObject,'String')) returns contents of device_id_31 as a double


% --- Executes during object creation, after setting all properties.
function device_id_31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_33_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_33 as text
%        str2double(get(hObject,'String')) returns contents of device_id_33 as a double


% --- Executes during object creation, after setting all properties.
function device_id_33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_39_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_39 as text
%        str2double(get(hObject,'String')) returns contents of device_id_39 as a double


% --- Executes during object creation, after setting all properties.
function device_id_39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_32_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_32 as text
%        str2double(get(hObject,'String')) returns contents of device_id_32 as a double


% --- Executes during object creation, after setting all properties.
function device_id_32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_34_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_34 as text
%        str2double(get(hObject,'String')) returns contents of device_id_34 as a double


% --- Executes during object creation, after setting all properties.
function device_id_34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_35_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_35 as text
%        str2double(get(hObject,'String')) returns contents of device_id_35 as a double


% --- Executes during object creation, after setting all properties.
function device_id_35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_36_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_36 as text
%        str2double(get(hObject,'String')) returns contents of device_id_36 as a double


% --- Executes during object creation, after setting all properties.
function device_id_36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_37_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_37 as text
%        str2double(get(hObject,'String')) returns contents of device_id_37 as a double


% --- Executes during object creation, after setting all properties.
function device_id_37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_38_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_38 as text
%        str2double(get(hObject,'String')) returns contents of device_id_38 as a double


% --- Executes during object creation, after setting all properties.
function device_id_38_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function device_id_40_Callback(hObject, eventdata, handles)
% hObject    handle to device_id_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of device_id_40 as text
%        str2double(get(hObject,'String')) returns contents of device_id_40 as a double


% --- Executes during object creation, after setting all properties.
function device_id_40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to device_id_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chec_device_31.
function chec_device_31_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_31


% --- Executes on button press in chec_device_32.
function chec_device_32_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_32


% --- Executes on button press in chec_device_33.
function chec_device_33_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_33


% --- Executes on button press in chec_device_34.
function chec_device_34_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_34


% --- Executes on button press in chec_device_35.
function chec_device_35_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_35


% --- Executes on button press in chec_device_36.
function chec_device_36_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_36


% --- Executes on button press in chec_device_37.
function chec_device_37_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_37


% --- Executes on button press in chec_device_38.
function chec_device_38_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_38


% --- Executes on button press in chec_device_39.
function chec_device_39_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_39


% --- Executes on button press in chec_device_40.
function chec_device_40_Callback(hObject, eventdata, handles)
% hObject    handle to chec_device_40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of chec_device_40


% --- Executes on key press with focus on pushbutton3 and none of its controls.
function pushbutton3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on figure1 and none of its controls.

% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox45.

% hObject    handle to checkbox45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox45
