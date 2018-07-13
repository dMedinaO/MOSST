function [matsig, vecsig, matsigdif,numaa,varcomp,procomp] = sigdifvar2(alin)
% Entrega la significancia de la diferencia de las varianzas para cada
% posicion de un alineamiento multiple (alin) entre cada par de
% componentes, en el vector vecsig. La significancia de las varianzas en
% cada posicion para cada una de las tres componentes se entrega cada una
% en una linea distinta de la matriz matsig. Tambien se entrega la
% significancia de cada diferencia para cada posicion (matsigdif), el
% numero de aminoacidos en cada posicion (numaa), la varianza de cada
% componente en cada posicion (varcomp), y el promedio de cada componente
% en cada posicion (procomp).

[matsig,numaa,varcomp,procomp] = sigvar2(alin);
[filas,columnas] = size(alin);
for c1 = 1:2
    c1n = num2str(c1);
    for c2 = (c1+1):3
        c2n = num2str(c2);
        mat = leematriz(c1*10+c2);
        eval(['difcompacum' c1n c2n ' = mat;']);
    end
end
for n = 1:columnas
    k = 1;
    for c1 = 1:2
        c1n = num2str(c1);
        for c2 = (c1+1):3
            c2n = num2str(c2);
            if (numaa(n) == 0) | (numaa(n) == 1)
                sigdif(k) = 1;
            else
                dif = abs(matsig(c1,n) - matsig(c2,n));
                eval(['distacum = difcompacum' c1n c2n '(numaa(n)-1,:);']);
                sigdif(k) = 1 - pchip(0:0.01:1,distacum,dif);
                if sigdif(k) < 0
                    sigdif(k) = 0;
                end
            end
            k = k + 1;
        end
    end
    matsigdif(:,n) = sigdif';
    sigdiford = sort(sigdif);
    simes = zeros(size(sigdiford));
    for i = 1:3
        simes(i) = sigdiford(i)*3/i;
    end
    vecsig(n) = min(simes);
end