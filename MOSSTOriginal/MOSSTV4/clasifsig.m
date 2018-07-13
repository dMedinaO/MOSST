function NLSDVcrit = clasifsig(vars,limsgraf,graf,numord,grafhandle)
% Si graf = 1, grafica las diferencias entre valores sucesivos de NLSDV
% (negativos de los logaritmos en base 10 de las significancias de las
% diferencias de varianzas), entre los limites entregados por limsgraf, en los
% ejes cuyo handle es grafhandle.
% Se debe ingresar la matriz de significancia de varianzas - significancia de
% diferencias de varianzas (vars).
% Entrega el valor del NLSDV critico (NLSDVcrit) para el numero de orden
% indicado en numord. Si numord = 0, NLSDVcrit = 0.

% CONTROL DE LAS SIGNIFICANCIAS FUERA DE ESCALA
[mtot,ntot] = size(vars);
if mtot == 4
    minimo = min(vars(1:3,:),[],1);
    vars(4,:) = vars(4,:) + minimo;
    min_positivo = minpositivo(vars(4,:));
    for i = 1:ntot
        if vars(4,i) < min_positivo
            vars(4,i) = min_positivo;
        end
        if vars(4,i) > 1
            vars(4,i) = 1;
        end
    end
end

% CALCULO DE LOS NLSDV
logsigdif = -log10(vars(4,:));

% CALCULO DE LAS DIFERENCIAS CONSECUTIVAS (ESCALONES)
[logsigdiford,index] = sort(logsigdif);
logsigdifer = zeros(size(logsigdif));
logsigdifer(1) = 0;
largo = length(logsigdif);
for i = 2:largo
    logsigdifer(i) = logsigdiford(i) - logsigdiford(i-1);
end

% SUBRUTINA DE SUAVIZAMIENTO
logsigdifer1 = zeros(size(logsigdifer));
logsigdifer2 = zeros(size(logsigdifer));
for i = 1:largo
    % Ancho de ventana = 3
    posmin = i - 1;
    posmax = i + 1;
    if posmin < 1
        posmin = 1;
    end
    if posmax > largo
        posmax = largo;
    end
    k = 0;
    suma = 0;
    for j = posmin:posmax
        suma = suma + logsigdifer(j);
        k = k + 1;
    end
    logsigdifer1(i) = suma/k;
    
    % Ancho de ventana = 5
    posmin = i - 2;
    posmax = i + 2;
    if posmin < 1
        posmin = 1;
    end
    if posmax > largo
        posmax = largo;
    end
    k = 0;
    suma = 0;
    for j = posmin:posmax
        suma = suma + logsigdifer(j);
        k = k + 1;
    end
    logsigdifer2(i) = suma/k;
    
    % Ancho de ventana = 7
    posmin = i - 3;
    posmax = i + 3;
    if posmin < 1
        posmin = 1;
    end
    if posmax > largo
        posmax = largo;
    end
    k = 0;
    suma = 0;
    for j = posmin:posmax
        suma = suma + logsigdifer(j);
        k = k + 1;
    end
    logsigdifer3(i) = suma/k;
end

% SUBRUTINA DE GRAFICACION
if graf == 1
    if limsgraf(2) > largo
        limsgraf(2) = largo;
    end
    if limsgraf(1) < 1'
        limsgraf(1) = 1;
    end
    x = limsgraf(1):limsgraf(2);
    y1 = logsigdifer(limsgraf(1):limsgraf(2));
    y2 = logsigdifer1(limsgraf(1):limsgraf(2));
    y3 = logsigdifer2(limsgraf(1):limsgraf(2));
    y4 = logsigdifer3(limsgraf(1):limsgraf(2));
    plot(x,y1,'b-',x,y2,'g-',x,y3,'r-',x,y4,'m-','Parent',grafhandle,...
        'LineWidth',2);
    legend(grafhandle,'No smoothing (window size = 1)',...
        'Medium smoothing (window size = 3)',...
        'High smoothing (window size = 5)',...
        'Very high smoothing (window size = 7)','Location','northwest');
end

% CALCULO DE NLSDVcrit
if numord == 0
    NLSDVcrit = 0;
else
    NLSDVcrit = logsigdif(index(numord));
end