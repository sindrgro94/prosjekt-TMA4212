function H = leap_frog_BC(H,B,x,Qinn,M,N,k,h,countdown)
cntr = [1/2,0,-1/2]';
G = @(q,h) q^2/h+1/2*9.81*h^2;
%One step with Lax-Wendroff   
t = linspace(0,k,10);
khat = t(2)-t(1);
Hhat = H(1:length(t),:);
[Hhat,Q] = richtmeyer_BC_grunn(Hhat,B,x,Qinn,M,100,khat,h,countdown);
H(2,:) = Hhat(end,:);
p = k/h;
clear Qinn;
percentFinished = 0.05;
for n = 2:N-1
    if (n/N)>percentFinished && countdown
        fprintf('%.0f percent finished.\n',percentFinished*100);
        percentFinished = percentFinished + 0.05;
    end
    for m = 2:M-1
    H(n+1,m) = H(n-1,m) - p*([Q(2,m-1),Q(2,m),Q(2,m+1)]*cntr);
    Q(3,m) = Q(1,m) - p*([G(Q(2,m-1),H(n,m-1)),G(Q(2,m),H(n,m)),G(Q(2,m+1),H(n,m+1))]*cntr)-p/2*9.81*H(n,m)*(B(m+1)-B(m-1));
    end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(3,(M-2)+1) = -Q(2,(M-2)-1);
    Q(3,(M-2)+2) = -Q(2,(M-2)-2);
    Q(3,1) = -Q(2,5);
    Q(3,2) = -Q(2,4);
    %For ? spare minne til Q
    Q(1,:) = Q(2,:);
    Q(2,:) = Q(3,:);
end
end        