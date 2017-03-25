%% numerical vs analytic
% H = solveWave(M, N, x0, xEnd,tEnd, method, groundFunction,startHeight, plotOrNot,countdown)
clear all
close all
clc
M = 2000;
N = 6000;
x0 = -100;
xEnd = 100;
tEnd = 0;
x = linspace(x0,xEnd,M);
groundFunction = 'no seabed';
startHeight = 'approx';
plotOrNot = false;
countdown = true;
figure 
subplot(1,3,1) % 0seconds
H = solveWave(M, N, x0, xEnd,tEnd, 'analytic', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'b');
% hold on
% H = solveWave(M, N, x0, xEnd,tEnd, 'lax friedrich', groundFunction,startHeight, plotOrNot,countdown);
% plot(x,H(end,:),'--g');
% H = solveWave(M, N, x0, xEnd,tEnd, 'full discretization', groundFunction,startHeight, plotOrNot,countdown);
% plot(x,H(end,:),'--r');
% H = solveWave(M, N, x0, xEnd,tEnd, 'richtmeyer', groundFunction,startHeight, plotOrNot,countdown);
% plot(x,H(end,:),'--m');
legend('Initial start height')
subplot(1,3,2) % 5seconds
tEnd = 5;
H = solveWave(M, N, x0, xEnd,tEnd, 'analytic', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'b');
hold on
H = solveWave(M, N, x0, xEnd,tEnd, 'lax friedrich', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'--g');
H = solveWave(M, N, x0, xEnd,tEnd, 'full discretization', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'--r');
H = solveWave(M, N, x0, xEnd,tEnd, 'richtmeyer', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'--m');
legend('Analytic','Lax Friedrich','Full discretization','Richtmyer')
subplot(1,3,3) %15 seconds
tEnd = 15; 
H = solveWave(M, N, x0, xEnd,tEnd, 'analytic', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'b');
hold on
H = solveWave(M, N, x0, xEnd,tEnd, 'lax friedrich', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'--g');
H = solveWave(M, N, x0, xEnd,tEnd, 'full discretization', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'--r');
H = solveWave(M, N, x0, xEnd,tEnd, 'richtmeyer', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'--m');
legend('Analytic','Lax Friedrich','Full discretization','Richtmyer')