function [xo,yo] = stairs2(x,y,grafhandle,fighandle)
%STAIRS Stairstep plot.
%   STAIRS(Y) draws a stairstep graph of the elements of vector Y.
%   STAIRS(X,Y) draws a stairstep graph of the elements in vector Y at
%   the locations specified in X.  The X-values must be in
%   ascending order and evenly spaced.
%   STAIRS(...,STYLE) uses the plot linestyle specified by the
%   string STYLE.
%
%   H = STAIRS(X,Y) returns a vector of line handles.
%   [XX,YY] = STAIRS(X,Y) does not draw a graph, but returns vectors
%   X and Y such that PLOT(XX,YY) is the stairstep graph.
%
%   Stairstep plots are useful for drawing time history plots of
%   zero-order-hold digital sampled-data systems.
%
%   See also BAR, HIST, STEM.

%   L. Shure, 12-22-88.
%   Revised A.Grace and C.Thompson 8-22-90.
%   Copyright 1984-2000 The MathWorks, Inc. 
%   $Revision: 5.10 $  $Date: 2000/06/02 04:30:53 $


if min(size(x))==1, x = x(:); end
if min(size(y))==1, y = y(:); end

[n,nc] = size(y); 
ndx = [1:n;1:n];
y2 = y(ndx(1:2*n-1),:);
if size(x,2)==1,
  x2 = x(ndx(2:2*n),ones(1,nc));
else
  x2 = x(ndx(2:2*n),:);
end

if (nargout < 2)
  set(0,'CurrentFigure',fighandle);
  set(fighandle,'CurrentAxes',grafhandle);
  set(grafhandle,'NextPlot','replace');
  h = plot(x2,y2,'Parent',grafhandle);
  set(grafhandle,'XTick', 1:n, 'Box', 'off');
  if nargout==1, xo = h; end
else
    xo = x2; 
    yo = y2;
end

