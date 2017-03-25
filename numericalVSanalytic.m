%% numerical vs analytic
% H = solveWave(M, N, x0, xEnd,tEnd, method, groundFunction,startHeight, plotOrNot,countdown)
clear all
close all
clc
M = 3000;
N = 10000;
x0 = -100;
xEnd = 100;
tEnd = 34;
x = linspace(x0,xEnd,M);
groundFunction = 'no seabed';
startHeight = 'approx';
plotOrNot = false;
countdown = true;

H1 = solveWave(M, N, x0, xEnd,tEnd, 'lax friedrich', groundFunction,startHeight, plotOrNot,countdown);
H2 = solveWave(M, N, x0, xEnd,tEnd, 'richtmeyer', groundFunction,startHeight, plotOrNot,countdown);


figure 
subplot(1,3,1) % 0 time
H = solveWave(M, N, x0, xEnd,0, 'analytic', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'b');
legend('Initial start')

subplot(1,3,2) % tEnd/2 time
H = solveWave(M, N, x0, xEnd,tEnd/2, 'analytic', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'b');
hold on
plot(x,H1(N/2,:),'--k');
plot(x,H2(N/2,:),'--r');
legend('Analytic','Lax Friedrich','Richtmyer')
xlim([-50 100]);
ylim([0.49 0.51])

subplot(1,3,3) % tEnd time 
H = solveWave(M, N, x0, xEnd,tEnd, 'analytic', groundFunction,startHeight, plotOrNot,countdown);
plot(x,H(end,:),'b');
hold on
plot(x,H1(N,:),'--k');
plot(x,H2(N,:),'--r');
legend('Analytic','Lax Friedrich','Richtmyer')
xlim([-50 100]);
ylim([0.49 0.51])