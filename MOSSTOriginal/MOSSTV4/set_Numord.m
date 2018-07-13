function numord = set_Numord
% Fija el numero de orden para calcular el valor critico del NLSDV en la funcion clasifsig (MOSST3_3). Si es 0, NLSDVcrit = 0.

load('MOSST3_2_out.mat');
[~,L] = size(alin);

fileID = fopen('numOrd.txt','r');
if fileID == -1
    fileID2 = fopen('numord.txt','w');
    fprintf(fileID2,'%d',L);
    fclose(fileID2);
    fileID = fopen('numord.txt','r');
end
numord = fscanf(fileID,'%d');
fclose(fileID);

numord = round(numord);

if numord < 1
    numord = 1;
elseif numord > L
    numord = L
end

end