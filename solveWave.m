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
    case 'approx'
        [H(1,:),Q(1,:)] = bolge(x,0);
    otherwise
        disp('There exist no such start height!')
        return
end
%% Choosing correct groundfunction
switch (groundFunction)
    case 'cosine in middle'
        widthOfBump = 2;
        B = bottom(x,widthOfBump); % See at the bottom of code
    otherwise
        B = zeros(1,length(x)); % Flat sea bed
end

%% Using correct method
switch (method)
    case 'leap frog'
        H(1,:) = H(1,:)-B;
        H = leap_frog_BC(H,B,x,Q,M,N,k,h,countdown);
    case 'full discretization'
        H = fullDiscretization(H',Q',M,N,tEnd,countdown)';
    case 'richtmeyer'
        H(1,:) = H(1,:)-B;
        H = richtmeyer_BC_grunn(H,B,x,Q,M,N,k,h,countdown);
    case 'lax friedrich'
        H(1,:) = H(1,:)-B;
        H = lax_Friedrich_grunn(H,B,x,Q,M,N,k,h,countdown);
    case 'lax wendroff'
        [H,~] = Lax_Wendroff_lin(H,Q,M,N,k,h,x,countdown);
    case 'analytic'
        [H,~] = bolge(x,tEnd);
    otherwise
        disp('There exist no such method!')
        return
end

%% Plotting if specified

if (plotOrNot)
    figure
    s = size(H);
    maxY = max(max(H+ones(s(1),1)*B));
    timeLoop = 0.06; % Bigger number gives faster plot and vica verca
    steps = tEnd/timeLoop;
    for i = 1:round(N/steps):N
        plot(x,H(i,:)+B); %Plot wave
        hold on
        if strcmp(method,'lax friedrich')
            ylim([min(min(H(1,:))),max(max(H(1,:)))])
            [H2,~] = bolge(x,tEnd/N*i);
            plot(x,H2) % Plot exact solution
        else
            ylim([min(B)-0.05,maxY+0.5]); % Consistent height, some free space
        end
        xlim([x0,xEnd]); % Consistent width
        plot(x,B); % Plot sea bed
        F = getframe;
        hold off
    end
end
end

function B = bottom(x,widthOfBump)
    B = zeros(1,length(x));
    for i = 1:length(x)
        if x(i) >= -widthOfBump && x(i) <= widthOfBump
            B(i) = 1/3*(cos(x(i)*2*pi/(2*widthOfBump))+1);
        end
    end
end