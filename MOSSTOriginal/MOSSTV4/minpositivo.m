function minpos = minpositivo(vector)
% Calcula el menor numero positivo en el vector, no cero.

maximo = max(vector);
for i = 1:length(vector)
    if vector(i) == 0
        vector(i) = maximo;
    end
end
minpos = min(vector);