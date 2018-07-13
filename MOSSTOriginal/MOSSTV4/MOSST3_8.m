function MOSST3_8
%Elabora las figuras y listas de probabilidades de mutacion.
% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil), MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit), MOSST3_4
% (sigConservGlob, LimSigConsGlob, razonAasPos, limRaz) y MOSST3_5
% (contProt, IDPlike, listOrd, listAa, accAas). Calcula las propensiones
% de todos los aminoacidos para todas las posiciones del alineamiento.
% 
% Esta funcion no entrega variables de salida.
%
% Esta funcion entrega como salida los archivos:
% MOSSTPropensities.txt: propensiones en forma de una tabla de valores
%                        separados por comas.
% MOSSTPropensities.xlsx: propensiones en forma de una tabla Excel


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

% Calcula las propensiones de todos los aminoacidos para todas las
% posiciones del alineamiento
probtot = zeros(20,largalin);
propenstot = zeros(20,largalin);
aas = 'ACDEFGHIKLMNPQRSTVWY';
varNames = cell([1 largalin]);
filNames = cell([20 1]);
for i = 1:20
    filNames{i} = aas(i);
end

for i = 1:largalin
    [probordaux,aasordaux] = proponmut2(varcomp(:,i),...
        procomp(:,i),numaa(i));
    k = 19;
    while (sum(probordaux(k+1:20)) <= 0.99) && (k >= 1)
        k = k - 1;
    end
    aas_sigs = 20 - k;
    propens = zeros(20,1);
    for j = 1:20
        [~, ord] = ismember(aas(j),aasordaux);
        k = 21 - ord;
        propens(k) = -log10((k/aas_sigs*100)/100);       % Propensity as -log10
    end
    [~,ind] = sort(aasordaux);
    probtot(:,i) = probordaux(ind);
    propenstot(:,i) = propens(ind);
    nameAux = ['P' num2str(i)];
    varNames{i} = nameAux;
end

T = array2table(propenstot,'VariableNames',varNames,'RowNames',filNames);
T.Properties.DimensionNames = {'Amino acid','Alignment position'};

writetable(T,'MOSSTPropensities.txt','WriteRowNames',true);
writetable(T,'MOSSTPropensities.xlsx','WriteRowNames',true);

end