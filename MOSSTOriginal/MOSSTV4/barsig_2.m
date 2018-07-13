function barsig_2(vars,pos,grafhandle,fighandle)
% Hace un grafico de barras de la significancia de las varianzas para cada
% componente en un alineamiento por posicion.
% Se grafica desde la posicion pos(1) hasta la posicion pos(2), en los ejes
% definidos por los ejes grafhandle.

cla(grafhandle,'reset');
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
vars = vars(:,pos(1):pos(2));
[m,n] = size(vars);
set(0,'CurrentFigure',fighandle);
set(fighandle,'CurrentAxes',grafhandle);
set(grafhandle,'NextPlot','replace');

[msg,x,y,xx,yy,linetype,plottype,barwidth,equal] = makebars(pos(1):pos(2),-log10(vars(1:3,:))');
next = lower(get(grafhandle,'NextPlot'));
facec = 'flat';
h = [];
cc = ones(size(xx,1),1);
if ~isempty(linetype), facec = linetype; end
map = [0.85, 0, 0
    0, 0.85, 0
    0, 0, 0.85];
colormap(map);
for i=1:size(xx,2)
    numBars = (size(xx,1)-1)/5;
    f = 1:(numBars*5);
    f(1:5:(numBars*5)) = [];
    f = reshape(f, 4, numBars);
    f = f';

    v = [xx(:,i) yy(:,i)];

    h=[h patch('faces', f, 'vertices', v, 'cdata', i*cc, ...
        'FaceColor',facec,'Parent',grafhandle)];
end
if length(h)==1, set(grafhandle,'clim',[1 2]), end
if ~equal, 
    set(grafhandle,'NextPlot','replace');
    plot(x(:,1),zeros(size(x,1),1),'*','Parent',grafhandle)
end
% Turn off edges when they start to overwhelm the colors
if size(xx,2)*numBars > 120, 
    set(h,{'edgecolor'},get(h,{'facecolor'}));
end

legend(grafhandle,'Component 1','Component 2','Component 3');

set(grafhandle,'XLim',[pos(1)-1 pos(2)+1]);
limsY = get(grafhandle,'Ylim');
if max(limsY) > 15
    set(grafhandle, 'Ylim', [limsY(1) 15]);
end
set(grafhandle,'NextPlot','add');
plot([pos(1)-2 pos(2)+2],[-log10(0.05) -log10(0.05)],':k','Parent',grafhandle);
plot([pos(1)-2 pos(2)+2],[2 2],':k','Parent',grafhandle);
plot([pos(1)-2 pos(2)+2],[3 3],':k','Parent',grafhandle);
set(grafhandle,'NextPlot','replace');