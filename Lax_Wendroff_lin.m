function [H,Q] = Lax_Wendroff_lin(H,Qinn,M,N,k,h,x)
g = 9.81;
height = 1;
A = [0,1;g*height,0];
A2 = A^2;
Q = zeros(size(H));
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
[H(1,:),Q(1,:)] = bolge(x,0);
p = k/h;
clear Qinn;
for n = 1:N-1
    U(1,:) = H(n,:);
    U(2,:) = Q(n,:);
    for m = 2:M-1
        Uhel = U(:,m)-p/2*A*(U(:,m+1)-U(:,m-1))+p^2/2*A2*(U(:,m+1)-2*U(:,m)+U(:,m-1));
        H(n+1,m) = Uhel(1);
        Q(n+1,m) = Uhel(2);
    end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = 0.5;
    Q(n+1,(M-2)+1) = -Q(n+1,(M-2)-1);
    Q(n+1,(M-2)+2) = -Q(n+1,(M-2)-2);
    Q(n+1,1) = 0;
    Q(n+1,2) = 0;
%for ? spare oss for minne til Q
end
end

function [H,Q] = h0(x)
H = zeros(1,length(x));
Q = zeros(1,length(x));
% omega = pi/2*sqrt(9.81*0.5);
    for i = 1:length(x)
        if x(i) <= -2
            H(i) = 0.5;
        elseif x(i) >= 2
            H(i) = 0.5;
        else
            H(i) = 1/100*(cos(pi/2*x(i))+1)+0.5;
%             Q(i) = 1/10*(cos(pi/2*x(i))+1)/H(i);
        end
    end
end