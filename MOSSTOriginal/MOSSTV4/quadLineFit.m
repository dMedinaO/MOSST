function [resp, x, y] = quadLineFit(xX, yY, method, plotOutput)
% Fits a (0...1, 0...1) sinusoidal/exponential with four straight segments

%% Determination of the orientation of the fitted curve
XvsY = orientation(xX, yY);
if ~XvsY
    aux = xX;
    xX = yY;
    yY = aux;
end

%% Variable initialization
larg = length(xX);
if strcmp(plotOutput, 'plot')
    graf = 1;
else
    graf = 0;
end

%% Initial plot of the fitted curve
if graf
    if XvsY
        plot(xX, yY, 'b.');
    else
        plot(yY, xX, 'b.');
    end
    xlim([0 1]);
    ylim([0 1]);
    axis square;
    hold on;
end

%% Sampling, interpolation and smoothing of y at constant delta(x)
minX = min(xX);
maxX = max(xX);
pasoX = (maxX - minX)/(larg-1);

xF1 = minX:pasoX:maxX;
yF1 = interp1(xX, yY, xF1, method);

%% Calculation of the initial conditions and fitting limits
[lims, starts] = limsAndStarts(xX, yY);
% part011 = [0.01 0.99 0 0 starts(2) 0.5];
partInf1 = [0 0 lims(1) lims(3) 0 0];
partSup1 = [1 1 lims(2) lims(4) 1 1];
part012 = [0.01 0.99 lims(2) lims(4) starts(2) 0.5];

%% Fitting of curves
fityF11 = fit(xF1', yF1', @(xLow, xUp, mLow, mUp, xM, yM, x) quadLineForFit(xLow, xUp, mLow, mUp, xM, yM, x),...
    'StartPoint', part012, 'Lower', partInf1, 'Upper', partSup1, 'Robust', 'on');

% Reorder x and y
if XvsY
    x= xX;
    y = yY;
else
    y= xX;
    x = yY;
end

% Plot the fit result
if graf
    if XvsY
        plot(xF1, fityF11(xF1)', 'r-');
        plot(xF1, interp1(xX, yY, xF1, 'pchip'), 'g-');
    else
        plot(fityF11(xF1)', xF1, 'r-');
        plot(interp1(xX, yY, xF1, 'pchip'), xF1, 'g-');
    end
    hold off;
end

% Calculate the answer from the fit result
if XvsY
    xValue = [fityF11.xLow fityF11.xM fityF11.xUp];
    yValue = fityF11(xValue);
    [xBis, yBis] = fitBissect(xValue, yValue, xX, yY);
    resp = [xValue yValue' xBis yBis];
else
    yValue = [fityF11.xLow fityF11.xM fityF11.xUp];
    xValue = interp1(xF1, fityF11(xF1), yValue);
    [xBis, yBis] = fitBissect(xValue, yValue, yY, xX);
    resp = [xValue yValue xBis yBis];
end





%% Secondary function section
function [lims, starts] = limsAndStarts(x,y)

% Calculation of slope limits
maxX = max(x);
minX = min(x);
maxY = max(y);
minY = min(y);

pend0 = (y - minY)./(x - minX);

lims(1) = min(pend0);
if lims(1) < 0
    lims(1) = 0;
end
lims(2) = max(pend0);

pend1 = (maxY-y)./(maxX-x);

lims(3) = min(pend1);
if lims(3) < 0
    lims(3) = 0;
end
lims(4) = max(pend1);

% Calculation of starting points
limInf = 0.05;
limMed = 0.5;
limSup = 0.95;

starts(1) = interp1(y, x, limInf);
starts(2) = interp1(y, x, limMed);
starts(3) = interp1(y, x, limSup);





function res = quadLineForFit(xLow, xUp, mLow, mUp, xM, yM, x)

% Correction of limits when fitting functions select them
pointOrderError = false;
if xLow > xUp
%     xAux = xLow;
%     xLow = xUp;
%     xUp = xAux;
    pointOrderError = true;
elseif xLow > xM
%     xAux = xLow;
%     xLow = xM;
%     xM = xAux;
    pointOrderError = true;
end
if xM > xUp
%     xAux = xM;
%     xM = xUp;
%     xUp = xAux;
pointOrderError = true;
end

if pointOrderError
    res = 0.5*ones(size(x));
else
    if mLow < 0
        mLow = 0;
    end
    if mUp < 0
        mUp = 0;
    end
    
    % Determination of slopes, intercepts and intersection points
    % L:
    yLow = mLow * xLow;
    % ML:
    mML = (yM - yLow)/(xM - xLow);
    nML = yLow - mML * xLow;
    % U:
    nU = 1 - mUp;
    yUp = mUp * xUp + nU;
    % MU:
    mMU = (yUp - yM)/(xUp - xM);
    nMU = yUp - mMU * xUp;
    
    % Determination of the indicator indexes of each segment: L, ML, MU and U.
    indL = (x <= xLow);
    indML = (x > xLow) & (x <= xM);
    indMU = (x > xM) & (x <= xUp);
    indU = (x > xUp);
    
    % % Determination of the "x" coordinates of each segment
    % xL = x .* (x <= xLow);
    % xML = x .* ((x > xLow) & (x <= xM));
    % xMU = x .* ((x > xM) & (x <= xUp));
    % xU = x .* (x > xUp);
    
    % Determination of the "y" coordinates of each segment
    yL = (mLow * x) .* indL;
    yML = (mML * x + nML) .* indML;
    yMU = (mMU * x + nMU) .* indMU;
    yU = (mUp * x + nU) .* indU;
    
    % Determination of the general curve
    res = yL + yML + yMU + yU;
end





function res = orientation(x,y)
% Outputs TRUE for x vs. y or FALSE for y vs. x in fit calculations

maxX = max(x);
minX = min(x);
maxY = max(y);
minY = min(y);

pend0T = (y - minY)./(x - minX);
pend1T = (maxY-y)./(maxX-x);
maxT = max([pend0T pend1T]);

pend0F = (x - minX)./(y - minY);
pend1F = (maxX-x)./(maxY-y);
maxF = max([pend0F pend1F]);

if maxT <= maxF
    res = true;
else
    res = false;
end





function [xBis, yBis] = fitBissect(xV, yV, xX, yY)
% Calculates the values in curve xX vs. yY crossed by bisectrixes of the
% quad curve given by the three (xV, yV) points.

% Slopes of segments of quad line
m1 = yV(1)/xV(1);
m2 = (yV(2) - yV(1))/(xV(2) - xV(1));
m3 = (yV(3) - yV(2))/(xV(3) - xV(2));
m4 = (1 - yV(3))/(1 - xV(3));

% Slopes of obtuse angle bisector lines
mb1 = -1/(tan((atan(m1)+atan(m2))/2));
mb2 = -1/(tan((atan(m2)+atan(m3))/2));
mb3 = -1/(tan((atan(m3)+atan(m4))/2));

% Intercepts of obtuse angle bisector lines
nb1 = yV(1) - mb1*xV(1);
nb2 = yV(2) - mb2*xV(2);
nb3 = yV(3) - mb3*xV(3);

% Intersection x of bisector lines and xX vs. yY curve
xBis(1) = fzero(@(x) interp1(xX, yY, x, 'pchip') - mb1*x - nb1, interp1(yY, xX, yV(1), 'pchip'));
xBis(2) = fzero(@(x) interp1(xX, yY, x, 'pchip') - mb2*x - nb2, interp1(yY, xX, yV(2), 'pchip'));
xBis(3) = fzero(@(x) interp1(xX, yY, x, 'pchip') - mb3*x - nb3, interp1(yY, xX, yV(3), 'pchip'));

yBis(1) = mb1*xBis(1) + nb1;
yBis(2) = mb2*xBis(2) + nb2;
yBis(3) = mb3*xBis(3) + nb3;