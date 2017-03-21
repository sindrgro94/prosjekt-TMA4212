%% makeRefMatrices
time = 0.5;
counter = true;
metode = 'richtmeyer normal';
height = 'wavetop';
x0 = -10;
xEnd = 10;
plotOrNot = false;
M = 2^14;
N = 2^14;
Href = solveWave(M, N, x0, xEnd,time, metode, 0,height, plotOrNot,counter);
Href = Href(end,:);
save('refMatrices/richtmeyer normal');