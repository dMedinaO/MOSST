function aapos = set_aaInPos
% Fija el aminoacido a ser introducido en la posicion del alineamiento para calcular su propension en la funcion MOSST3_6, leyendo el archivo aaInPos.txt

fileID = fopen('aaInPos.txt','r');
if fileID == -1
    fileID2 = fopen('aaInPos.txt','w');
    fprintf(fileID2,'%c','A');
    fclose(fileID2);
    fileID = fopen('aaInPos.txt','r');
end
aapos = fscanf(fileID,'%c');
fclose(fileID);

aapos = upper(aapos);
aapos_replace = strrep(aapos,'\n','')
aapos_replace
aas = 'ACDEFGHIKLMNPQRSTVWY';

if isempty(strfind(aas,aapos_replace))
    aapos = 'A';
aapos
end

end
