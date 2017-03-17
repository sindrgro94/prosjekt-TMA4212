function H = mod_leap_frog(H,Qinn,M,N,k,h)
cntr = [1/2,0,-1/2]';
d4 = [1,-4,6,-4,1]';
G = @(q,h) q^2/h+1/2*9.81*h^2;
%% One step with Lax-Wendroff   
t = linspace(0,k,100);
khat = t(2)-t(1);
Hhat = zeros(length(t),M);
Hhat(1,:) = H(1,:);
[Hhat,Q] = lax_wendroff(Hhat,Qinn,M,100,khat,h); %her skjer det en feil
H(2,:) = Hhat(end,:);
p = k/h;
%% Her begynner selve metoden
clear Qinn;
for n = 2:N-1
    for m = 2:M-1
        if m>2 && m<M-2
            dH4 = ([Q(1,m-2),Q(1,m-1),Q(1,m),Q(1,m+1),Q(1,m+2)]*d4)/h^4;
            dQ4 = ([G(Q(2,m-2),H(n,m-2)),G(Q(2,m-1),H(n,m-1)),G(Q(2,m),H(n,m)),G(Q(2,m+1),H(n,m+1)),G(Q(2,m+2),H(n,m+2))]*d4)/h^4;
            H(n+1,m) = H(n-1,m) - p*([Q(2,m-1),Q(2,m),Q(2,m+1)]*cntr) ;%+ (0.5/(2*k))*(h/2)^4*dH4;
            Q(3,m) = Q(1,m) - p*([G(Q(2,m-1),H(n,m-1)),G(Q(2,m),H(n,m)),G(Q(2,m+1),H(n,m+1))]*cntr);%+(0.5/(2*k))*(h/2)^4*dQ4;
        else
            H(n+1,m) = H(n-1,m) - p*([Q(2,m-1),Q(2,m),Q(2,m+1)]*cntr);
            Q(3,m) = Q(1,m) - p*([G(Q(2,m-1),H(n,m-1)),G(Q(2,m),H(n,m)),G(Q(2,m+1),H(n,m+1))]*cntr);
        end
    end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(3,M) = Q(3,M-1);
    Q(3,1) = Q(3,2);
    %For å spare minne til Q
    Q(1,:) = Q(2,:);
    Q(2,:) = Q(3,:);
end
end        