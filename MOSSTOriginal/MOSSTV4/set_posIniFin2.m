function [ini,fin] = set_posIniFin2
% Fija la posicion inicial y final en el alineamiento para la funcion MOSST3_5

load('MOSST3_2_out.mat');
[~,L] = size(alin);

fileID = fopen('posIniFin2.txt','r');
if fileID == -1
    fileID2 = fopen('posIniFin2.txt','w');
    fprintf(fileID2,'%d %d',1,L);
    fclose(fileID2);
    fileID = fopen('posIniFin2.txt','r');
end
pos = fscanf(fileID,'%d %d');
fclose(fileID);

ini = round(pos(1));
fin = round(pos(2));

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