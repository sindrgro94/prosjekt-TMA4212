function H = mod_hyp_solver_q(M,N,time)
%mod_hyp_solver_q(500,10000,90)
h0 = @(x) 1+2/5*exp(-1/2*(x).^2/0.5);
%% Initierer x,t,H og Q
x = linspace(-20,20,M);
h = x(2)-x(1);
t = linspace(0,time,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = h0(x);
Q = zeros(N,M);
%% The actual method
%H = lax_wendroff(H,Q,M,N,k,h); %Denne blir fort ustabil
%H = lax_wendroff_BC(H,Q,M,N,k,h);
% H = leap_frog(H,Q,M,N,k,h);
H = leap_frog_BC(H,Q,M,N,k,h);
%H = implicit_metode(H,Q,M,N,k,h); %Solved explicitly - Unstable - page 88
%% Movie
     for i = 1:ceil(N/400):N %
        plot(x,H(i,:));  % plot
        ylim([0,2]); 
        xlim([-30,30]); % guarantee consistent height
        F(i) = getframe;  % capture it
     end
end

