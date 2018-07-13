function [matsig, numaa, vars, pros] = sigvar2(alin)
% Entrega la significancia de la varianza para cada posicion de un alineamiento
% multiple (alin) segun las tres componentes, cada una en una linea distinta
% de la matriz matsig. Ademas, entrega el numero de aminoacidos en cada posicion
% del alineamiento (numaa), la varianza en cada posicion (vars) y el promedio en
% cada posicion (pros).

[filas,columnas] = size(alin);
numaa = zeros(1,columnas);
var1 = zeros(1,columnas);
var2 = zeros(1,columnas);
var3 = zeros(1,columnas);
pro1 = zeros(1,columnas);
pro2 = zeros(1,columnas);
pro3 = zeros(1,columnas);
for n = 1:columnas
    prom1 = 0;
    prom2 = 0;
    prom3 = 0;
%     aaiguales = 1;
    primeraa = '';
    for i = 1:filas
        if alin(i,n) ~= '-'
            if isempty(primeraa)
                primeraa = alin(i,n);
            end
            aacomp1 = arbolclasaa(alin(i,n),1);
            aacomp2 = arbolclasaa(alin(i,n),2);
            aacomp3 = arbolclasaa(alin(i,n),3);
            if (alin(i,n) ~= primeraa) || (numaa(n) == 0)
                nueprom1 = (numaa(n)*prom1 + aacomp1)/(numaa(n) + 1);
                nueprom2 = (numaa(n)*prom2 + aacomp2)/(numaa(n) + 1);
                nueprom3 = (numaa(n)*prom3 + aacomp3)/(numaa(n) + 1);
            else
                nueprom1 = prom1;
                nueprom2 = prom2;
                nueprom3 = prom3;
            end
            if numaa(n) ~= 0
                var1(n) = ((numaa(n) - 1)*var1(n) + numaa(n)*(prom1 - nueprom1)^2 + (aacomp1 - nueprom1)^2)/numaa(n);
                var2(n) = ((numaa(n) - 1)*var2(n) + numaa(n)*(prom2 - nueprom2)^2 + (aacomp2 - nueprom2)^2)/numaa(n);
                var3(n) = ((numaa(n) - 1)*var3(n) + numaa(n)*(prom3 - nueprom3)^2 + (aacomp3 - nueprom3)^2)/numaa(n);
            else
                var1(n) = 0;
                var2(n) = 0;
                var3(n) = 0;
            end
            numaa(n) = numaa(n) + 1;
            prom1 = nueprom1;
            prom2 = nueprom2;
            prom3 = nueprom3;
        end
    end
    pro1(n) = prom1;
    pro2(n) = prom2;
    pro3(n) = prom3;
end
vars = [var1; var2; var3];
pros = [pro1; pro2; pro3];

matsig = ones(3,columnas);
for c = 1:3
    cumvar = leematriz(c);
    % CALCULAR LA SIGNIFICANCIA PARA CADA VARIANZA CON VARS Y NUMAA
    for n = 1:columnas
        if (numaa(n) == 0) || (numaa(n) == 1)
            matsig(c,n) = 1;
        else
            % ESTE CONDICIONAL ARREGLA SI EL NUMERO DE AMINOACIDOS ES MAYOR
            % QUE 30, PERO DE UNA FORMA ESTRICTAMENTE NO VALIDA
            if numaa(n) > 30
                numaa(n) = 30;
                vars(c,n) = vars(c,n)*(numaa(n)-1)/29;
            end
            matsig(c,n) = pchip(0:0.01:1,cumvar(numaa(n)-1,:),vars(c,n));
        end
    end
end