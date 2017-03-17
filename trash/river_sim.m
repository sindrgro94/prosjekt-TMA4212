function h = river_sim(x,t)
g = 9.81;
S = 2.957918120187525;
u2 = S-g/(8*S)*(1+sqrt(1+16*S^2/g));
c2 = sqrt(g/4*(sqrt(1+16*S^2/g)-1));

if x < 1/2-t*sqrt(g)
    h = 1;
elseif 1/2-t*sqrt(g) <= x && x <= (u2-c2)*t+1/2
    h = 1/(9*g)*(2*sqrt(g)-(2*x-1)/(2*t))^2;
elseif (u2-c2)*t+1/2 < x && x <= S*t+1/2
    h = 1/4*(sqrt(1+16*S^2/g)-1);
elseif x > S*t+1/2
    h = 1/2;
end
