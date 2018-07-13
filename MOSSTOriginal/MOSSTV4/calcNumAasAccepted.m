function [aasAceptados, razonAasPos, catsAasAcept, aasAceptCumProb, catsRazonAas, razonAasCumProb] = calcNumAasAccepted(varargin)

varianzas = varargin{1};
promedios = varargin{2};
numAasEnPos = varargin{3};
numProts = varargin{4};
[~,n] = size(varianzas);

%% Calculo del numero de aminoacidos aceptados y la razon de representatividad

aasAceptados = zeros(1,n);
razonAasPos = zeros(1,n);
for i = 1:n
    [probord,~] = proponmut2(varianzas(:,i),promedios(:,i),numAasEnPos(i));
    j = 19;
    while (sum(probord(j+1:20)) <= 0.99) && (j >= 1)
        j = j - 1;
    end
    aasAceptados(i) = 20 - j;
    razonAasPos(i) = numAasEnPos(i)/aasAceptados(i)/numProts;
end

%% Calculo de las distribuciones acumulativas del numero de aminoacidos aceptados
[catsAasAcept, aasAceptCumProb] = calcDistribution(aasAceptados);
[catsRazonAas, razonAasCumProb] = calcDistribution(razonAasPos);


function [cats, cumprobs] = calcDistribution(vecOcurrencia)
%% Calculo general de distribucion
% Calcula una distribución dado un vector de occurencias

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
