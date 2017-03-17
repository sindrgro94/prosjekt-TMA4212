function X = cons(Um,Ump,p)
F = @(U) [U(2);U(2)^2/U(1)+1/2*9.81*U(1)^2];
X = 1/2*(p*(Um-Ump)+(F(Um)+F(Ump)));
end