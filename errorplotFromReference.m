%% errorplotFromReference
clear all
close all
clc
metode = 'refMatrices/richtmeyer normal';
ref = load(metode);
metode = 'richtmeyer normal';
height = ref.height;
time = ref.time;
x0 = ref.x0;
xEnd = ref.xEnd;
plotOrNot = false;
Href = ref.Href;
Mref = ref.M;
Nref = ref.N;
counter = false;
%% Choosing what interval to test for space and time (2^x)
startN = 9;
endN = 12;
startM = 6;
endM = 9;
%% Error in time:
cnt = 1;
fprintf('Error in time(%0.f tests):\n',endN-startN+1);
for i = startN:endN
    tic
    N = floor(2^i);
    h(cnt) = 1/(N+2);
    H = solveWave(Mref, N, x0, xEnd,time, metode, 0,height, plotOrNot,counter);
    err = Href(1,:)-H(end,:);
    e(cnt) = norm(err)*sqrt(h(cnt));
    cnt = cnt+1;
    fprintf('%.0f of %.0f finished.\n',i-startN+1,endN-startN+endM-startM+2)
    toc
end
fig = figure;
subplot(1,2,1);
loglog(h,e,'o-r')
hold on
loglog(h,h.^2*100,'--')
loglog(h,h,'--')
legend('Error in 2-norm','O(k^2)','O(k)')
title('Convergence plot wrt t')
xlabel('Steplength')
ylabel('Error')
set(gca,'fontsize',18)
hold off
ordent = polyfit(log(h),log(e),1);
%% Error in space:
cnt = 1;
subplot(1,2,2);
fprintf('Error in space(%0.f tests):\n',endM-startN+1);
for i = startM:endM
    tic
    M = round(2^i);
    h1(cnt) = 20/(M+2);
    H = solveWave(M, Nref, x0, xEnd,time, metode, 0,height, plotOrNot,counter);
    x = round(Mref/2^i);
    tel = 1;
    for j = x:x:Mref
        err1(cnt,tel) = Href(1,j)-H(end,tel);
        tel = tel+1;
    end
    e1(cnt) = norm(err1(cnt,:))*sqrt(h1(cnt));
    cnt = cnt+1;
    fprintf('%.0f of %.0f finished.\n',endN-startN+i-startM+2,endN-startN+endM-startM+2)
    toc
end
loglog(h1,e1,'-o')
hold on
loglog(h1,h1.^2,'--')
loglog(h1,h1,'--')
legend('Error in 2-norm','O(h^2)','O(h)')
title('Convergence plot wrt x')
xlabel('Steplength')
ylabel('Error')
set(gca,'fontsize',18)
hold off
xlim([min(h1),max(h1)])
ordenx = polyfit(log(h1),log(e1),1);
fprintf('Faar tidsteg av orden %1.2f \n', ordent(1));
fprintf('Faar romsteg av orden %1.2f \n', ordenx(1));
% saveTightFigure(fig,'Figurer/figureName.pdf'); 