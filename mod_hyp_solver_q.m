function H = mod_hyp_solver_q(M,N)
% M = 500;
% N = 1000;
h0 = @(x) 1+2/5*exp(-1/2*(x).^2/0.5);
%% Initierer x,t,H og Q
x = linspace(-20,20,M);
h = x(2)-x(1);
t = linspace(0,2,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = h0(x);
H(:,1) = ones(N,1);
H(:,end) = ones(N,1);
Q = zeros(N,M);
%% The actual method
%H = lax_wendroff(H,Q,M,N,k,h);
%H = mod_leap_frog(H,Q,M,N,k,h);
H = leap_frog(H,Q,M,N,k,h);
%% Movie
% for i = 1:10:N
%    plot(x,H(i,:));  % plot
%    ylim([0,2]); 
%    xlim([-10,10]); % guarantee consistent height
%    F(i) = getframe;  % capture it
% end
end

