function [H,Q] = bolge(x,t)
L = 40; % B�lgelengde
k = 2*pi/L;
T = L/sqrt(9.81*0.5); % L/sqrt(g*h0)
omega = 2*pi/T;
a = 1/100;
d = 0.5;
g = 9.81;
H = zeros(size(x));
Q = zeros(size(x));
for i = 1:length(x)
        if x(i) <= -L/2+sqrt(g*d)*t
            H(i) = d;
        elseif x(i) >= L/2+sqrt(g*d)*t
            H(i) = d;
        else
            H(i) = a*sin(omega*t-k*x(i))+d;
            Q(i) = H(i) * ((omega*a)/(k*d)*sin(omega*t-k*x(i))); %h*u
        end
end
end