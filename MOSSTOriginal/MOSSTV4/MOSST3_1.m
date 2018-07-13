function MOSST3_1
%Lee un alineamiento contenido en el archivo de texto 'AlignmentIn.txt' en disco con la proteina objetivo en la primera linea.
% Lee un archivo de texto que contiene un alineamiento multiple en el
% formato requerido (formato MOSST). El archivo de texto ('AlignmentIn.txt')
% esta guardado en el disco duro en el mismo directorio (o en un directorio
% en el path de MATLAB).
% Se asume que la proteina objetivo para el analisis de mutaciones es la
% primera proteina del alineamiento.
% La salida de la funcion queda grabada como 'MOSST3_1_out.mat', que
% contiene las variables:
% alin: proteinas alineadas en formato MOSST, una por linea
% protstot: numero total de proteinas en el alineamiento
% prot_obj: secuencia de la prote?na objetivo (con gaps) en el alineamiento
% arbol: arbol para construir el dendrograma con la funcion dendrogram.
% ord_salida: orden en el cual se deber?an ir eliminando las proteinas
%             del alineamiento, en orden de mas a menos redundante.


% Carga el contenido del archivo
alin = leealin('AlignmentIn.txt');
% alin contiene las proteinas alineadas en formato MOSST, una por linea
if ~isempty(alin)
    [protstot,~] = size(alin);
    % protstot es el numero total de proteinas en el alinamiento
end

while isempty(alin)
% Chequea si el alineamiento se leyo
    if isempty(alin)
        % Respuesta si el archivo de alineamiento no existe
    end
end
prot_obj = alin(1,:);
% prot_obj es la secuencia (con gaps) de la proteina objetivo

[arbol,ord_salida,~] = elimredund2(alin);
% arbol es el arbol para construir el dendrograma con la funcion
% dendrogram.
% ord_salida es el orden en el cual se deberian ir eliminando las proteinas
% del alineamiento, en orden de mas a menos redundante.

% Guarda las variables de la funcion para las siguientes funciones
save('MOSST3_1_out.mat','alin','protstot','prot_obj','arbol','ord_salida');

end
