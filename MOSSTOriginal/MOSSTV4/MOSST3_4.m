function MOSST3_4
%Calcula las significancias de las conservaciones globales y las distribuciones de aminoacidos permitidos en cada posicion.
% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil) y MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit). Calcula los
% aminoacidos aceptados en cada posicion. Determina el cutoff minimo a
% partir de tres calculos de cortes diferentes y el limite de la
% significancia de conservacion global. Determina las significancias
% globales de conservacion para cada posicion y el numero de aminoacidos
% aceptados a partir de la distribucion de probabilidades en cada posicion.
% Cuenta y asigna un numero de orden a cada gap en la proteina objetivo.
% 
% La salida de la funcion queda grabada como 'MOSST3_4_out.mat', que
% contiene las variables:
% sigConservGlob: significancia de la conservacion global en cada posicion
% LimSigConsGlob: limite de la significancia de conservacion global fuera
%                 del que los aminoacidos serian considerados como
%                 poco significativos
% razonAasPos: razon de aminoacidos significativos en cada posicion
% limRaz: cutoff limite de la razon de aminoacidos significativos
%
% Esta funcion no entrega archivos de salida.


% Carga las variables de salida de MOSST3_1 (protstot, prot_obj, arbol,
% ord_salida), MOSST3_2 (alin, critSimil) y MOSST3_3 (matsig, vecsig,
% numaa, varcomp, procomp, matvecsig, numord, NLSDVcrit)
load('MOSST3_1_out.mat');
load('MOSST3_2_out.mat');
load('MOSST3_3_out.mat');

[m,~] = size(alin);
% largalin es el largo del alineamiento sin redundancia, considerando gaps

% Calcula los aminoacidos aceptados en cada posicion
[~, razonAasPos, ~, ~, catsRazonAas, razonAasCumProb] =...
    calcNumAasAccepted(varcomp, procomp, numaa, m);

cutsNumaa = cutsDistMultVars(0.05);
% cutsNumaa es el corte para determinar los amino?cidos permitidos para una
% posicion determinada. Esta es la version fija, a dedo.

sigConservGlobProtFam = cutsNumaa(numaa);
cutsNumaa2 = cutsDistMultVars2(1:30);
% cutsNumaa2 es la version distribuida entre los primeros.

[catsProtFam, cumpProtFam, normConst, addFactor] = cumDistBuilder(sigConservGlobProtFam);
[quadProtFam, ~, ~] = quadLineFit(catsProtFam, cumpProtFam, 'pchip', 'noplot');
cutsNumaa3 = ones(size(cutsNumaa)).*(quadProtFam(7)*normConst + addFactor);
% cutsNumaa3 es la version mas sofisticada calculada a partir de la
% distribucion de aminoacidos en cada posicion.

% Determina el cutoff minimo a partir de los tres calculos de cortes
% previos y el limite de la significancia de conservacion global
cutoffNumaa = min([cutsNumaa cutsNumaa2 cutsNumaa3], [], 2);
LimSigConsGlob = cutoffNumaa(numaa);

% Determina las significancias globales de conservacion para cada posicion
% y el numero de aminoacidos aceptados a partir de la distribucion de
% probabilidades en cada posicion
sigConservGlob = matsig(1,:).*matsig(2,:).*matsig(3,:);
[~, razonAasPos, ~, ~, catsRazonAas, razonAasCumProb] =...
    calcNumAasAccepted(varcomp, procomp, numaa, m);
[quadRazAas, ~, ~] = quadLineFit(catsRazonAas, razonAasCumProb, 'pchip',...
    'noplot');

% Cuenta y asigna un n?mero de orden a cada gap en la proteina objetivo
cont = 1;
contProt = zeros(size(prot_obj));
for i = 1:length(prot_obj)
    if prot_obj(i) ~= '-'
        contProt(i) = cont;
        cont = cont + 1;
    end
end


% Guarda las variables de la funcion para las siguientes funciones
limRaz = quadRazAas(8);
save('MOSST3_4_out.mat','sigConservGlob','LimSigConsGlob','razonAasPos',...
    'limRaz');

end