function H = leap_frog(H,Qinn,M,N,k,h)
cntr = [1/2,0,-1/2]';
G = @(q,h) q^2/h+1/2*9.81*h^2;
%One step with Lax-Wendroff   
t = linspace(0,k,10);
khat = t(2)-t(1);
Hhat = H(1:length(t),:);
[Hhat,Q] = lax_wendroff(Hhat,Qinn,M,100,khat,h); 
H(2,:) = Hhat(end,:);
p = k/h;

clear Qinn;
for n = 2:N-1
for m = 2:M-1
%     if m>2 && m<M-1
%         H(n+1,m) = H(n-1,m) - p*(Q(2,m+1)-Q(2,m-1));
%         Q(3,m) = Q(1,m) - p*(G(Q(2,m+1),H(n,m+1))-G(Q(2,m-1),H(n,m-1)));
%     end
    H(n+1,m) = H(n-1,m) - p*(Q(2,m+1)-Q(2,m-1));
    Q(3,m) = Q(1,m) - p*(G(Q(2,m+1),H(n,m+1))-G(Q(2,m-1),H(n,m-1)));
end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(3,M) = Q(3,M-1);
    Q(3,1) = Q(3,2);
    %For � spare minne til Q
    Q(1,:) = Q(2,:);
    Q(2,:) = Q(3,:);
end
end        