function [ini,fin] = set_posIniFin
% Fija la posicion inicial y final en el alineamiento para la funcion MOSST3_3

load('MOSST3_2_out.mat');
[~,L] = size(alin);

fileID = fopen('posIniFin.txt','r');
if fileID == -1
    fileID2 = fopen('posIniFin.txt','w');
    fprintf(fileID2,'%d %d',1,L);
    fclose(fileID2);
    fileID = fopen('posIniFin.txt','r');
end
pos = fscanf(fileID,'%d %d');
fclose(fileID);

ini = round(pos(1));
fin = round(pos(2));

ini = round(ini);
fin = round(fin);

if fin > L
    fin = L;
end
if ini < 1
    ini = 1;
end

if fin < ini
    ini = 1;
    fin = L;
end

end