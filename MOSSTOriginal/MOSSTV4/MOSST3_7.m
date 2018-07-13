function MOSST3_7
%Calcula la propension de un aminoacido seleccionado en 'aainPos.txt' en la posicion seleccionada en 'posMut.txt' y la guarda en propensOut.txt

% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida) y MOSST3_3 (matsig, vecsig, numaa, varcomp, procomp,
% matvecsig, numord, NLSDVcrit).
load('MOSST3_1_out.mat');
load('MOSST3_3_out.mat');

% Determina la posicion para la que se van a analizar las posibles
% mutaciones
pos = set_posMut;

% Determina para que aminoacido en la posicion a ser mutada se calcula la
% propension
aapos = set_aaInPos;

% Determina variables para la posicion analizada
varianzas = varcomp(:,pos);
promedios = procomp(:,pos);
aas = numaa(pos);

% Obtiene las probabilidades para la posicion analizada
[probord,aasord] = proponmut2(varianzas,promedios,aas);

% Calcula la propension del aminoacido seleccionado en 'aaInPos' en la
% posicion seleccionada en 'posMut.txt' , y la guarda en propensOut.txt
k = 19;
while (sum(probord(k+1:20)) <= 0.99) && (k >= 1)
    k = k - 1;
end
aas_sigs = 20 - k;

[~, ord] = ismember(aapos,aasord);
k = 21 - ord;
propens = -log10((k/aas_sigs*100)/100);       % Propensity as -log10

fileID = fopen('PropensOut.txt','w');
fprintf(fileID,'%f%',propens);
fclose(fileID);
end