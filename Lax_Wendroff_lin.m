function [H,Q] = Lax_Wendroff_lin(H,Qinn,M,N,k,h,x,countdown)
g = 9.81;
height = 0.5;
A = [0,1;g*height,0];
A2 = A^2;
Q = zeros(size(H));
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
[H(1,:),Q(1,:)] = bolge(x,0);
p = k/h;
clear Qinn;
percentFinished = 0.05;
for n = 1:N-1
    if (n/N)>percentFinished && countdown
        fprintf('%.0f percent finished.\n',percentFinished*100);
        percentFinished = percentFinished + 0.05;
    end
    U(1,:) = H(n,:);
    U(2,:) = Q(n,:);
    for m = 2:M-1
        Uhel = U(:,m)-p/2*A*(U(:,m+1)-U(:,m-1))+1/2*p^2*A2*(U(:,m+1)-2*U(:,m)+U(:,m-1))/4;
        H(n+1,m) = Uhel(1);
        Q(n+1,m) = Uhel(2);
    end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = 0.5;
    Q(n+1,(M-2)+1) = -Q(n+1,(M-2)-1);
    Q(n+1,(M-2)+2) = -Q(n+1,(M-2)-2);
    Q(n+1,1) = 0;
    Q(n+1,2) = 0;
end
end