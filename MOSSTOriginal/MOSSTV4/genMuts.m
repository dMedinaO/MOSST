function [listOrd,listAa,accAas] = genMuts(vars,proms,numAas)
% Entrega la lista de probabilidades de presencia de cada aminoacido en
% cada posicion. Requiere el cuadrado de la varianza para la posicion en
% cada componente (vars(1:3)), los promedios por componente
% (proms(1:3)) y el numero de aminoacidos en la posicion (numAas).
% La lista se entrega en orden ascendente (listOrd), y se entrega la
% lista de aminoacidos correspondientes en el mismo orden (listAa). Se
% entrega adem?s el nuermo de aminoacidos aceptados en cada posicion
% (accAas).

[~,n] = size(vars);
for i = 1:n
    [listOrd(:,i), listAa(:,i)] = proponmut2(vars(:,i), proms(:,i), numAas(i));
    % Registra las probabilidades por aminoacido y determina los permitidos
    % como aquellos cuyas probabilidades suman 0.99
    j = 19;
    while (sum(listOrd((j+1:20),i)) <= 0.99) && (j >= 1)
        j = j - 1;
    end
    accAas(i) = 20 - j;
end

