function H = solveWave(M, N, x0, xEnd,tEnd, method, groundFunction,startHeight, plotOrNot,countdown)
%% Description:
% M = number of steps in space
% N = number of steps in time
% x0 = left boundary
% xEnd = right boundary
% method = string that chooses which method to use. options: --> (
% groundfunction = string that chooses how the ground should be. options:
%               --> ( 
% startHeight = string that chooses how the start height of the water
%               should be. options: -->(
% plotOrNot = true if supposed to plot, false else.
% countdown = true if countdown should be printed.
%% initialising standard variables:
x = linspace(x0,xEnd,M);
h = x(2)-x(1);
t = linspace(0,tEnd,N);
k = t(2)-t(1);
H = zeros(N,M);
Q = zeros(N,M);

%% Choosing correct startHeight
switch (startHeight)
    case 'dam break cont'
        H(1,:) = dam_break(x);
    case 'dam break discont'
        H(1,:) = dam_break2(x);
    case 'wavetop shifted'
        xShifted = 2;
        variance = 0.1;
        h0 = @(x) 1+1/3*exp(-1/2*(x-xShifted).^2/variance);
        H(1,:) = h0(x);
    case 'wavetop'
        variance = 2;
        h0 = @(x) 1+1/3*exp(-1/2*(x).^2/variance);
        H(1,:) = h0(x);
    otherwise
        disp('There exist no such start height!')
        return
end
%% Choosing correct groundfunction
B = zeros(1,length(x));
switch (groundFunction)
    case 'cosine in middle'
        widthOfBump = 0.5;
        for i = 1:length(x)
            if x(i) >= -widthOfBump && x(i) <= widthOfBump
                B(i) = 1/3*(cos(x(i)*2*pi)+1);
            end
        end
    otherwise
        %do nothing. Normal and flat at 0.  
end

%% Using correct method
switch (method)
    case 'leap frog normal'
        H = leap_frog_BC(H,Q,M,N,k,h,countdown);
    case 'full discretization normal'
        H = fullDiscretization(M,N,tEnd,countdown)';
    case 'richtmeyer normal'
        H = richtmeyer_BC(H,Q,M,N,k,h,countdown);
    case 'richtmeyer seabed' 
        H(1,:) = H(1,:)-B;
        H = richtmeyer_BC_grunn(H,B,x,Q,M,N,k,h,countdown);
    case 'lax friedrich normal'
        H = lax_Friedrich(H,Q,M,N,k,h,countdown);
    case 'lax friedrich seabed'
        H(1,:) = H(1,:)-B;
        H = lax_Friedrich_grunn(H,B,x,Q,M,N,k,h,countdown);
%       H = lax_Friedrich_seaBed(H,B,x,Q,M,N,k,h,countdown)
    case 'lax wendroff normal'
        H = lax_wendroff_BC(H,Q,M,N,k,h,countdown);
    otherwise
        disp('There exist no such method!')
        return
end

%% Plotting if specified

if (plotOrNot)
    close all
    s = size(H);
    maxY = max(max(H+ones(s(1),1)*B));
    timeLoop = 0.06; % bigger number gives faster plot and vica verca
    steps = tEnd/timeLoop;
    for i = 1:round(N/steps):N
        plot(x,H(i,:)+B); %plot wave
        ylim([min(B)-0.5,maxY+0.5]); % guarantee consistent height and get some free space
        xlim([x0,xEnd]); % guarantee consistent width
        hold on
        plot(x,B);% plot sea bed
        F = getframe;
        hold off
    end
end