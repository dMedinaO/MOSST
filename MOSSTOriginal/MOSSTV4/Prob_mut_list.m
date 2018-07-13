function varargout = Prob_mut_list(varargin)
%PROB_MUT_LIST MATLAB code file for Prob_mut_list.fig
%      PROB_MUT_LIST, by itself, creates a new PROB_MUT_LIST or raises the existing
%      singleton*.
%
%      H = PROB_MUT_LIST returns the handle to a new PROB_MUT_LIST or the handle to
%      the existing singleton*.
%
%      PROB_MUT_LIST('Property','Value',...) creates a new PROB_MUT_LIST using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to Prob_mut_list_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      PROB_MUT_LIST('CALLBACK') and PROB_MUT_LIST('CALLBACK',hObject,...) call the
%      local function named CALLBACK in PROB_MUT_LIST.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Prob_mut_list

% Last Modified by GUIDE v2.5 21-Aug-2017 09:57:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Prob_mut_list_OpeningFcn, ...
                   'gui_OutputFcn',  @Prob_mut_list_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before Prob_mut_list is made visible.
function Prob_mut_list_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for Prob_mut_list
handles.output = hObject;

probord = varargin{1};
aasord = varargin{2};

% Muestra las probabilidades por aminoacido
i = 19;
color = zeros(20,3);
color(20,1) = 1;
while (sum(probord(i+1:20)) <= 0.99) && (i >= 1)
    color(i,1) = 1;
    i = i - 1;
end

set(handles.text207, 'String', aasord(20), 'ForegroundColor', [color(20,1) color(20,2) color(20,3)]);
set(handles.text208, 'String', aasord(19), 'ForegroundColor', [color(19,1) color(19,2) color(19,3)]);
set(handles.text209, 'String', aasord(18), 'ForegroundColor', [color(18,1) color(18,2) color(18,3)]);
set(handles.text210, 'String', aasord(17), 'ForegroundColor', [color(17,1) color(17,2) color(17,3)]);
set(handles.text211, 'String', aasord(16), 'ForegroundColor', [color(16,1) color(16,2) color(16,3)]);
set(handles.text212, 'String', aasord(15), 'ForegroundColor', [color(15,1) color(15,2) color(15,3)]);
set(handles.text213, 'String', aasord(14), 'ForegroundColor', [color(14,1) color(14,2) color(14,3)]);
set(handles.text214, 'String', aasord(13), 'ForegroundColor', [color(13,1) color(13,2) color(13,3)]);
set(handles.text215, 'String', aasord(12), 'ForegroundColor', [color(12,1) color(12,2) color(12,3)]);
set(handles.text216, 'String', aasord(11), 'ForegroundColor', [color(11,1) color(11,2) color(11,3)]);
set(handles.text217, 'String', aasord(10), 'ForegroundColor', [color(10,1) color(10,2) color(10,3)]);
set(handles.text218, 'String', aasord(9), 'ForegroundColor', [color(9,1) color(9,2) color(9,3)]);
set(handles.text219, 'String', aasord(8), 'ForegroundColor', [color(8,1) color(8,2) color(8,3)]);
set(handles.text220, 'String', aasord(7), 'ForegroundColor', [color(7,1) color(7,2) color(7,3)]);
set(handles.text221, 'String', aasord(6), 'ForegroundColor', [color(6,1) color(6,2) color(6,3)]);
set(handles.text222, 'String', aasord(5), 'ForegroundColor', [color(5,1) color(5,2) color(5,3)]);
set(handles.text223, 'String', aasord(4), 'ForegroundColor', [color(4,1) color(4,2) color(4,3)]);
set(handles.text224, 'String', aasord(3), 'ForegroundColor', [color(3,1) color(3,2) color(3,3)]);
set(handles.text225, 'String', aasord(2), 'ForegroundColor', [color(2,1) color(2,2) color(2,3)]);
set(handles.text226, 'String', aasord(1), 'ForegroundColor', [color(1,1) color(1,2) color(1,3)]);

set(handles.text227, 'String', num2str(round(probord(20)*1000)/10,'%4.1f'), 'ForegroundColor', [color(20,1) color(20,2) color(20,3)]);
set(handles.text228, 'String', num2str(round(probord(19)*1000)/10,'%4.1f'), 'ForegroundColor', [color(19,1) color(19,2) color(19,3)]);
set(handles.text229, 'String', num2str(round(probord(18)*1000)/10,'%4.1f'), 'ForegroundColor', [color(18,1) color(18,2) color(18,3)]);
set(handles.text230, 'String', num2str(round(probord(17)*1000)/10,'%4.1f'), 'ForegroundColor', [color(17,1) color(17,2) color(17,3)]);
set(handles.text231, 'String', num2str(round(probord(16)*1000)/10,'%4.1f'), 'ForegroundColor', [color(16,1) color(16,2) color(16,3)]);
set(handles.text232, 'String', num2str(round(probord(15)*1000)/10,'%4.1f'), 'ForegroundColor', [color(15,1) color(15,2) color(15,3)]);
set(handles.text233, 'String', num2str(round(probord(14)*1000)/10,'%4.1f'), 'ForegroundColor', [color(14,1) color(14,2) color(14,3)]);
set(handles.text234, 'String', num2str(round(probord(13)*1000)/10,'%4.1f'), 'ForegroundColor', [color(13,1) color(13,2) color(13,3)]);
set(handles.text235, 'String', num2str(round(probord(12)*1000)/10,'%4.1f'), 'ForegroundColor', [color(12,1) color(12,2) color(12,3)]);
set(handles.text236, 'String', num2str(round(probord(11)*1000)/10,'%4.1f'), 'ForegroundColor', [color(11,1) color(11,2) color(11,3)]);
set(handles.text237, 'String', num2str(round(probord(10)*1000)/10,'%4.1f'), 'ForegroundColor', [color(10,1) color(10,2) color(10,3)]);
set(handles.text238, 'String', num2str(round(probord(9)*1000)/10,'%4.1f'), 'ForegroundColor', [color(9,1) color(9,2) color(9,3)]);
set(handles.text239, 'String', num2str(round(probord(8)*1000)/10,'%4.1f'), 'ForegroundColor', [color(8,1) color(8,2) color(8,3)]);
set(handles.text240, 'String', num2str(round(probord(7)*1000)/10,'%4.1f'), 'ForegroundColor', [color(7,1) color(7,2) color(7,3)]);
set(handles.text241, 'String', num2str(round(probord(6)*1000)/10,'%4.1f'), 'ForegroundColor', [color(6,1) color(6,2) color(6,3)]);
set(handles.text242, 'String', num2str(round(probord(5)*1000)/10,'%4.1f'), 'ForegroundColor', [color(5,1) color(5,2) color(5,3)]);
set(handles.text243, 'String', num2str(round(probord(4)*1000)/10,'%4.1f'), 'ForegroundColor', [color(4,1) color(4,2) color(4,3)]);
set(handles.text244, 'String', num2str(round(probord(3)*1000)/10,'%4.1f'), 'ForegroundColor', [color(3,1) color(3,2) color(3,3)]);
set(handles.text245, 'String', num2str(round(probord(2)*1000)/10,'%4.1f'), 'ForegroundColor', [color(2,1) color(2,2) color(2,3)]);
set(handles.text246, 'String', num2str(round(probord(1)*1000)/10,'%4.1f'), 'ForegroundColor', [color(1,1) color(1,2) color(1,3)]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Prob_mut_list wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Prob_mut_list_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
