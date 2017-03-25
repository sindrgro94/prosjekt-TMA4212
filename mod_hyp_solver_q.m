function H = mod_hyp_solver_q(M,N,time)
%mod_hyp_solver_q(500,10000,90)
h0 = @(x) 1+1/3*exp(-1/2*(x).^2/2);
%% Initierer x,t,H og Q
xf = 0;
xt = 1;
% L = xt-xf;
x = linspace(xf,xt,M);
xfine = linspace(xf,xt,M*50);
h = x(2)-x(1);
t = linspace(0,time,N);
k = t(2)-t(1);
H = zeros(N,M);
H(1,:) = dam_break2(x);
Q = zeros(N,M);
disp(k/h);
B = zeros(1,length(x));
% for i = 1:length(x)
%     if x(i) >= -2 && x(i) <= 2
%         B(i) = 1/3*(cos(x(i)*1/2*pi)+1);
%     end
% end
H(1,:) = H(1,:)-B;
% B = @(x) x*0;
% B = @(x) 1*(sin(pi*(3*(x-xf)/L)));
% Bd = @(x) 0.1*(pi/L * cos(pi*(x-xf)/L) + 1/L);
%% The actual method
tic
% [H,~]= Lax_Wendroff_lin(H,Q,M,N,k,h,x);
% H1 = lax_Friedrich(H,Q,M,N,k,h);
H = lax_Friedrich_grunn(H,B,x,Q,M,N,k,h,1);
% H = MacCormack_grunn(H,B,x,Q,M,N,k,h,1);   
H1 = richtmeyer_BC_grunn(H,B,x,Q,M,N,k,h,1);
% H1 = richtmeyer(H,Q,M,N,k,h);
% H1 = zeros(size(H));
% H1(1,:) = h1(x);
% H1 = richtmeyer_BC(H1,Q,M,N,k,h);
% H1 = lax_wendroff(H,Q,M,N,k,h); %Denne blir fort ustabil
% H1 = lax_wendroff_BC(H,Q,M,N,k,h);
% H1 = leap_frog(H,Q,M,N,k,h);
% H = leap_frog_BC(H,Q,M,N,k,h);
% H = implicit_metode(H,Q,M,N,k,h); %Solved explicitly - Unstable - page 88
% H1 = fullDiscretization(M,N,time)';
toc
fig = figure;
plot(x,H(1,:))
hold on
plot(x,B)
ylim([0-0.05,1.5])
title('Initial conditions: Dam break')
xlabel('Length (m)')
ylabel('Height (m)')
legend('Water','Sea bed')
set(gca,'fontsize',18)
saveTightFigure(fig,'Initial_conditions_Dam break')

%% Movie
% plotWave(H,x,t,B)
close all
fig = figure;
     for i = 1:ceil(N/300):130 %
        plot(x,H(i,:)+B,'b--'); %plot wave
        hold on
        plot(x,B,'r');
        plot(x,H1(i,:)+B,'m--');
        if max(max(H)) < 10
            ylim([min(min(0-0.05)),max(max(1.5))]);%ylim([min(min(H)),max(max(H))]); 
        else 
            ylim([0,4]);
        end
        xlim([xf,xt]); % guarantee consistent height
        F(i) = getframe;  % capture it
        
     end
     
H = false;
end

function H= h1(x)
H = zeros(1,length(x));
Q = zeros(1,length(x));
% omega = pi/2*sqrt(9.81*0.5);
    for i = 1:length(x)
        if x(i) <= -2
            H(i) = 0.5;
        elseif x(i) >= 2
            H(i) = 0.5;
        else
            H(i) = 1/100*(cos(pi/2*x(i))+1)+0.5;
%             Q(i) = 1/10*(cos(pi/2*x(i))+1)/H(i);
        end
    end
end
