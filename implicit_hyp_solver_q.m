function implicit_hyp_solver_q()
M = 100;
N = 1000;

h0 = @(x) 1+2/5*exp(-1/2*(x).^2/0.5);
G = @(q,h) q^2/h+1/2*9.81*h^2;
%% Initierer x,t,T,F
x = linspace(-25,25,M);
h = x(2)-x(1);
t = linspace(0,2,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = h0(x);
H(:,1) = ones(N,1);
H(:,end) = ones(N,1);
Q = zeros(N,M);


T = @(q1,q2,h1,h2,p) eye(2)-p/2*[0,0;9.81*(h2-h1)-(q2^2/h2^2-q1^2/h1^2), 2*(q2/h1-q1/h1)];
F = @(q,h) [q;q^2/h+1/2*9.81*h^2];
n = 1;


%% The actual method
for n = 1:N-1
    for  m = 2:M-1
        Tu = T(Q(n,m),Q(n,m+1),H(n,m),H(n,m+1),k/h);
        C = F(Q(n,m+1),H(n,m+1))-F(Q(n,m),H(n,m));
        A = [H(n,m); Q(n,m)]-k/h*(Tu\C);
        H(n+1,m) = A(1);
        Q(n+1,m) = A(2);
    end
    
    H(n+1,M) = H(n+1,M-1);
    H(n+1,1) = H(n+1,2);
    Q(n+1,M) = Q(n+1,M-1);
    Q(n+1,1) = Q(n+1,2);
    
end
%close all
for i = 1:8:N
   plot(x,H(i,:));  % plot
   ylim([0,2]); 
   xlim([-10,10]); % guarantee consistent height
   F(i) = getframe;  % capture it
%   pause(0.01);
end
end

