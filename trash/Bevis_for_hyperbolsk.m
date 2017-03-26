%Hyperbolske bevis
syms('h');
syms('u');
syms('g');
syms('h0');
V = [h;u];
F = [h*u;u^2*h+1/2*g*h^2];

jacF = [diff(F(1),u),diff(F(1),h); diff(F(2),u),diff(F(2),h)];
lambdas = eig(jacF);
storre_enn_null = g^2*h^2 - 2*g*h^2 + 2*g*h*u^2 + h^2 + 6*h*u^2 + u^4; %Hentet fra lambdas
x = solve(storre_enn_null==0,h); %S�rge for at h >= 0
hm = linspace(-10,10,100);
um = linspace(-10,10,100);
[H,U] = meshgrid(hm,um);
f = @(h,u,g) g^2*h.^2 - 2*g*h.^2 + 2*g*h*u.^2 + h.^2 + 6*h*u.^2 + u.^4;
surf(H,U,f(H,U,9.81))
S = [diff(storre_enn_null,u);diff(storre_enn_null,h)];
Hessian = [diff(S(1),u),diff(S(1),h);diff(S(2),u),diff(S(2),h)];
Hess = @(u,h,g) [12*u^2 + 12*h + 4*g*h,    12*u + 4*g*u;12*u + 4*g*u, 2*g^2 - 4*g + 2];
pm = linspace(-1,1,10);
tm = linspace(-1,1,10);
syms('p');
syms('t');
i = sqrt(-1);
A = [0,1;g*h0,0];
[V,D] = eig(A);
G = V*(eye(2)-i*p*sin(t)*D+p^2*(cos(t)-1)*D^2)*inv(V);
G = simplify(G);
X = abs(G(1,1))^2+abs(G(1,2))^2+abs(G(2,1))^2+abs(G(2,2))^2;