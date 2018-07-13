function MOSST3_2
%Elabora las figuras de eliminacion de redundancia (dendrograma y stair plot).
% Carga las variables de salida de MOSST3_1 (alin, protstot, prot_obj,
% arbol, ord_salida). Grafica la figura del dendrograma y la guarda como
% 'Dendrograma.png'. Grafica la figura del stair plot y la guarda como
% 'StairPlot.png'. Elimina la redundancia del alineamiento y entrega un
% alineamiento limpio. Verifica que cada columna del nuevo alineamiento
% tenga al menos un aminoacido y no sea solamente gaps. Si sucede esto
% ultimo, se elimina la columna respectiva del alineamiento.
%
% La salida de la funcion queda grabada como 'MOSST3_2_out.mat', que
% contiene las variables:
% alin: proteinas alineadas en formato MOSST, una por linea, sin
%       redundancia
% largalin: largo total del alineamiento (con gaps), sin redundancia
% critSimil: porcentaje de similitud usado para eliminar proteinas
%            redundantes en el alineamiento
% 
% Esta funcion entrega como salida los archivos:
% Dendrograma.png: dendrograma de aglomeracion de proteinas en el
%                  alineamiento (filogenia)
% StairPlot.png: grafico de aglomeracion de proteinas


% Carga las variables de salida de MOSST3_1 (alin, protstot, prot_obj,
% arbol, ord_salida)
load('MOSST3_1_out.mat');

[~,largalin] = size(alin);
% largalin es el largo del alineamiento, considerando gaps
critSimil = set_critSimil;
% crit es el criterio de similitud maxima para eliminar proteinas
% redundantes. La funci?n set_critSimil es la que asigna el valor y la que
% debe ser cambiada cuando el usuario web entrega otro valor.

% Calcula los valores de X e Y para el stair plot a partir del arbol
Ys = [(ones(size(arbol(:,3)))-arbol(:,3))' 0];
Xs = 0:length(arbol(:,3));

% Grafica la figura del dendrograma y la guarda como 'Dendrograma.png'
scrsz = get(groot,'ScreenSize');
fig1 = figure('Position',scrsz,'Visible','off');
ax1 = gca;
h1 = dendrogram2(arbol,0,ax1,fig1);
for i = 1:length(h1)
    h1(i).LineWidth = 2;
end
set(ax1,'NextPlot','add');
h2 = plot(get(ax1,'Xlim'),[1-critSimil 1-critSimil],'r:','Parent',ax1);
h2.LineWidth = 2;
ax1.XLabel.String = 'Protein order number in alignment';
ax1.FontSize = 16;
ax1.LabelFontSizeMultiplier = 1.5;
ax1.TitleFontSizeMultiplier = 2;
ax1.Title.String = 'Protein Clustering Dendrogram';
ax1.YLabel.String = 'Relative alignment distance';
set(ax1,'NextPlot','replace');
saveas(fig1,'Dendrograma.png');
delete(fig1)

% Grafica la figura del stair plot y la guarda como 'StairPlot.png'
fig1 = figure('Position',scrsz,'Visible','off');
ax1 = gca;
h1 = stairs2(Xs,Ys,ax1,fig1);
h1.LineWidth = 2;
set(ax1,'NextPlot','add');
h2 = plot(get(ax1,'Xlim'),[critSimil critSimil],'r:','Parent',ax1);
h2.LineWidth = 2;
ax1.XLabel.String = 'Number of removed redundant proteins';
ax1.FontSize = 16;
ax1.LabelFontSizeMultiplier = 1.5;
ax1.TitleFontSizeMultiplier = 2;
ax1.Title.String = 'Agglomeration Distance Plot';
ax1.YLabel.String = 'Agglomeration distance';
set(ax1,'NextPlot','replace');
saveas(fig1,'StairPlot.png');
delete(fig1)

% Elimina la redundancia del alineamiento y entrega un alineamiento limpio
distancia = 0;
indice = 0;
while (distancia < (1-critSimil))
    indice = indice + 1;
    distancia = arbol(indice,3);
end
if indice == 0
    prots_quedan = ord_salida;
else
    prots_tot = length(ord_salida);
    prots_quedan = ord_salida(indice:prots_tot);
end

prots_quedan_ord = sort(prots_quedan);
alin_aux = alin(prots_quedan_ord,:);

alin1 = alin_aux;

% Verifica que cada columna del nuevo alineamiento tenga al menos un
% aminoacido y no sea solamente gaps. Si sucede esto ultimo, se elimina la
% columna respectiva del alineamiento.
k = 1;
for i = 1:largalin
    if any(alin1(:,i) ~= '-')
        alinSRed(:,k) = alin1(:,i);
        k = k+1;
    end
end
alin = alinSRed;
[~,largalin] = size(alin);

% Guarda las variables de la funcion para las siguientes funciones
save('MOSST3_2_out.mat','largalin','critSimil','alin');

end

