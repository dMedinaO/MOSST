function [listord,listaaord] = proponmut2(varcomp,procomp,numaa)
% Entrega la lista de probabilidades de presencia de cada aminoacido en
% una posicion. Requiere el cuadrado de la varianza para la posicion en
% cada componente (varcomp(1:3)), los promedios por componente
% (promcomp(1:3)) y el numero de aminoacidos en la posicion (numaa).
% La lista se entrega en orden ascendente (listord), y se entrega la
% lista de aminoacidos correspondientes en el mismo orden (listaaord).

% Componentes en orden alfabetico
comp_val(1,:) = [0.279 0.257 1.000 0.945 0.000 0.414 0.804 0.009 0.960 0.010 0.144 0.580 0.417 0.513 0.948 0.486 0.376 0.052 0.098 0.208];
comp_val(2,:) = [0.575 0.415 0.415 0.203 0.132 1.000 0.000 0.298 0.245 0.384 0.131 0.820 0.845 0.568 0.254 0.968 0.689 0.393 0.116 0.358];
comp_val(3,:) = [0.216 1.000 0.555 0.400 0.605 0.484 0.647 0.367 0.491 0.000 0.803 0.890 0.803 0.810 0.305 0.455 0.562 0.186 0.958 0.805];
% Limites de cobertura de aminoacidos en componentes, en orden alfabetico
liminf(1,:) = [0.2680 0.2325 0.9800 0.8745   -Inf 0.3950 0.6920 0.0045 0.9540 0.0095 0.1210 0.5465 0.4155 0.4995 0.9465 0.4515 0.3275 0.0310 0.0750 0.1760];
limsup(1,:) = [0.3275 0.2680    Inf 0.9465 0.0045 0.4155 0.8745 0.0095 0.9800 0.0310 0.1760 0.6920 0.4515 0.5465 0.9540 0.4995 0.3950 0.0750 0.1210 0.2325];
liminf(2,:) = [0.5715 0.4150 0.4040 0.1675 0.1315 0.9840   -Inf 0.2760 0.2240 0.3710 0.1235 0.7545 0.8325 0.4915 0.2495 0.9065 0.6320 0.3885 0.0580 0.3280];
limsup(2,:) = [0.6320 0.4915 0.4150 0.2240 0.1675    Inf 0.0580 0.3280 0.2495 0.3885 0.1315 0.8325 0.9065 0.5715 0.2760 0.9840 0.7545 0.4040 0.1235 0.3710];
liminf(3,:) = [0.2010 0.9790 0.5230 0.3835 0.5835 0.4695 0.6260 0.3360 0.4875   -Inf 0.7250 0.8500 0.8030 0.8075 0.2605 0.4275 0.5585 0.0930 0.9240 0.8040];
limsup(3,:) = [0.2605    Inf 0.5585 0.4275 0.6260 0.4875 0.7250 0.3835 0.5230 0.0930 0.8030 0.9240 0.8040 0.8500 0.3360 0.4695 0.5835 0.2010 0.9790 0.8075];


for i = 1:20
    for j = 1:3
        if varcomp(j) ~= 0
            tliminf(j,i) = (liminf(j,i)-procomp(j))/((varcomp(j)*(1+1/numaa))^(1/2));
            tlimsup(j,i) = (limsup(j,i)-procomp(j))/((varcomp(j)*(1+1/numaa))^(1/2));
            prob_parc(j,i) = tcdf(tlimsup(j,i),numaa-1) - tcdf(tliminf(j,i),numaa-1);
        end
    end
    if sum(varcomp) ~= 0
        prob(i) = prob_parc(1,i)*prob_parc(2,i)*prob_parc(3,i);
    else
        if (liminf(1,i) <= procomp(1)) && (limsup(1,i) >= procomp(1)) &&...
                (liminf(2,i) <= procomp(2)) && (limsup(2,i) >= procomp(2)) &&...
                (liminf(3,i) <= procomp(3)) && (limsup(3,i) >= procomp(3))
            prob(i) = 1;
        else
            prob(i) = 0;
        end
    end
end
prob = prob/sum(prob);

[listord,ind] = sort(prob);
aa_alfabet = 'ACDEFGHIKLMNPQRSTVWY';
listaaord = aa_alfabet(ind);