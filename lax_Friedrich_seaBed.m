function H = lax_Friedrich_seaBed(H,B,x,Qinn,M,N,k,h,countdown)
g = 9.81;
H(1,:) = H(1,:)-B(x);
F = @(U) [U(2);U(2)^2/U(1)+1/2*g*U(1)^2];
R = @(h,B) [0;-g*h*(B(1)-B(2))];
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
U = zeros(2,M);
clear Qinn;
p = k/h;
percentFinished = 0.05;
for n = 1:N-1
    if (n/N)>percentFinished && countdown
        fprintf('%.0f percent finished.\n',percentFinished*100);
        percentFinished = percentFinished + 0.05;
    end
    U(1,:) = H(n,:);
    U(2,:) = Q(1,:);
    for m = 2:M-1
        Uhel = 1/2*((U(:,m+1)+U(:,m-1))-p*(F(U(:,m+1))-F(U(:,m-1))))+p*R(U(1,m),[B(x(m));B(x(m-1))]);
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