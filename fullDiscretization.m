function fullDiscretization(M,N)
x0 = -5;
xend = 5;
t0 = 0;
tend = 1;
u0 = 0;
uend = 0;
h0 = 1;
hend = 1;
g = 9.81;
x = linspace(x0,xend,M+2);
t = linspace(t0,tend,N+1);
b = (xend-x0)/(M+1);
k = (tend-t0)/N;
uPrev = zeros(M,1);
hPrev = makeH0(M);





end
function h = makeH0(M)
if M>=20
   h = ones(M); 
else
    disp('Use h larger or equal than 20!')
    h = 1;
end