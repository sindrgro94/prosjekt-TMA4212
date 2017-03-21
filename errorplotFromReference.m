function errorplotFromReference()
metode = 'refMatrices/richtmeyer normal';
ref = load(metode);
metode = ref.metode;
height = ref.height;
time = ref.time;
x0 = ref.x0;
xEnd = ref.xEnd;
plotOrNot = false;
Href = ref.Href;
Mref = ref.M;
Nref = ref.N;
counter = true;
%% finner feil i tiden
fig = figure;
subplot(1,2,1);
cnt = 1;
for i = 5:6
    tic
    N = floor(2^i);
    h(cnt) = 1/(N+2);
    H = solveWave(Mref, N, x0, xEnd,time, metode, 0,height, plotOrNot,counter);
    err = H(end,:)-Href(:);
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
cnt = 1;
% subplot(1,2,2);
for i = 4:6
    tic
    M = round(2^i);
    h1(cnt) = 20/(M+2);
    H = solveWave(M, Nref, x0, xEnd,time, metode, 0,height, plotOrNot);
    x = round(refSteg/2^i);
    tel = 1;
    for j = x:x:refSteg
        err1(cnt,tel) = Href(j)-H(end,tel);
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
fprintf('Faar tidsteg av orden %1.2f \n', ordent(1));
fprintf('Faar romsteg av orden %1.2f \n', ordenx(1));
% saveTightFigure(fig,'Figurer/errorFullDiscretization.pdf'); %when using
% this saveing, set breakpoint before and adjust the figure st it looks nice.
end