function pos = set_posMut
% Fija la posicion del alineamiento para la cual se calcula probabilidades de mutacion en la funcion MOSST3_6

fileID = fopen('posMut.txt','r');
if fileID == -1
    fileID2 = fopen('posMut.txt','w');
    fprintf(fileID2,'%d',1);
    fclose(fileID2);
    fileID = fopen('posMut.txt','r');
end
pos = fscanf(fileID,'%d');
fclose(fileID);

pos = round(pos);

load('MOSST3_2_out.mat');
[~,L] = size(alin);

if pos > L
    pos = L;
end
if pos < 1
    pos = 1;
end

end