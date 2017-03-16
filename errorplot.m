function errorplot()
%Tar ikke inn noe
%Finner loglog-plot for feilen i mod_hyp_solver_q.m
time = 0.5;
%% finner feil i tiden
fig = figure;
subplot(1,2,1);
tic
Href_t = mod_hyp_solver_q(100,2^15,time);
toc
cnt = 1;
for i = 7:0.5:9
    tic
    N = floor(2^i);
    h(cnt) = 1/(N+2);
    H = mod_hyp_solver_q(100,N,time);
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
steg = 2^15;
Href = mod_hyp_solver_q(steg,1000,time);
toc
cnt = 1;
subplot(1,2,2);
for i = 6:9
    tic
    M = round(2^i);
    h1(cnt) = 40/(M+2);
    H = mod_hyp_solver_q(M,1000,time);
    x = round(steg/2^i);
    tel = 1;
    for j = 1:x:steg
        err1(cnt,tel) = Href(end,j)-H(end,tel);
        tel = tel+1;
    end
    e1(cnt) = norm(err1(cnt,:))*sqrt(h1(cnt));
    cnt = cnt+1;
    toc
end
loglog(h1,e1,'-o')
hold on
loglog(h1,h1.^2*10,'--')
loglog(h1,h1,'--')
legend('Error in 2-norm','O(h^2)','O(h)')
title('Convergence plot wrt x')
xlabel('Steplength')
ylabel('Error')
set(gca,'fontsize',18)
hold off
xlim([min(h1),max(h1)])
ordenx = polyfit(log(h1),log(e1),1);
fprintf('F?r tidsteg av orden %1.2f \n', ordent(1));
fprintf('F?r romsteg av orden %1.2f \n', ordenx(1));
saveTightFigure(fig,'Figurer/errorFullDiscretization.pdf');
end