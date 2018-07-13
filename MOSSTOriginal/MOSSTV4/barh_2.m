function barh_2(probs,grafhandle,fighandle,aas_ord)
% Hace un grafico de barras de las probabilidades de mutacion para cada
% aminoacido en una posicion de un alineamiento.
% Se grafica en los ejes definidos por los ejes grafhandle de la figura
% fighandle.

set(0,'CurrentFigure',fighandle);
set(fighandle,'CurrentAxes',grafhandle);
set(grafhandle,'NextPlot','replace');

[msg,x,y,xx,yy,linetype,plottype,barwidth,equal] = makebars(1:20,probs');
next = lower(get(grafhandle,'NextPlot'));
edgec = get(fighandle,'defaultaxesxcolor');
facec = 'flat';
h = [];
cc = ones(size(xx,1),1);
if ~isempty(linetype), facec = linetype; end
for i=1:size(xx,2)
    numBars = (size(xx,1)-1)/5;
      for j=1:numBars,
     f(j,:) = (2:5) + 5*(j-1);
  end
  v = [yy(:,i) xx(:,i)];
  h=[h patch('faces', f, 'vertices', v, 'cdata', i*cc, ...
        'FaceColor',facec,'Parent',grafhandle)];
end
if length(h)==1, set(grafhandle,'clim',[1 2]), end
if ~equal, 
    set(grafhandle,'NextPlot','replace');
    plot(zeros(size(x,1),1),x(:,1),'*','Parent',grafhandle)
end
% Turn off edges when they start to overwhelm the colors
if size(xx,2)*numBars > 120, 
    set(h,{'edgecolor'},get(h,{'facecolor'}));
end

set(grafhandle,'XLim',[0 1]);
set(grafhandle, 'Ylim', [.5 20.5], 'YTick', 1:20, 'YTickLabel', aas_ord',...
    'XGrid', 'on', 'Box', 'off');
set(grafhandle,'NextPlot','replace');