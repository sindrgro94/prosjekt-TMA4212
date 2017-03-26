function [H,B,x] = dam_break_solver(groundFunction,method)
M1 = 1000;
tEnd = 1;
x0=0; 
xEnd = 1;
x = linspace(x0,xEnd,M1);
countdown = true;

switch (groundFunction)
    case true
        widthOfBump = 0.5;
        B = bottom(x,widthOfBump); % See at the bottom of code
    otherwise
        B = zeros(1,length(x)); % Flat sea bed
end
if strcmp(method, 'richtmeyer')
    %% First Lax-Friedrich
    N = 500;
    M1 = 1000;
    x = linspace(x0,xEnd,M1);
    h = x(2)-x(1);
    t = linspace(0,0.01,5000);
    k = t(2)-t(1);
    H1 = zeros(N,M1);
    Q1 = zeros(N,M1);
    H1(1,:) = dam_break2(x)-B;
    [H1,Q1] = lax_Friedrich_grunn(H1,B,x,Q1,M1,N,k,h,countdown);
    %% Second Richtmyer
    N = 10000;
    M2 = 1000;
    H = zeros(N,M2);
    Q = zeros(N,M2);
    if M2 ~= M1
        step = floor(M1/M2); cnt = 1;
        for i = 1:step:length(H1(end,:))
            H(1,cnt) = H1(end,i);
            Q(1,cnt) = Q1(end,i);
            B(cnt) = B(i);
            cnt = cnt+1;
        end
    else
        H(1,:) = H1(end,:);
        Q(1,:) = Q1(end,:);
    end
    x = linspace(x0,xEnd,M2);
    h = x(2)-x(1);
    t = linspace(0.001,tEnd,5000);
    k = t(2)-t(1);
    H = richtmeyer_BC_grunn(H,B,x,Q,M2,N,k,h,countdown);
else 
    N = 5000;
    M1 = 1000;
    x = linspace(x0,xEnd,M1);
    h = x(2)-x(1);
    t = linspace(0,1,N);
    k = t(2)-t(1);
    H1 = zeros(N,M1);
    Q1 = zeros(N,M1);
    H1(1,:) = dam_break2(x)-B;
    [H,Q] = lax_Friedrich_grunn(H1,B,x,Q1,M1,N,k,h,countdown);

end
end

function B = bottom(x,widthOfBump)
    peakPos = 1;
    B = zeros(1,length(x));
    for i = 1:length(x)
        if x(i) >= -widthOfBump+peakPos && x(i) <= widthOfBump+peakPos
            B(i) = 1/5*(cos((x(i)-peakPos)*2*pi/(2*widthOfBump))+1);
        end
    end
end


