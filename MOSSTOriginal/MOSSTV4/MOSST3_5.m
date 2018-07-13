function MOSST3_5
%Elabora las figuras de determinacion de objetivos de mutagenesis por IDPlikeliness.
% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil), MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit) y MOSST3_4
% (sigConservGlob, LimSigConsGlob, razonAasPos, limRaz). Grafica la
% significancia global de cada posicion y calcula la "IDPlikeliness" de
% cada posicion. Grafica la significancia por componente de cada posicion.
% Entrega la lista de probabilidades de presencia de cada aminoacido en
% cada posicion y el numero de aminoacidos aceptados en cada posicion.
% Registra las probabilidades por aminoacido y determina los permitidos
% como aquellos cuyas probabilidades suman 0.99.
%
% La salida de la funcion queda grabada como 'MOSST3_5_out.mat', que
% contiene las variables:
% contProt: numero de orden de cada gap en la proteina objetivo
% IDPlike : "IDPlikeliness" de cada posicion
% listOrd: lista de probabilidades de presencia de cada aminoacido en cada
%          posicion en orden ascendente
% listAa: lista de aminoacidos correspondientes en listOrd en el mismo
%         orden
% accAas: numero de aminoacidos aceptados en cada posicion
%
% Esta funcion entrega como salida los archivos:
% NLSDVpos.png: grafico de los logaritmos negativos de las significancias
%               de las diferencias de varianzas para cada posicion del
%               alineamiento
% NLSVpos.png: grafico de los logaritmos negativos de las significancias
%               de las varianzas para cada posicion del alineamiento



% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil), MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit) y MOSST3_4
% (sigConservGlob, LimSigConsGlob, razonAasPos, limRaz)
load('MOSST3_1_out.mat');
load('MOSST3_2_out.mat');
load('MOSST3_3_out.mat');
load('MOSST3_4_out.mat');

% Renombra variables para facilitar su manejo posterior
vars = varcomp;
proms = procomp;
sigCons = sigConservGlob;
limSig = LimSigConsGlob;
razAas = razonAasPos;

% Cuenta y asigna un numero de orden a cada gap en la proteina objetivo
cont = 1;
contProt = zeros(size(prot_obj));
for i = 1:length(prot_obj)
    if prot_obj(i) ~= '-'
        contProt(i) = cont;
        cont = cont + 1;
    end
end

% Determina las posiciones entre las cuales se va a graficar
[posini,posfin] = set_posIniFin2;

% Grafica la significancia global de cada posicion y calcula la
% "IDPlikeliness" de cada posicion
scrsz = get(groot,'ScreenSize');
fig1 = figure('Position',scrsz,'Visible','off');
ax1 = gca;
IDPlike = barsig_13(matvecsig, NLSDVcrit, [posini posfin], sigCons, limSig,...
    razAas, limRaz, ax1, prot_obj, contProt);
ax1.XLabel.String = 'Amino acid in the target protein';
ax1.FontSize = 16;
ax1.LabelFontSizeMultiplier = 1.5;
ax1.TitleFontSizeMultiplier = 2;
ax1.Title.String = 'Determination of mutation targets: significances of the difference of variances';
ax1.YLabel.String = 'log(NLSDV)';
set(ax1,'NextPlot','replace');
saveas(fig1,'NLSDVpos.png');
delete(fig1)

% Grafica la significancia por componente de cada posicion
fig1 = figure('Position',scrsz,'Visible','off');
ax1 = gca;
barsig_2(matvecsig, [posini posfin], ax1, fig1);
ax1.XLabel.String = 'Position in the alignment';
ax1.FontSize = 16;
ax1.LabelFontSizeMultiplier = 1.5;
ax1.TitleFontSizeMultiplier = 2;
ax1.Title.String = 'Determination of mutation targets: significances by components';
ax1.YLabel.String = 'log(NLSV)';
set(ax1,'NextPlot','replace');
saveas(fig1,'NLSVpos.png');
% delete(fig1)

% Entrega la lista de probabilidades de presencia de cada aminoacido en
% cada posicion. La lista se entrega en orden ascendente (listOrd), y se
% entrega la lista de aminoacidos correspondientes en el mismo orden
% (listAa). Se entrega ademas el numero de aminoacidos aceptados en cada
% posicion (accAas). Registra las probabilidades por aminoacido y determina
% los permitidos como aquellos cuyas probabilidades suman 0.99.
[listOrd, listAa, accAas] = genMuts(vars, proms, numaa);


% Guarda las variables de la funcion para las siguientes funciones
save('MOSST3_5_out.mat','contProt','IDPlike','listOrd','listAa','accAas');

end