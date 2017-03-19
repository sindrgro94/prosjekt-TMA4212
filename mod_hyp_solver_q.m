function H = mod_hyp_solver_q(M,N,time)
%mod_hyp_solver_q(500,10000,90)
h0 = @(x) 1+1/3*exp(-1/2*(x).^2/0.1);
%% Initierer x,t,H og Q
xf = -20;
xt = 20;
L = xt-xf;
x = linspace(xf,xt,M);
h = x(2)-x(1);
t = linspace(0,time,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = h0(x);
Q = zeros(N,M);
disp(k/h);
% B = @(x) x*0;
B = @(x) 0.1*(sin(pi*(3*(x-xf)/L))+x/L);
Bd = @(x) 0.1*(pi/L * cos(pi*(x-xf)/L) + 1/L);
%% The actual method
% H = lax_Friedrich_cons(H,Q,M,N,k,h);
H = lax_Friedrich_seaBed(H,B,x,Q,M,N,k,h);
% H = richtmeyer_Ground_BC(H,Q,M,N,k,h);
% H = richtmeyer(H,Q,M,N,k,h);
% H = richtmeyer_BC(H,Q,M,N,k,h);
% H = lax_wendroff(H,Q,M,N,k,h); %Denne blir fort ustabil
% H = lax_wendroff_BC(H,Q,M,N,k,h);
% H = leap_frog(H,Q,M,N,k,h);
% H = leap_frog_BC(H,Q,M,N,k,h);
% H = implicit_metode(H,Q,M,N,k,h); %Solved explicitly - Unstable - page 88
% H = fullDiscretization(M,N,time)';
%% Movie
% plotWave(H,x,t,B)
close all
     for i = 1:N %
        plot(x,H(i,:)+B(x)); %plot wave
        hold on
        plot(x,B(x));% plot sea bed
        ylim([0+min(min(B(x))),2]); 
        xlim([xf,xt]); % guarantee consistent height
        F(i) = getframe;  % capture it
        pause(time/(15*N)-0.03);
        hold off
     end
end

