function val = arbolclasaa(aa,comp)
% Clasifica un aminoacido (aa) y devuelve el valor de la componente especificada
% (comp) para ese aminoacido. El vector de valores de la componente (vect_comp)
% esta ordenado alfabeticamente por el codigo de aminoacidos de una letra.

if comp == 1
    vect_comp = [0.279 0.257 1.000 0.945 0.000 0.414 0.804 0.009 0.960 0.010 0.144 0.580 0.417 0.513 0.948 0.486 0.376 0.052 0.098 0.208];
elseif comp == 2
    vect_comp = [0.575 0.415 0.415 0.203 0.132 1.000 0.000 0.298 0.245 0.384 0.131 0.820 0.845 0.568 0.254 0.968 0.689 0.393 0.116 0.358];
elseif comp == 3
    vect_comp = [0.216 1.000 0.555 0.400 0.605 0.484 0.647 0.367 0.491 0.000 0.803 0.890 0.803 0.810 0.305 0.455 0.562 0.186 0.958 0.805];
elseif comp == 4
    vect_comp = [0.821 0.182 0.105 0.551 0.290 0.043 0.031 0.221 0.431 0.249 0.680 0.560 0.000 1.000 0.304 0.298 0.481 0.311 0.221 0.317];
end
if aa <= 'L'
    if aa <= 'F'
        if aa <= 'D'
            if aa == 'A'
                val = vect_comp(1);
            elseif aa == 'C'
                val = vect_comp(2);
            else
                val = vect_comp(3);
            end
        else
            if aa == 'E'
                val = vect_comp(4);
            else
                val = vect_comp(5);
            end
        end
    else
        if aa <= 'I'
            if aa == 'G'
                val = vect_comp(6);
            elseif aa == 'H'
                val = vect_comp(7);
            else
                val = vect_comp(8);
            end
        else
            if aa == 'K'
                val = vect_comp(9);
            else
                val = vect_comp(10);
            end
        end
    end
else
    if aa <= 'R'
        if aa <= 'P'
            if aa == 'M'
                val = vect_comp(11);
            elseif aa == 'N'
                val = vect_comp(12);
            else
                val = vect_comp(13);
            end
        else
            if aa == 'Q'
                val = vect_comp(14);
            else
                val = vect_comp(15);
            end
        end
    else
        if aa <= 'V'
            if aa == 'S'
                val = vect_comp(16);
            elseif aa == 'T'
                val = vect_comp(17);
            else
                val = vect_comp(18);
            end
        else
            if aa == 'W'
                val = vect_comp(19);
            else
                val = vect_comp(20);
            end
        end
    end
end