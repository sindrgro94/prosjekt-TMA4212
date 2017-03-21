%% makeRefMatrices
time = 0.5;
metode = 'richtmeyer normal';
height = 'wavetop';
x0 = -10;
xEnd = 10;
plotOrNot = false;
M = 2^15;
N = 2^15;
Href = solveWave(M, N, x0, xEnd,time, metode, 0,height, plotOrNot);
Href = Href(end,:);
save('refMatrices/richtmeyer normal');