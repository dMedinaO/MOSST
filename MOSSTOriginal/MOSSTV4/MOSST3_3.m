function MOSST3_3
%Elabora la figura de determinacion de NLSDV para el alineamiento.
% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida) y MOSST3_2 (alin, critSimil). Calcula las significancias de
% las diferencias de las varianzas para cada componente. Determina el
% numero de orden para calcular el valor critico del NLSDV en la funcion
% clasifsig. Si es 0, NLSDVcrit = 0. Grafica las diferencias de valores
% sucesivos para el alineamiento.
%
% La salida de la funcion queda grabada como 'MOSST3_3_out.mat', que
% contiene las variables:
% matsig: significancia de las varianzas en cada posicion para cada una de
%         las tres componentes, cada una en una linea distinta
% vecsig: significancia de la diferencia de las varianzas para cada
%         posicion del alineamiento multiple (alin) entre cada par de
%         componentes
% numaa: numero de aminoacidos en cada posicion del alineamiento
% varcomp: varianza de cada componente en cada posicion
% procomp: promedio de cada componente en cada posicion
% matvecsig: composicion de matsig y vecsig
% numord: numero de orden de la posicion para el NLSDV critico
% NLSDVcrit: NLSDV critico
%
% Esta funcion entrega como salida el archivo:
% NLSDVcrit.png: grafico de la diferencia de valores sucesivos para la
%                determinacion del NLSDVcrit.



% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida) y MOSST3_2 (alin, critSimil).
load('MOSST3_1_out.mat');
load('MOSST3_2_out.mat');

[~,largalin] = size(alin);
% largalin es el largo del alineamiento sin redundancia, considerando gaps

% Calcula las significancias de las diferencias de las varianzas para cada
% componente
[matsig, vecsig, ~, numaa, varcomp, procomp] = sigdifvar2(alin);
matvecsig = [matsig;vecsig];

% Determina las posiciones inicial y final del alineamiento para graficar
[posini,posfin] = set_posIniFin;

% Determina el numero de orden para calcular el valor critico del NLSDV en
% la funcion clasifsig. Si es 0, NLSDVcrit = 0.
numord = set_Numord;

% Grafica las diferencias de valores sucesivos para el alineamiento
scrsz = get(groot,'ScreenSize');
fig1 = figure('Position',scrsz,'Visible','off');
ax1 = gca;
NLSDVcrit = clasifsig(matvecsig,[posini posfin],1,numord,ax1);
ax1.XLabel.String = 'Position order number';
ax1.FontSize = 16;
ax1.LabelFontSizeMultiplier = 1.5;
ax1.TitleFontSizeMultiplier = 2;
ax1.Title.String = 'Differences in log(NLSDV) between succesive values';
ax1.YLabel.String = 'log(NLSDV) differences';
set(ax1,'NextPlot','replace');
saveas(fig1,'NLSDVcrit.png');
delete(fig1)


% Guarda las variables de la funcion para las siguientes funciones
save('MOSST3_3_out.mat','matsig','vecsig','numaa','varcomp','procomp',...
    'matvecsig','numord','NLSDVcrit');

end