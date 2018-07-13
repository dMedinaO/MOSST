function resp = barsig_13(vars, NLSDVcrit, pos, cons, limCons, razAas, limRaz, grafhandle, protSeq, contProt)
% Hace un grafico de barras de la significancia de las diferencias entre
% varianzas de un alineamiento por posicion.
% NLSDVcrit entrega el limite de sensibilidad para recomendar un objetivo
% de  mutagenesis.
% Se grafica desde la posicion pos(1) hasta la posicion pos(2), en los
% ejes definidos por los ejes grafhandle.

[mtot,ntot] = size(vars);
if mtot == 4
    minimo = min(vars(1:3,:),[],1);
    vars(4,:) = vars(4,:) + minimo;
%     cons = cons + minimo;
    min_positivoVars = minpositivo(vars(4,:));
%     min_positivoCons = min(vars(4,:));
    for i = 1:ntot
        if vars(4,i) < min_positivoVars
            vars(4,i) = min_positivoVars;
        end
        if vars(4,i) > 1
            vars(4,i) = 1;
        end
        if cons(i) < min_positivoVars
            cons(i) = min_positivoVars;
        end
        if cons(i) > 1
            cons(i) = 1;
        end
    end
end

limsig = 10^(-NLSDVcrit);
% limcons = min(limInfCumProb(cons));
vars = vars(:,pos(1):pos(2));
cons = cons(pos(1):pos(2));
razAas = razAas(pos(1):pos(2));
[m,n] = size(vars);
in = 0;
me = 0;
pr = 0;
si = 0;
idp = 0;
idpsi = 0;
idppr = 0;
insign = ones(1,n);
mesign = ones(1,n);
prsign = ones(1,n);
sisign = ones(1,n);
idpsign = ones(1,n);
idpsisign = ones(1,n);
idpprsign = ones(1,n);
idpProb = zeros(1,n);
% limCons = 0.0002;
for i = 1:n
    if vars(4,i) > 0.01004          % Non significant
        if ~((cons(i) <= limCons(i)) && (razAas(i) > limRaz))        % Non significant AND NOT an IDP
            in = in + 1;
            insign(i) = vars(4,i);
        else                        % Non significant AND an IDP
            idp = idp + 1;
            idpProb(i) = 1;
            idpsign(i) = cons(i);
        end
    elseif vars(4,i) > 0.0004       % Significant pos.
        if ~((cons(i) <= limCons(i)) && (razAas(i) > limRaz))        % Significant AND NOT and IDP
            me = me + 1;
            mesign(i) = vars(4,i);
        else                        % Significant AND an IDP
            idp = idp + 1;
            idpProb(i) = 1;
            idpsign(i) = cons(i);
        end
    else                                                        % vars(4,i) <= 0.0004 <==> Very significant pos.
        if ~((cons(i) <= limCons(i)) && (razAas(i) > limRaz))     % Very significant AND NOT an IDP
            if (vars(4,i) <= limsig) & (vars(4,i) <= 0.00044)   % Primary AND NOT an IDP
                prsign(i) = vars(4,i);
                idpProb(i) = 1;                                 % ...But an IDP anyway (according to VHL analysis)
                pr = pr + 1;
            else                                                % Very significant AND NOT an IDP
                sisign(i) = vars(4,i);
                si = si + 1;
            end
        else                                                    % Very significant AND an IDP
            if (vars(4,i) <= limsig) & (vars(4,i) <= 0.00044)   % Primary AND an IDP
                idpprsign(i) = vars(4,i);
                idpProb(i) = 1;
                idppr = idppr + 1;
            else                                                % Very significant AND an IDP
                idpsisign(i) = vars(4,i);
                idpProb(i) = 1;
                idpsi = idpsi + 1;
            end
        end
    end
end

if nargin < 11
    H1 = [];
    H2 = [];
    H3 = [];
    H4 = [];
    H5 = [];
    H6 = [];
    H7 = [];
    set(grafhandle, 'XTickLabelMode', 'auto');
    if pr > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(prsign));
        H4=patch(xx,yy,[1 1 0.4],'Parent',grafhandle);
    end
    if si > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(sisign));
        H3=patch(xx,yy,[0.6667 0.8333 0.4],'Parent',grafhandle);
        set(grafhandle,'NextPlot','add');
    end
    if me > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(mesign));
        H2=patch(xx,yy,[0.3333 0.6667 0.4],'Parent',grafhandle);
        set(grafhandle,'NextPlot','add');
    end
    if in > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(insign));
        H1=patch(xx,yy,[0 0.5 0.4],'Parent',grafhandle);
        set(grafhandle,'NextPlot','add');
    end
    if idp > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(idpsign));
        H5=patch(xx,yy,[0 0.8 1],'Parent',grafhandle);
        set(grafhandle,'NextPlot','add');
    end
    if idpsi > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(idpsisign));
        H6=patch(xx,yy,[0.3333 0.75 0.7],'Parent',grafhandle);
        set(grafhandle,'NextPlot','add');
    end
    if idppr > 0
        [~,~,~,xx,yy,~,~,~,equal] = makebars(pos(1):pos(2),-log10(idpprsign));
        H7=patch(xx,yy,[0.5 0.9 0.7],'Parent',grafhandle);
        set(grafhandle,'NextPlot','add');
    end
    % Turn off edges when they start to overwhelm the colors
    if n > 150,
        if ishandle(H1)
            set(H1,{'edgecolor'},get(H1,{'facecolor'}));
        end
        if ishandle(H2)
            set(H2,{'edgecolor'},get(H2,{'facecolor'}));
        end
        if ishandle(H3)
            set(H3,{'edgecolor'},get(H3,{'facecolor'}));
        end
        if ishandle(H4)
            set(H4,{'edgecolor'},get(H4,{'facecolor'}));
        end
        if ishandle(H5)
            set(H5,{'edgecolor'},get(H5,{'facecolor'}));
        end
        if ishandle(H6)
            set(H6,{'edgecolor'},get(H6,{'facecolor'}));
        end
        if ishandle(H7)
            set(H7,{'edgecolor'},get(H7,{'facecolor'}));
        end
    end
    leyenda1 = '';
    leyenda2 = '';
    hay_leyenda = 0;
    if in > 0
        leyenda1 = [leyenda1 'H1'];
        leyenda2 = [leyenda2 '''Non significant'''];
        hay_leyenda = 1;
    end
    if me > 0
        if hay_leyenda
            leyenda1 = [leyenda1 ';H2'];
            leyenda2 = [leyenda2 ',''Significant'''];
        else
            leyenda1 = [leyenda1 'H2'];
            leyenda2 = [leyenda2 '''Significant'''];
        end
        hay_leyenda = 1;
    end
    if si > 0
        if hay_leyenda
            leyenda1 = [leyenda1 ';H3'];
            leyenda2 = [leyenda2 ',''Very significant'''];
        else
            leyenda1 = [leyenda1 'H3'];
            leyenda2 = [leyenda2 '''Very significant'''];
        end
        hay_leyenda = 1;
    end
    if pr > 0
        if hay_leyenda
            leyenda1 = [leyenda1 ';H4'];
            leyenda2 = [leyenda2 ',''Primary'''];
        else
            leyenda1 = [leyenda1 'H4'];
            leyenda2 = [leyenda2 '''Primary'''];
        end
        hay_leyenda = 1;
    end
    if idp > 0
        if hay_leyenda
            leyenda1 = [leyenda1 ';H5'];
            leyenda2 = [leyenda2 ',''IDP'''];
        else
            leyenda1 = [leyenda1 'H5'];
            leyenda2 = [leyenda2 '''IDP'''];
        end
        hay_leyenda = 1;
    end
    if idpsi > 0
        if hay_leyenda
            leyenda1 = [leyenda1 ';H6'];
            leyenda2 = [leyenda2 ',''Very sig. + IDP'''];
        else
            leyenda1 = [leyenda1 'H6'];
            leyenda2 = [leyenda2 '''Very sig. + IDP'''];
        end
        hay_leyenda = 1;
    end
    if idppr > 0
        if hay_leyenda
            leyenda1 = [leyenda1 ';H7'];
            leyenda2 = [leyenda2 ',''Primary + IDP'''];
        else
            leyenda1 = [leyenda1 'H7'];
            leyenda2 = [leyenda2 '''Primary + IDP'''];
        end
        hay_leyenda = 1;
    end
    leyenda = ['legend([' leyenda1 '],' leyenda2 ');'];
    if hay_leyenda
        eval(leyenda);
    end
    %xlabel('Posicion','FontWeight','demi','Parent',grafhandle);
    %ylabel('NLSDV','FontWeight','demi','Parent',grafhandle);
    set(grafhandle,'XLim',[pos(1)-1 pos(2)+1]);
    
    numLabels = str2double(get(grafhandle, 'XTickLabel'));
    spaces = '';
    protLabels = '';
    if numLabels(1) == 0
        xTickLabel = protSeq(numLabels(2:length(numLabels)))';
        spaces = ' ';
        for i = 2:length(numLabels)
            spaces = [spaces;' '];
            if contProt(numLabels(i)) == 0
                protLabels = strvcat(protLabels, ' ');
            else
                %             protLabels = [protLabels; num2str(contProt(numLabels(i)))];
                protLabels = strvcat(protLabels, num2str(contProt(numLabels(i))));
            end
        end
        set(grafhandle, 'XTickLabel',[[' ';xTickLabel] spaces strvcat(' ', protLabels)]);
    else
        xTickLabel = protSeq(numLabels)';
        for i = 1:length(numLabels)
            spaces = [spaces;' '];
            if contProt(numLabels(i)) == 0
                protLabels = strvcat(protLabels, ' ');
            else
                %             protLabels = [protLabels; num2str(contProt(numLabels(i)))];
                protLabels = strvcat(protLabels, num2str(contProt(numLabels(i))));
            end
        end
        set(grafhandle, 'XTickLabel',[[xTickLabel] spaces protLabels]);
    end
    set(grafhandle,'NextPlot','replace');
end

% resp = (limCons'./cons).*(razAas./limRaz);
resp = calcProbIDP(idpProb);



function probIDP = calcProbIDP(IDP)

factor = 1;

idp = IDP;
largo = length(idp);
error = 0.001;

if largo == 1
    probIDP = idp;
elseif largo == 2
    if idp(1) == 1
        probIDP(1) = 1;
    else
        probIDP(1) = 1/3*idp(2)*factor;
    end
    if idp(2) == 1
        probIDP(2) = 1;
    else
        probIDP(2) = 1/3*idp(1)*factor;
    end
elseif largo == 3
    if idp(1) == 1
        probIDP(1) = 1;
    else
        probIDP(1) = (1/3*idp(2) + 1/9*idp(3))*factor;
    end
    if idp(2) == 1
        probIDP(2) = 1;
    else
        probIDP(2) = (1/3*idp(1) + 1/3*idp(3))*factor;
    end
    if idp(3) == 1
        probIDP(3) = 1;
    else
        probIDP(3) = (1/9*idp(1) + 1/3*idp(2))*factor;
    end
elseif largo == 4
    if idp(1) == 1
        probIDP(1) = 1;
    else
        probIDP(1) = (1/3*idp(2) + 1/9*idp(3))*factor;
    end
    if idp(2) == 1
        probIDP(2) = 1;
    else
        probIDP(2) = (1/3*idp(1) + 1/3*idp(3) + 1/9*idp(4))*factor;
    end
    if idp(3) == 1
        probIDP(3) = 1;
    else
        probIDP(3) = (1/9*idp(1) + 1/3*idp(2) + 1/3*idp(4))*factor;
    end
    if idp(4) == 1
        probIDP(4) = 1;
    else
        probIDP(4) = (1/9*idp(2) + 1/3*idp(3))*factor;
    end
elseif largo >= 5
    if idp(1) == 1
        probIDP(1) = 1;
    else
        probIDP(1) = (1/3*idp(2) + 1/9*idp(3))*factor;
    end
    if idp(2) == 1
        probIDP(2) = 1;
    else
        probIDP(2) = (1/3*idp(1) + 1/3*idp(3) + 1/9*idp(4))*factor;
    end    
    for i = 3:(largo-2)
        if idp(i) == 1
            probIDP(i) = 1;
        else
            probIDP(i) = (1/9*idp(i-2) + 1/3*idp(i-1) + 1/3*idp(i+1) + 1/9*idp(i+2))*factor;
        end
    end
    if idp(largo-1) == 1
        probIDP(largo-1) = 1;
    else
        probIDP(largo-1) = (1/9*idp(largo-3) + 1/3*idp(largo-2) + 1/3*idp(largo))*factor;
    end
    if idp(largo) == 1
        probIDP(largo) = 1;
    else
        probIDP(largo) = (1/9*idp(largo-2) + 1/3*idp(largo-1))*factor;
    end
end

RMSD = sum((IDP - probIDP).^2)/largo;

while RMSD >= error
    idp = probIDP;
    if largo == 1
        probIDP = idp;
    elseif largo == 2
        if idp(1) == 1
            probIDP(1) = 1;
        else
            probIDP(1) = 1/3*idp(2)*factor;
        end
        if idp(2) == 1
            probIDP(2) = 1;
        else
            probIDP(2) = 1/3*idp(1)*factor;
        end
    elseif largo == 3
        if idp(1) == 1
            probIDP(1) = 1;
        else
            probIDP(1) = (1/3*idp(2) + 1/9*idp(3))*factor;
        end
        if idp(2) == 1
            probIDP(2) = 1;
        else
            probIDP(2) = (1/3*idp(1) + 1/3*idp(3))*factor;
        end
        if idp(3) == 1
            probIDP(3) = 1;
        else
            probIDP(3) = (1/9*idp(1) + 1/3*idp(2))*factor;
        end
    elseif largo == 4
        if idp(1) == 1
            probIDP(1) = 1;
        else
            probIDP(1) = (1/3*idp(2) + 1/9*idp(3))*factor;
        end
        if idp(2) == 1
            probIDP(2) = 1;
        else
            probIDP(2) = (1/3*idp(1) + 1/3*idp(3) + 1/9*idp(4))*factor;
        end
        if idp(3) == 1
            probIDP(3) = 1;
        else
            probIDP(3) = (1/9*idp(1) + 1/3*idp(2) + 1/3*idp(4))*factor;
        end
        if idp(4) == 1
            probIDP(4) = 1;
        else
            probIDP(4) = (1/9*idp(2) + 1/3*idp(3))*factor;
        end
    elseif largo >= 5
        if idp(1) == 1
            probIDP(1) = 1;
        else
            probIDP(1) = (1/3*idp(2) + 1/9*idp(3))*factor;
        end
        if idp(2) == 1
            probIDP(2) = 1;
        else
            probIDP(2) = (1/3*idp(1) + 1/3*idp(3) + 1/9*idp(4))*factor;
        end
        for i = 3:(largo-2)
            if idp(i) == 1
                probIDP(i) = 1;
            else
                probIDP(i) = (1/9*idp(i-2) + 1/3*idp(i-1) + 1/3*idp(i+1) + 1/9*idp(i+2))*factor;
            end
        end
        if idp(largo-1) == 1
            probIDP(largo-1) = 1;
        else
            probIDP(largo-1) = (1/9*idp(largo-3) + 1/3*idp(largo-2) + 1/3*idp(largo))*factor;
        end
        if idp(largo) == 1
            probIDP(largo) = 1;
        else
            probIDP(largo) = (1/9*idp(largo-2) + 1/3*idp(largo-1))*factor;
        end
    end
    
    RMSD = sum((idp - probIDP).^2)/largo;
end