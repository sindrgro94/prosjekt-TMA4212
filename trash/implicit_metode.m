function H = implicit_metode(H,Qinn,M,N,k,h)
G = @(q,h) q^2/h+1/2*9.81*h^2;
H(:,1) = ones(N,1);
H(:,end) = ones(N,1);
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
p = k/h;
for n = 1:N-1
    for m = 2:M
         H(n+1,m) = H(n,m) - p*(Q(2,m)-Q(2,m-1));
         Q(2,m) = Q(1,m) - p*(G(Q(2,m),H(n+1,m))-G(Q(2,m-1),H(n+1,m-1)));
    end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(2,M) = Q(2,M-1);
    Q(2,1) = Q(2,2);
%for å spare oss for minne til Q
    Q(1,:) = Q(2,:);
end
end