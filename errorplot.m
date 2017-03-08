function errorplot()
%Tar ikke inn noe
%Finner loglog-plot for feilen i mod_hyp_solver_q.m
%% finner feil i tiden
tic
load('Href_t');
toc
cnt = 1;
for i = 11:0.5:13
    tic
    N = floor(2^i);
    h(cnt) = 1/(N+2);
    H = mod_hyp_solver_q(200,N,1);
    err = H(end,:)-Href_t(end,:);
    e(cnt) = norm(err)*sqrt(h(cnt));
    cnt = cnt+1;
    toc
end
loglog(h,e,'o-r')
hold on
loglog(h,h.^2*5)
legend('2-norm','O(k^2)')
title('Convergence plot wrt t')
xlabel('steplength')
ylabel('Error')
hold off

%% Finner feil i rommet
tic
%load('Href_x')
toc
load('Href'); %for t = 1
cnt = 1;
for i = 6:9
    tic
    M = 2^i;
    h(cnt) = 40/(M+2);
    H = mod_hyp_solver_q(M,2048,1);
    x = 2048/2^i;
    tel = 1;
    for j = 1:x:2048
        err(cnt,tel) = Href(end,j)-H(end,tel);
        tel = tel+1;
    end
    e(cnt) = norm(err(cnt,:))*sqrt(h(cnt));
    cnt = cnt+1;
    toc
end
figure
loglog(h,e,'-o')
hold on
loglog(h,h.^2*10)
loglog(h,h)
legend('error','O(h^2)','O(h)')
title('Convergence plot wrt x')
hold off
end