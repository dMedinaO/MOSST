function sigLim = cutsDistMultVars(cutExp)

cuts = [0.001 0.002 0.005 0.01 0.02 0.05 0.1 0.2 0.5];
load('probCut.mat');

ind = sum((cuts == cutExp).*(1:9));

if ((ind < 1) || (ind > 9))
    error('Error in the cut selection');
else
    sigLim = [1; probCut(:,ind)];
end