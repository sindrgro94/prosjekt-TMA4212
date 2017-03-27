syms('w','x','t','k','a','h0','g');

A = [0,1;g*h0,0];

U = [a*sin(w*t-k*x);(w*a)/(k*h0)*sin(w*t-k*x)];
Ux = diff(U,x);
Ut = diff(U,t);

svar = Ut+A*Ux;