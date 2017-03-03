function hyp_solver_q()
h0 = @(x) 1+2/5*exp(-1/2*(x).^2/0.5);
G = @(q,h) q^2/h+1/2*9.81*h^2;
M = 100;
N = 200;
x = linspace(-5,5,M);
h = x(2)-x(1);
t = linspace(0,1,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = h0(x);
H(:,1) = ones(N,1);
H(:,end) = ones(N,1);
Q = zeros(N,M);
g = 9.81;
for n = 1:N-1
    for m = 2:M-1
%         H(n+1,m) = -k/h*(Q(n,m)-Q(n,m-1))+H(n,m);
%         Q(n+1,m) = -k/h*(Q(n,m)^2/H(n,m)+1/2*g*H(n,m)^2-(Q(n,m-1)^2/H(n,m-1)+1/2*g*H(n,m-1)^2))+Q(n,m);
        %Lax-Wendroff
        H(n+1,m) = H(n,m) - k/(h*2)*(Q(n,m+1)-Q(n,m-1))+1/2*(k/h)^2*(Q(n,m+1)-2*Q(n,m)+Q(n,m-1));
        Q(n+1,m) = Q(n,m) - k/(h*2)*(G(Q(n,m+1),H(n,m+1))-G(Q(n,m-1),H(n,m-1)))+1/2*(k/h)^2*(G(Q(n,m+1),H(n,m+1))-2*G(Q(n,m),H(n,m))+G(Q(n,m-1),H(n,m-1)));
    end
end
%close all
for i = 1:1:100
   plot(x,H(i,:));  % plot
   ylim([0,2]); 
   xlim([-5,5]); % guarantee consistent height
   F(i) = getframe;  % capture it
   pause(0.001);
end
end

