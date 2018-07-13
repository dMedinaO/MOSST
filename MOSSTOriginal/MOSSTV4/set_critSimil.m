function crit = set_critSimil
% Fija el criterio de similitud para la eliminacion de redundancia en el alineamiento en la funcion MOSST3_2

fileID = fopen('critSimil.txt','r');
if fileID == -1
    fileID2 = fopen('critSimil.txt','w');
    fprintf(fileID2,'%d',0.85);
    fclose(fileID2);
    fileID = fopen('critSimil.txt','r');
end
crit = fscanf(fileID,'%f');
fclose(fileID);

if crit < 0 || crit > 1
    crit = 0.85;
end

end