function [cats, cumprobs, maximo, minimo] = cumDistBuilder(vecOcurrencia)
%% Calculo general de distribucion
% Calcula una distribución dado un vector de occurencias

%% Normalization and calculation of the normalization constant
% Normalization of vecOcurrencia
maximo = max(vecOcurrencia);
minimo = min(vecOcurrencia);
vecOcurrencia = (vecOcurrencia - minimo)/maximo;

%% Sorting and classification loop
% Occurences are sorted in ascending order and classified
numElems = length(vecOcurrencia);
vecSort = sort(vecOcurrencia);
k = 1;
count(k) = 1;
cats(k) = vecSort(1);

for i = 2:numElems
    if vecSort(i) == vecSort(i - 1)
        count(k) = count(k) + 1;
    else
        k = k + 1;
        count(k) = 1;
        cats(k) = vecSort(i);
    end
end

%% Calculation of probability mass function
% Probabilities for the occurrence of each value are calculated.
probs = count./numElems;

%% Calculation of cumulative distribution function
% The probabilities for each value are taken and used to calculate the
% cumulative distribution function of probabilities from 0 to 1.

cumprobs = zeros(size(probs));
cumprobs(1) = probs(1);
for i = 2:length(probs)
    cumprobs(i) = cumprobs(i-1) + probs(i);
end