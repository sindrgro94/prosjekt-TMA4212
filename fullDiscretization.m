function fullDiscretization(M,N)
    % Solving AX = b
    x0 = -5;
    xend = 5;
    t0 = 0;
    tend = 1;
    u0 = 0;
    uend = 0;
    h0 = 1;
    hend = 1;
    g = 9.81;
    x = linspace(x0,xend,M+2);
    t = linspace(t0,tend,N+1);
    b = (xend-x0)/(M+1);
    k = (tend-t0)/N;
    uPrev = zeros(M,1);
    hPrev = makeH0(M,x);
    e = ones(M,1);
    X = zeros(2*M,N+1);
    X(1:M,1) = uPrev;
    X(M+1:2*M,1) = hPrev;
    for time = 2:N+1
        uLeft = spdiags([k*hPrev, 0*e, -k*hPrev],-1:1,M,M)';
        uRight = spdiags([k*uPrev,2*b*e,-k*uPrev],-1:1,M,M)';


    end
end
function h = makeH0(M,x)
    h0 = @(x) 1+1/5*exp(-1/2*(x).^2/0.1);
    if M>=20
       h = ones(M,1); 
       hstart = round(M/2-M/5);
       hend = round(M/2+M/5);
       h(hstart:hend,1) = h0(x(hstart:hend));
    else
        disp('Use h larger or equal than 20!')
        h = 1;
    end
end