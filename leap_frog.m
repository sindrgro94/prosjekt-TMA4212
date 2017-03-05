function [Hret,Qret] = leap_frog(H,Q,M,k,h)
fwd = [-25/12,4,-3,4/3,-1/4]';
bwd = -fwd;
cntr = [1/12,-2/3,0,2/3,-1/12]';
G = @(q,h) q^2/h+1/2*9.81*h^2;
for m = 1:M
    if m < 4
    H(3,m) = H(1,m) - k/h*[Q(2,m),Q(2,m+1),Q(2,m+2),Q(2,m+3),Q(2,m+4)]*fwd;
    Q(3,m) = Q(1,m) - k/h*[G(Q(2,m),H(2,m)),G(Q(2,m+1),H(2,m+1)),G(Q(2,m+1),H(2,m+1)),G(Q(2,m+2),H(2,m+2)),G(Q(2,m+3),H(2,m+3))]*fwd;
    elseif m>=length(H)-4
    H(3,m) = H(1,m) - k/h*[Q(2,m),Q(2,m-1),Q(2,m-2),Q(2,m-3),Q(2,m-4)]*bwd;
    Q(3,m) = Q(1,m) - k/h*[G(Q(2,m),H(2,m)),G(Q(2,m-1),H(2,m-1)),G(Q(2,m-1),H(2,m-1)),G(Q(2,m-2),H(2,m-2)),G(Q(2,m-3),H(2,m-3))]*bwd;    
        
        %Leap-frog modified: Et forsøk på å fjerne disperson ved å øke
        %nøyaktigheten til til den deriverte se side 123 JCS 
%       dh4 = [Q(2,m-3),Q(2,m-2),Q(2,m-1),Q(2,m),Q(2,m+1),Q(2,m+2),Q(2,m+3)]*[-1/6,2,-13/2,28/3,-13/2,2,-1/6]'/h^5;
%       dq4 = [G(Q(2,m-3),H(2,m-3)),G(Q(2,m-2),H(2,m-2)),G(Q(2,m-1),H(2,m-1)),G(Q(2,m),H(2,m)),G(Q(2,m+1),H(2,m+1)),G(Q(2,m+1),H(2,m+1)),G(Q(2,m+3),H(2,m+3))]*[-1/6,2,-13/2,28/3,-13/2,2,-1/6]'/h^5;
    else
    H(3,m) = H(1,m) - k/h*[Q(2,m-2),Q(2,m-1),Q(2,m),Q(2,m+1),Q(2,m+2)]*cntr;%;+0.5/(2*k)*(h/2)^4*dh4;
    Q(3,m) = Q(1,m) - k/h*(1/12*G(Q(2,m-2),H(2,m-2))-2/3*G(Q(2,m-1),H(2,m-1))+2/3*G(Q(2,m+1),H(2,m+1))-1/12*G(Q(2,m+2),H(2,m+2)));%+ 0.5/(2*k)*(h/2)^4*dq4;
    end
end
    Hret = H(3,:);
    Qret = Q(3,:);
end
        