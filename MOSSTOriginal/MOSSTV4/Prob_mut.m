function varargout = Prob_mut(varargin)
% PROB_MUT Application M-file for Prob_mut.fig
%    FIG = PROB_MUT launch Prob_mut GUI.
%    PROB_MUT('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.5 02-Oct-2012 17:05:32

if nargin == 0 || isnumeric(varargin{1})  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
    handles.varianzas = varargin{1};
    handles.promedios = varargin{2};
    handles.aas = varargin{3};
    handles.pos = varargin{4};
    handles.aa_obj = varargin{5};
    handles.IDPlike = varargin{6};
    handles.posini = varargin{7};
    handles.posfin = varargin{8};
    handles.accAas = varargin{9};
    guidata(fig, handles);
    
    % Muestra la posicion
    set(handles.text108, 'String', num2str(varargin{4}),...
        'ForegroundColor', [1 0 0]);
    if ~isempty(handles.aa_obj)
        set(handles.text112, 'String', handles.aa_obj,...
            'ForegroundColor', [1 0 0]);
    end
    
    % Obtiene las probabilidades
    [probord,aasord] = proponmut2(varargin{1},varargin{2},varargin{3});
        
    % Grafica las barras de probabilidades
    barh_2(probord,handles.axes1,handles.figure1,aasord);
    
    % Muestra las probabilidades por aminoacido
    i = 19;
    color = zeros(20,3);
    %     lim_probord = max(probord)/100;
    %     while (round(probord(i)*1000)/1000 >= 0.01) & (i >= 1)
    %  while (probord(i) >= lim_probord) & (i >= 1)
    color(20,1) = 1;
    while (sum(probord(i+1:20)) <= 0.99) && (i >= 1)
        color(i,1) = 1;
        i = i - 1;
    end
    
    handles.aas_sigs = 20 - i;
    handles.aas_ord = aasord;
	
    set(handles.text63, 'String', aasord(20), 'ForegroundColor', [color(20,1) color(20,2) color(20,3)]);
    set(handles.text67, 'String', aasord(19), 'ForegroundColor', [color(19,1) color(19,2) color(19,3)]);
    set(handles.text68, 'String', aasord(18), 'ForegroundColor', [color(18,1) color(18,2) color(18,3)]);
    set(handles.text69, 'String', aasord(17), 'ForegroundColor', [color(17,1) color(17,2) color(17,3)]);
    set(handles.text70, 'String', aasord(16), 'ForegroundColor', [color(16,1) color(16,2) color(16,3)]);
    set(handles.text71, 'String', aasord(15), 'ForegroundColor', [color(15,1) color(15,2) color(15,3)]);
    set(handles.text72, 'String', aasord(14), 'ForegroundColor', [color(14,1) color(14,2) color(14,3)]);
    set(handles.text73, 'String', aasord(13), 'ForegroundColor', [color(13,1) color(13,2) color(13,3)]);
    set(handles.text74, 'String', aasord(12), 'ForegroundColor', [color(12,1) color(12,2) color(12,3)]);
    set(handles.text75, 'String', aasord(11), 'ForegroundColor', [color(11,1) color(11,2) color(11,3)]);
    set(handles.text76, 'String', aasord(10), 'ForegroundColor', [color(10,1) color(10,2) color(10,3)]);
    set(handles.text77, 'String', aasord(9), 'ForegroundColor', [color(9,1) color(9,2) color(9,3)]);
    set(handles.text78, 'String', aasord(8), 'ForegroundColor', [color(8,1) color(8,2) color(8,3)]);
    set(handles.text79, 'String', aasord(7), 'ForegroundColor', [color(7,1) color(7,2) color(7,3)]);
    set(handles.text80, 'String', aasord(6), 'ForegroundColor', [color(6,1) color(6,2) color(6,3)]);
    set(handles.text81, 'String', aasord(5), 'ForegroundColor', [color(5,1) color(5,2) color(5,3)]);
    set(handles.text82, 'String', aasord(4), 'ForegroundColor', [color(4,1) color(4,2) color(4,3)]);
    set(handles.text83, 'String', aasord(3), 'ForegroundColor', [color(3,1) color(3,2) color(3,3)]);
    set(handles.text84, 'String', aasord(2), 'ForegroundColor', [color(2,1) color(2,2) color(2,3)]);
    set(handles.text85, 'String', aasord(1), 'ForegroundColor', [color(1,1) color(1,2) color(1,3)]);
    
    set(handles.text86, 'String', num2str(round(probord(20)*1000)/10,'%4.1f'), 'ForegroundColor', [color(20,1) color(20,2) color(20,3)]);
    set(handles.text87, 'String', num2str(round(probord(19)*1000)/10,'%4.1f'), 'ForegroundColor', [color(19,1) color(19,2) color(19,3)]);
    set(handles.text88, 'String', num2str(round(probord(18)*1000)/10,'%4.1f'), 'ForegroundColor', [color(18,1) color(18,2) color(18,3)]);
    set(handles.text89, 'String', num2str(round(probord(17)*1000)/10,'%4.1f'), 'ForegroundColor', [color(17,1) color(17,2) color(17,3)]);
    set(handles.text90, 'String', num2str(round(probord(16)*1000)/10,'%4.1f'), 'ForegroundColor', [color(16,1) color(16,2) color(16,3)]);
    set(handles.text91, 'String', num2str(round(probord(15)*1000)/10,'%4.1f'), 'ForegroundColor', [color(15,1) color(15,2) color(15,3)]);
    set(handles.text92, 'String', num2str(round(probord(14)*1000)/10,'%4.1f'), 'ForegroundColor', [color(14,1) color(14,2) color(14,3)]);
    set(handles.text93, 'String', num2str(round(probord(13)*1000)/10,'%4.1f'), 'ForegroundColor', [color(13,1) color(13,2) color(13,3)]);
    set(handles.text94, 'String', num2str(round(probord(12)*1000)/10,'%4.1f'), 'ForegroundColor', [color(12,1) color(12,2) color(12,3)]);
    set(handles.text95, 'String', num2str(round(probord(11)*1000)/10,'%4.1f'), 'ForegroundColor', [color(11,1) color(11,2) color(11,3)]);
    set(handles.text96, 'String', num2str(round(probord(10)*1000)/10,'%4.1f'), 'ForegroundColor', [color(10,1) color(10,2) color(10,3)]);
    set(handles.text97, 'String', num2str(round(probord(9)*1000)/10,'%4.1f'), 'ForegroundColor', [color(9,1) color(9,2) color(9,3)]);
    set(handles.text98, 'String', num2str(round(probord(8)*1000)/10,'%4.1f'), 'ForegroundColor', [color(8,1) color(8,2) color(8,3)]);
    set(handles.text99, 'String', num2str(round(probord(7)*1000)/10,'%4.1f'), 'ForegroundColor', [color(7,1) color(7,2) color(7,3)]);
    set(handles.text100, 'String', num2str(round(probord(6)*1000)/10,'%4.1f'), 'ForegroundColor', [color(6,1) color(6,2) color(6,3)]);
    set(handles.text101, 'String', num2str(round(probord(5)*1000)/10,'%4.1f'), 'ForegroundColor', [color(5,1) color(5,2) color(5,3)]);
    set(handles.text102, 'String', num2str(round(probord(4)*1000)/10,'%4.1f'), 'ForegroundColor', [color(4,1) color(4,2) color(4,3)]);
    set(handles.text103, 'String', num2str(round(probord(3)*1000)/10,'%4.1f'), 'ForegroundColor', [color(3,1) color(3,2) color(3,3)]);
    set(handles.text104, 'String', num2str(round(probord(2)*1000)/10,'%4.1f'), 'ForegroundColor', [color(2,1) color(2,2) color(2,3)]);
    set(handles.text105, 'String', num2str(round(probord(1)*1000)/10,'%4.1f'), 'ForegroundColor', [color(1,1) color(1,2) color(1,3)]);
    
%     varPos = round(fitHalfNormAas(probord(20:-1:1))*10000)/10000
    
    [~, ord] = ismember(handles.aa_obj, handles.aas_ord);
    handles.num_aa = 21 - ord;
%     handles.propens_rat = round(handles.num_aa/handles.aas_sigs*100)/100;
    handles.propens_rat = -log10((handles.num_aa/handles.aas_sigs*100)/100);
    % Ajusta la propensitud del aminoacido en la proteina analizada
    set(handles.text116, 'String', num2str(round(handles.propens_rat*1000)/1000));
    
    % Ajusta la aceptancia en la posición analizada
    prob_max = probord(20);
    if handles.aas_sigs ~= 20
        prob_min = probord(20 - handles.aas_sigs);
    else
        prob_min = 0;
    end
    largo = (handles.aas_sigs-1)/20;
    angulo = round(atan((prob_max - prob_min)/largo)/pi*2*1000)/1000;
    set(handles.text118, 'String', num2str(angulo));
%     set(handles.text118, 'String', num2str(varPos));
    guidata(fig, handles);
    
    % Grafica la IDP-likeness
    largoIdp = handles.posfin - handles.posini;
    set(handles.axes2, 'NextPlot', 'add');
    colorIdp = [interp1([1;0.5;0],[1;1;1],handles.IDPlike); interp1([1;0.5;0],[0;0.95;1],handles.IDPlike); interp1([1;0.5;0],[0;0.95;1],handles.IDPlike)]';
    if largoIdp > 150
        for i = handles.posini:handles.posfin
            bar(handles.axes2,i,handles.IDPlike(i), 'FaceColor', colorIdp(i,:), 'EdgeColor', 'none');
        end
    else
        for i = handles.posini:handles.posfin
            bar(handles.axes2,i,handles.IDPlike(i), 'FaceColor', colorIdp(i,:));
        end
    end
    set(handles.axes2,'XLim',[handles.posini-1 handles.posfin+1]);
    
    % Espera la respuesta del usuario al apretar el boton OK
    uiwait(fig);
    
    % Borra la figura y retorna
    if ishandle(fig)
        delete(fig);
    end
    
elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
	catch
		disp(lasterr);
	end

end


%| ABOUT CALLBACKS:
%| GUIDE automatically appends subfunction prototypes to this file, and 
%| sets objects' callback properties to call them through the FEVAL 
%| switchyard above. This comment describes that mechanism.
%|
%| Each callback subfunction declaration has the following form:
%| <SUBFUNCTION_NAME>(H, EVENTDATA, HANDLES, VARARGIN)
%|
%| The subfunction name is composed using the object's Tag and the 
%| callback type separated by '_', e.g. 'slider2_Callback',
%| 'figure1_CloseRequestFcn', 'axis1_ButtondownFcn'.
%|
%| H is the callback object's handle (obtained using GCBO).
%|
%| EVENTDATA is empty, but reserved for future use.
%|
%| HANDLES is a structure containing handles of components in GUI using
%| tags as fieldnames, e.g. handles.figure1, handles.slider2. This
%| structure is created at GUI startup using GUIHANDLES and stored in
%| the figure's application data using GUIDATA. A copy of the structure
%| is passed to each callback.  You can store additional information in
%| this structure at GUI startup, and you can change the structure
%| during callbacks.  Call guidata(h, handles) after changing your
%| copy to replace the stored original so that subsequent callbacks see
%| the updates. Type "help guihandles" and "help guidata" for more
%| information.
%|
%| VARARGIN contains any extra arguments you have passed to the
%| callback. Specify the extra arguments by editing the callback
%| property in the inspector. By default, GUIDE sets the property to:
%| <MFILENAME>('<SUBFUNCTION_NAME>', gcbo, [], guidata(gcbo))
%| Add any extra arguments after the last argument, before the final
%| closing parenthesis.



% --------------------------------------------------------------------
function varargout = pushbutton1_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton1.
uiresume(handles.figure1);


% --------------------------------------------------------------------
function varargout = pushbutton2_Callback(h, eventdata, handles, varargin)
% Stub for Callback of the uicontrol handles.pushbutton2.
handlefig = Prob_mut_imp(handles.varianzas,handles.promedios,...
    handles.aas,handles.pos,handles.aa_obj);
[imprimir,salida,resol,archiv] = Imprimir_grafico;
if imprimir
    if salida == 1
        print(handlefig,'-v');
    elseif salida == 2
        fig = openfig('Procesando.fig','reuse');
        set(fig,'WindowStyle','modal');
        print(handlefig,'-djpeg',['-r' resol],archiv);
        delete(fig);
    elseif salida == 3
        fig = openfig('Procesando.fig','reuse');
        set(fig,'WindowStyle','modal');
        print(handlefig,'-dtiff',['-r' resol],archiv);
        delete(fig);
    end
end
delete(handlefig);



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
aa = get(handles.edit1,'String');
conj_aa = 'ACDEFGHIKLMNPQRSTVWY';
aa = upper(aa);
if ~ ismember(aa, conj_aa)
    aa = handles.aa_obj;
end
[~, ord] = ismember(aa, handles.aas_ord);
handles.num_aa = 21 - ord;
% handles.propens_rat = round(handles.num_aa/handles.aas_sigs*100)/100;     % Raw propensity
handles.propens_rat = -log10((handles.num_aa/handles.aas_sigs*100)/100);       % Propensity as -log10
guidata(hObject,handles)
set(handles.text116, 'String', num2str(round(handles.propens_rat*1000)/1000));
pause(0.1);

    


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


% --- Executes when selected object is changed in uipanel1.
function uipanel1_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel1 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'radiobutton1'
        % Code for when radiobutton1 is selected.
        largoIdp = handles.posfin - handles.posini;
        set(handles.axes2, 'NextPlot', 'replace');
        colorIdp = [interp1([1;0.5;0],[1;1;1],handles.IDPlike); interp1([1;0.5;0],[0;0.95;1],handles.IDPlike); interp1([1;0.5;0],[0;0.95;1],handles.IDPlike)]';
        if largoIdp > 150
            bar(handles.axes2,handles.posini,handles.IDPlike(handles.posini), 'FaceColor', colorIdp(handles.posini,:), 'EdgeColor', 'none');
            set(handles.axes2, 'NextPlot', 'add');
            for i = (handles.posini+1):handles.posfin
                bar(handles.axes2,i,handles.IDPlike(i), 'FaceColor', colorIdp(i,:), 'EdgeColor', 'none');
            end
        else
            bar(handles.axes2,handles.posini,handles.IDPlike(handles.posini), 'FaceColor', colorIdp(handles.posini,:));
            set(handles.axes2, 'NextPlot', 'add');
            for i = (handles.posini+1):handles.posfin
                bar(handles.axes2,i,handles.IDPlike(i), 'FaceColor', colorIdp(i,:));
            end
        end
        set(handles.axes2,'XLim',[handles.posini-1 handles.posfin+1]);
    case 'radiobutton2'
        % Code for when radiobutton2 is selected.
        largoIdp = handles.posfin - handles.posini;
        set(handles.axes2, 'NextPlot', 'replace');
        colorIdp = [interp1([0;10;20],[0;0.5;1],handles.accAas); interp1([0;10;20],[0;0.5;1],handles.accAas); interp1([0;10;20],[1;1;1],handles.accAas)]';
        if largoIdp > 150
            bar(handles.axes2,handles.posini,20-handles.accAas(handles.posini), 'FaceColor', colorIdp(handles.posini,:), 'EdgeColor', 'none');
            set(handles.axes2, 'NextPlot', 'add');
            for i = (handles.posini+1):handles.posfin
                bar(handles.axes2,i,20-handles.accAas(i), 'FaceColor', colorIdp(i,:), 'EdgeColor', 'none');
            end
        else
            bar(handles.axes2,handles.posini,20-handles.accAas(handles.posini), 'FaceColor', colorIdp(handles.posini,:));
            set(handles.axes2, 'NextPlot', 'add');
            for i = (handles.posini+1):handles.posfin
                bar(handles.axes2,i,20-handles.accAas(i), 'FaceColor', colorIdp(i,:));
            end
        end
        set(handles.axes2,'XLim',[handles.posini-1 handles.posfin+1]);
        set(handles.axes2,'YLim',[0 20]);
end