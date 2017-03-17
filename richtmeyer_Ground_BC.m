function H = richtmeyer_Ground_BC(H,Qinn,M,N,k,h)
F = @(U) [U(2);U(2)^2/U(1)+1/2*9.81*U(1)^2];
R = @(U,x) [0;9.81*U(1)*x*exp(-(x-20)^2)];
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
U = zeros(2,M);
clear Qinn;
p = k/h;
for n = 1:N-1
    U(1,:) = H(n,:);
    U(2,:) = Q(1,:);
    for m = 2:M-1
        Uhalvp = 1/2*((U(:,m+1)+U(:,m))-p*(F(U(:,m+1))-F(U(:,m))));
        Uhalvm = 1/2*((U(:,m)+U(:,m-1))-p*(F(U(:,m))-F(U(:,m-1))));
        Uhel = U(:,m)-p*(F(Uhalvp)-F(Uhalvm))+p*R(U(:,m)-U(:,m-1),h*m);
        H(n+1,m) = Uhel(1);
        Q(2,m) = Uhel(2);
    end 
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(2,(M-2)+1) = -Q(2,(M-2)-1);
    Q(2,(M-2)+2) = -Q(2,(M-2)-2);
    Q(2,1) = -Q(2,5);
    Q(2,2) = -Q(2,4);
%for ? spare oss for minne til Q
    Q(1,:) = Q(2,:);
end