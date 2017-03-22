function H = richtmeyer(H,Qinn,M,N,k,h)
F = @(U) [U(2);U(2)^2/U(1)+1/2*9.81*U(1)^2];
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
U = zeros(2,M);
clear Qinn;
for n = 1:N-1
    U(1,:) = H(n,:);
    U(2,:) = Q(1,:);
    for m = 2:M-1
        Uhalvp = 1/2*(U(:,m+1)+U(:,m))-k/(2*h)*(F(U(:,m+1))-F(U(:,m)));
        Uhalvm = 1/2*(U(:,m)+U(:,m-1))-k/(2*h)*(F(U(:,m))-F(U(:,m-1)));
        Uhel = U(:,m)-k/h*(F(Uhalvp)-F(Uhalvm));
        H(n+1,m) = Uhel(1);
        Q(2,m) = Uhel(2);
    end 
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(2,M) = Q(2,M-1);
    Q(2,1) = Q(2,2);
%for ? spare oss for minne til Q
    Q(1,:) = Q(2,:);
end