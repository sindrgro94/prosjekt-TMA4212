function hyp_solver_q()
h0 = @(x) 1+2/5*exp(-1/2*(x-0.5).^2/0.005);
M = 100;
N = 200;
x = linspace(-5,5,M);
h = x(2)-x(1);
t = linspace(0,1,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = h0(x);
Q = zeros(N,M);
g = 9.81;
for n = 1:N-1
    for m = 2:M
        H(n+1,m) = -k/h*(Q(n,m)-Q(n,m-1))+H(n,m);
        Q(n+1,m) = -k/h*(Q(n,m)^2/H(n,m)+1/2*g*H(n,m)^2-(Q(n,m-1)^2/H(n,m-1)+1/2*g*H(n,m-1)^2))+Q(n,m);
    end
end
