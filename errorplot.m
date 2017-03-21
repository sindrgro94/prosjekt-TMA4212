function errorplot()
%Tar ikke inn noe
%Finner loglog-plot for feilen i mod_hyp_solver_q.m
time = 0.5;
metode = 'richtmeyer normal';
height = 'wavetop';
x0 = -10;
xEnd = 10;
plot = false;
%% finner feil i tiden
fig = figure;
subplot(1,2,1);
tic
refSteg = 2^14;
Href_t = solveWave(100, refSteg, x0, xEnd,time, metode, 0,height, plot);
toc
cnt = 1;
for i = 7:1:9
    tic
    N = floor(2^i);
    h(cnt) = 1/(N+2);
    H = solveWave(100, N, x0, xEnd,time, metode, 0,height, plot);
    err = H(end,:)-Href_t(end,:);
    e(cnt) = norm(err)*sqrt(h(cnt));
    cnt = cnt+1;
    toc
end
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
%% Finner feil i rommet
tic
refSteg = 2^12;
Href = solveWave(refSteg, 1000, x0, xEnd,time, metode, 0,height, plot);
toc
cnt = 1;
% subplot(1,2,2);
for i = 6:13
    tic
    M = round(2^i);
    h1(cnt) = 20/(M+2);
    H = solveWave(M, 2^12, x0, xEnd,time, metode, 0,height, plot);
    x = round(refSteg/2^i);
    tel = 1;
    for j = x:x:refSteg
        err1(cnt,tel) = Href(end,j)-H(end,tel);
        tel = tel+1;
    end
    e1(cnt) = norm(err1(cnt,:))*sqrt(h1(cnt));
    cnt = cnt+1;
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
% fprintf('Faar tidsteg av orden %1.2f \n', ordent(1));
fprintf('Faar romsteg av orden %1.2f \n', ordenx(1));
% saveTightFigure(fig,'Figurer/errorFullDiscretization.pdf');
end