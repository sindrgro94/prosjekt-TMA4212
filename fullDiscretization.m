function fullDiscretization(M,N)
    % Solving AX = B
    x0 = -20;
    xend = 20;
    t0 = 0;
    tend = 30;
    u0 = 0;
    uend = 0;
    h0 = 1;
    hend = 1;
    g = 9.81;
    x = linspace(x0,xend,M+2);
    t = linspace(t0,tend,N+1);
    b = (xend-x0)/(M+1);
    k = (tend-t0)/N;
    B = zeros(2*M,1);
    uPrev = zeros(M,1);
    hPrev = makeH0(M,x);
    %hPrev = dam_break(x(2:end-1))';
    if length(hPrev) == 1
        return;
    end
    e = ones(M,1);
    X = zeros(2*M,N+1);
    X(1:M,1) = uPrev;
    X(M+1:2*M,1) = hPrev;
    for time = 2:N+1
        uLeft = spdiags([k*hPrev, 0*e, -k*hPrev],-1:1,M,M)';
        uRight = spdiags([k*uPrev,2*b*e,-k*uPrev],-1:1,M,M)';
        lLeft = spdiags([k*hPrev.*uPrev,2*b*hPrev, -k*hPrev.*uPrev],-1:1,M,M)';
        lRight = spdiags([k*g*hPrev,0*e, -k*g*hPrev],-1:1,M,M)';
        A = [uLeft, uRight; lLeft, lRight];
        B(1) = 2*b*hPrev(1)+k*hPrev(1)*u0+k*uPrev(1)*h0;
        B(2:M-1) = 2*b*hPrev(2:M-1);
        B(M) = 2*b*hPrev(M)-k*hPrev(M)*uend-k*uPrev(M)*hend;
        B(M+1) = 2*b*hPrev(1)*uPrev(1)+k*hPrev(1)*uPrev(1)*u0+k*g*hPrev(1)*h0;
        B(M+2:2*M-1) = 2*b*hPrev(2:M-1).*uPrev(2:M-1);
        B(2*M) = 2*b*hPrev(M)*uPrev(M)-k*hPrev(M)*uPrev(M)*uend-k*g*hPrev(M)*hend;
        X(:,time) = A\B;
        uPrev = X(1:M,time);
        hPrev = X(M+1:2*M,time);
        %Tolkning fra halvors kode: Dette er hvertfall ikke likt, men
        %skj?nte ikke helt hva som skjedde.
        h0 = hPrev(1);
        hend = hPrev(end);
        u0 = -uPrev(1);
        uend = -uPrev(end);
    end
%     plotWave(X(M+1:2*M,:),x(2:M+1),t);
    figure
    for i = 1:ceil(N/300):N
        plot(x(2:M+1),X(M+1:2*M,i));
        ylim([0.5,1.5]); 
        xlim([x0,xend]);
        F(i) = getframe;
     end
end
function h = makeH0(M,x)
    h0 = @(x) 1+1/3*exp(-1/2*(x).^2/0.1);
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