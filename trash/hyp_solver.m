function hyp_solver()
N = 1000;
M = 500;
f = @(u,h) u*h;
g = @(u,h) h*u^2+1/2*9.81*h^2;
h0 = @(x) 1+2/5*exp(-1/2*(x-0.5).^2/0.005);
t = linspace(0,1,N);
k = t(2)-t(1);
x = linspace(-5,5,M);
h = x(2)-x(1);
G = 9.81;
H = zeros(N,M);
H(1,:) = h0(x);
U = zeros(N,M);
for n = 1:N
    H(n+1,1) = 1;
   for m = 1:M-1
%        H(n+1,m) = -(f(U(n,m+1),H(n,m+1))-f(U(n,m),H(n,m)))*k/h + H(n,m);
       H(n+1,m) = -(U(n,m+1)*H(n,m+1)-U(n,m)*H(n,m))*k/h+H(n,m);
%        U(n+1,m) = (-(g(U(n,m+1),H(n,m+1))-g(U(n,m),H(n,m)))*k/h+f(U(n,m),H(n,m)))/H(n+1,m);
       U(n+1,m) = (-(H(n,m+1)*U(n,m+1)^2+1/2*G*H(n,m+1)^2-(H(n,m)*U(n,m)^2+1/2*G*H(n,m)^2))*k/h+U(n,m)*H(n,m))/H(n+1,m);
   end 
   H(n+1,M) =1;
   U(n+1,M) = U(n+1,M-1);
   %Kanskje bruke en derivasjonsformel for å finne punktet på randen også?
   %plot(x,H(n+1,:))
end
for i = 1:1:500
   plot(x,H(i,:));  % plot
   ylim([0,2]); 
   xlim([0,1]); % guarantee consistent height
   F(i) = getframe;  % capture it
   pause(0.01);
end
end