function hyp_solver_q()
M = 2000;
N = 2000;

h0 = @(x) 1+2/5*exp(-1/2*(x).^2/0.5);
G = @(q,h) q^2/h+1/2*9.81*h^2;
%% Initierer x,t,H og Q
x = linspace(-25,25,M);
h = x(2)-x(1);
t = linspace(0,4,N);
k = t(2)-t(1);
p = k/h;
H = zeros(N,M);
H(1,:) = h0(x);
H(:,1) = ones(N,1);
H(:,end) = ones(N,1);
Q = zeros(N,M);
% g = 9.81
%% Start value for leap-frog using Lax-Wendroff
    n = 1;
    for m = 2:M-1
    H(n+1,m) = H(n,m) - k/(h*2)*(Q(n,m+1)-Q(n,m-1))+1/2*(k/h)^2*(Q(n,m+1)-2*Q(n,m)+Q(n,m-1));
    Q(n+1,m) = Q(n,m) - k/(h*2)*(G(Q(n,m+1),H(n,m+1))-G(Q(n,m-1),H(n,m-1)))+1/2*(k/h)^2*(G(Q(n,m+1),H(n,m+1))-2*G(Q(n,m),H(n,m))+G(Q(n,m-1),H(n,m-1)));
    end 
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(n+1,M) = Q(n+1,M-1);
    Q(n+1,1) = Q(n+1,2);

%% The actual method
for n = 2:N-1
    for m = 2:M-1
%         H(n+1,m) = -k/h*(Q(n,m)-Q(n,m-1))+H(n,m);
%         Q(n+1,m) = -k/h*(Q(n,m)^2/H(n,m)+1/2*g*H(n,m)^2-(Q(n,m-1)^2/H(n,m-1)+1/2*g*H(n,m-1)^2))+Q(n,m);
        %Lax-Wendroff
%         H(n+1,m) = H(n,m) - k/(h*2)*(Q(n,m+1)-Q(n,m-1))+1/2*(k/h)^2*(Q(n,m+1)-2*Q(n,m)+Q(n,m-1));
%         Q(n+1,m) = Q(n,m) - k/(h*2)*(G(Q(n,m+1),H(n,m+1))-G(Q(n,m-1),H(n,m-1)))+1/2*(k/h)^2*(G(Q(n,m+1),H(n,m+1))-2*G(Q(n,m),H(n,m))+G(Q(n,m-1),H(n,m-1)));
        %Leap-frog
        if m < 4 || m > M-4
        H(n+1,m) = H(n-1,m) - k/h*(Q(n,m+1)-Q(n,m-1));
        Q(n+1,m) = Q(n-1,m) - k/h*(G(Q(n,m+1),H(n,m+1))-G(Q(n,m-1),H(n,m-1)));
        else
        %Leap-frog modified: Et forsøk på å fjerne disperson ved å øke
        %nøyaktigheten til til den deriverte se side 123 JCS 
%         dh4 = [Q(n-1,m-3),Q(n-1,m-2),Q(n-1,m-1),Q(n-1,m),Q(n-1,m+1),Q(n-1,m+2),Q(n-1,m+3)]*[-1/6,2,-13/2,28/3,-13/2,2,-1/6]'/h^4;
%         dq4 = [G(Q(n-1,m-3),H(n-1,m-3)),G(Q(n-1,m-2),H(n-1,m-2)),G(Q(n-1,m-1),H(n-1,m-1)),G(Q(n-1,m),H(n-1,m)),G(Q(n-1,m+1),H(n-1,m+1)),G(Q(n-1,m+1),H(n-1,m+1)),G(Q(n-1,m+3),H(n-1,m+3))]*[-1/6,2,-13/2,28/3,-13/2,2,-1/6]'/h^4;
        H(n+1,m) = H(n-1,m) - k/h*(1/12*Q(n,m-2)-2/3*Q(n,m-1)+2/3*Q(n,m+1)-1/12*Q(n,m+2));%+0.5/(2*k)*(h/2)^4*dh4;
        Q(n+1,m) = Q(n-1,m) - k/h*(1/12*G(Q(n,m-2),H(n,m-2))-2/3*G(Q(n,m-1),H(n,m-1))+2/3*G(Q(n,m+1),H(n,m+1))-1/12*G(Q(n,m+2),H(n,m+2)));%+ 0.5/(2*k)*(h/2)^4*dq4;
        end
    end
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(n+1,M) = Q(n+1,M-1);
    Q(n+1,1) = Q(n+1,2);
%     [H(n+1,:),Q(n+1,:)] = mod_leap_frog(H(n-1:n,:),Q(n-1:n,:),M,k,h);
end
%close all
for i = 1:10:N
   plot(x,H(i,:));  % plot
   ylim([0,2]); 
   xlim([-10,10]); % guarantee consistent height
   F(i) = getframe;  % capture it
%   pause(0.01);
end
end

