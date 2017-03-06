function errorplot()
%Tar ikke inn noe
%Finner loglog-plot for feilen i mod_hyp_solver_q.m
%% finner feil i tiden
tic
load('Href_t');
toc
cnt = 1;
for i = 9:11
    tic
    N = 2^i;
    h(cnt) = 1/(N+2);
    H = mod_hyp_solver_q(500,2^i);
    err = H(end,:)-Href_t(end,:);
    e(cnt) = norm(err)*sqrt(h(cnt));
    cnt = cnt+1;
    toc
end
loglog(h,e,'o-r')
hold on
loglog(h,h.^2*100)
legend('2-norm','O(k^2)')
title('Convergence plot wrt t')
xlabel('steplength')
ylabel('Error')
hold off

%% Finner feil i rommet
load('Href');
cnt = 1;
for i = 8:10
    tic
    M = 2^i;
    h(cnt) = 1/(M+2);
    H = mod_hyp_solver_q(M,4000);
    x = 2048/(2^i);
    tel = 1;
    for j = 1:x:2048
        err(tel) = Href(end,j)-H(end,tel);
        tel = tel+1;
    end
    e(cnt) = norm(err)*sqrt(h(cnt));
    cnt = cnt+1;
    toc
end
figure
loglog(h,e,'-o')
hold on
loglog(h,h.^2*1000)
legend('error','O(h^2)')
title('Convergence plot wrt x')
hold off
end