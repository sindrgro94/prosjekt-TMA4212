function [H,Q] = lax_wendroff_BC(H,Qinn,M,N,k,h)
G = @(q,h) q^2/h+1/2*9.81*h^2;
Q(1,:) = Qinn(1,:);
Q(2,:) = Qinn(2,:);
clear Qinn;
for n = 1:N-1
    for m = 2:M-1
    H(n+1,m) = H(n,m) - k/(h*2)*(Q(1,m+1)-Q(1,m-1))+1/2*(k/h)^2*(Q(1,m+1)-2*Q(1,m)+Q(1,m-1));
    Q(2,m) = Q(1,m) - k/(h*2)*(G(Q(1,m+1),H(n,m+1))-G(Q(1,m-1),H(n,m-1)))+1/2*(k/h)^2*(G(Q(1,m+1),H(n,m+1))-2*G(Q(1,m),H(n,m))+G(Q(1,m-1),H(n,m-1)));
    end 
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(2,(M-2)+1) = -Q(2,(M-2)-1);
    Q(2,(M-2)+2) = -Q(2,(M-2)-2);
    Q(2,1) = -Q(2,5);
    Q(2,2) = -Q(2,4);
%for å spare oss for minne til Q
    Q(1,:) = Q(2,:);
end
end
