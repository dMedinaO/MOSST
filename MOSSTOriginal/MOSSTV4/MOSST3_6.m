function MOSST3_6
%Elabora las figuras y listas de probabilidades de mutacion.
% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil), MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit), MOSST3_4
% (sigConservGlob, LimSigConsGlob, razonAasPos, limRaz) y MOSST3_5
% (contProt, IDPlike, listOrd, listAa, accAas). Determina la posicion para
% la que se van a analizar las posibles mutaciones. Obtiene las
% probabilidades para la posicion analizada. Grafica las barras y la lista
% de probabilidades. Calcula la propension del aminoacido seleccionado en
% 'aaInPos' en la posicion 'pos' seleccionada, y la guarda en
% propensOut.txt
%
% Esta funcion no entrega variables de salida.
%
% Esta funcion entrega como salida los archivos:
% MutPropPlot.png: grafico de probabilidades de ocurrencia para todos los
%                  aminoacidos en la posicion del alineamiento seleccionada
% MutPropList.txt: tabla de probabilidades de ocurrencia para todos los
%                  aminoacidos en la posicion del alineamiento
%                  seleccionada. La tercera columna es el color del
%                  aminoacido: 0 es negro, 1 es rojo, 2 es azul, 3 es
%                  magenta.
% propensOut.txt: archivo de texto con el numero correspondiente a la
%                 propension calculada para la posicion seleccionada en
%                 aaInPos.txt


% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil), MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit), MOSST3_4
% (sigConservGlob, LimSigConsGlob, razonAasPos, limRaz) y MOSST3_5
% (contProt, IDPlike, listOrd, listAa, accAas).
load('MOSST3_1_out.mat');
load('MOSST3_2_out.mat');
load('MOSST3_3_out.mat');
load('MOSST3_4_out.mat');
load('MOSST3_5_out.mat');

% Determina la posicion para la que se van a analizar las posibles
% mutaciones
pos = set_posMut;

% Determina variables para la posicion analizada
varianzas = varcomp(:,pos);
promedios = procomp(:,pos);
aas = numaa(pos);
aaObj = prot_obj(pos);

% Obtiene las probabilidades para la posicion analizada
[probord,aasord] = proponmut2(varianzas,promedios,aas);

% Grafica las barras de probabilidades
scrsz = get(groot,'ScreenSize');
fig1 = figure('Position',scrsz,'Visible','off');
ax1 = gca;
barh_2(probord,ax1,fig1,aasord);
ax1.XLabel.String = 'Probability of occurrence';
ax1.FontSize = 16;
ax1.LabelFontSizeMultiplier = 1.5;
ax1.TitleFontSizeMultiplier = 2;
ax1.Title.String = 'Determination of mutation propensities';
ax1.YLabel.String = 'Amino acid';
set(ax1,'NextPlot','replace');
saveas(fig1,'MutPropPlot.png');
delete(fig1)

% Grafica la lista de probabilidades
% fig2 = Prob_mut_list(probord,aasord,aaObj);
% set(fig2,'Visible','off','PaperPositionMode','auto');
% saveas(fig2,'MutPropList.png');
% delete(fig2);

% Imprime la lista de probabilidades como archivo de texto
i = 19;
k = 1;
fileID = fopen('MutPropList.txt','w');
if (aasord(20) == aaObj) && k
    color = 3;
    k = 0;
else
    color = 1;
end
fprintf(fileID,'%c %f %d\n',aasord(20),probord(20)*100,color);
while (sum(probord(i+1:20)) <= 0.985) && (i >= 1)
    if (aasord(i) == aaObj) && k
        color = 3;
        k = 0;
    else
        color = 1;
    end
    fprintf(fileID,'%c %f %d\n',aasord(i),probord(i)*100,color);
    i = i - 1;
end
for j=i:-1:1
    if (aasord(j) == aaObj) && k
        color = 2;
        k = 0;
    else
        color = 0;
    end
    fprintf(fileID,'%c %f %d\n',aasord(j),probord(j)*100,color);
end
fclose(fileID);

% Calcula la propension del aminoacido seleccionado en 'aaInPos.txt' en la
% posicion seleccionada en '.txt' , y la guarda en propensOut.txt
MOSST3_7

end
