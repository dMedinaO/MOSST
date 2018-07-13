function [arbol,ord_salida,similaridad] = elimredund2(alin)
% Elimina la redundancia de un alineamiento alin, para dejar solo las proteinas
% con menor semejanza entre ellas

[proteinastot,largo] = size(alin);
proteinas = proteinastot;
porc_ident = zeros(proteinas,proteinas);
for i = 1:proteinas-1
    for j = i+1:proteinas
        suma = 0;
        largoi = 0;
        largoj = 0;
        for k = 1:largo
            if (alin(i,k) ~= '-')
                largoi = largoi + 1;
            end
            if (alin(j,k) ~= '-')
                largoj = largoj + 1;
                if (alin(i,k) == alin(j,k))
                    suma = suma + 1;
                end
            end
        end
        largomax = max(largoi,largoj);
        porc_ident(i,j) = suma/largomax;
    end
end
[max_col,ind_filas] = max(porc_ident);
[maximo,ind_cols] = max(max_col);
i = 1;
ord_salida = [];
similaridad = [];
ind_salida = 1:proteinas;
while maximo ~= 0
    fil = ind_filas(ind_cols);
    col = ind_cols;
    dif_prot_fil = sum(porc_ident(1:fil,fil)) + ...
        sum(porc_ident(fil,fil+1:proteinas));
    dif_prot_col = sum(porc_ident(1:col,col)) + ...
        sum(porc_ident(col,col+1:proteinas));
    if dif_prot_fil >= dif_prot_col
        queda = fil;
        sale = col;
    else
        queda = col;
        sale = fil;
    end
    colfinal = [porc_ident(1:queda,queda)' porc_ident(queda,queda+1:proteinas)]';
    filfinal = zeros(1,proteinas);
    porc_ident = [porc_ident colfinal; filfinal 0];
    proteinas = proteinas + 1;
    porc_ident(queda,:) = zeros(1,proteinas);
    porc_ident(sale,:) = zeros(1,proteinas);
    porc_ident(:,queda) = zeros(proteinas,1);
    porc_ident(:,sale) = zeros(proteinas,1);
    [max_col,ind_filas] = max(porc_ident);
    [maximo,ind_cols] = max(max_col);
    arbol(i,1) = queda;
    arbol(i,2) = sale;
    arbol(i,3) = 1-maximo;
    ind_salida = [ind_salida ind_salida(queda)];
    ord_salida = [ord_salida ind_salida(sale)];
    similaridad = [similaridad maximo];
    i = i + 1;
end
k = 1;
while ismember(k,ord_salida) & k <= proteinastot
    k = k + 1;
end
if k <= proteinastot
    ord_salida(proteinastot) = k;
end
