function alin = leealin(arch)
% Lee un alineamiento desde un archivo en el que los nombres de las proteinas
% estan entre parentesis antes de cada linea de proteina completa

fid = fopen(arch,'r');
if fid == -1
    alin = [];
else
    lins = 0;
    while ~feof(fid)
        linea = fgetl(fid);
        largo = length(linea);
        lins = lins + 1;
        i = 1;
        while linea(i) ~= ')'
            i = i + 1;
        end
        i = i + 1;
        j = 1;
        while i <= largo
            alin(lins,j) = linea(i);
            i = i + 1;
            j = j + 1;
        end
    end
    fclose(fid);
end
