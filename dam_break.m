function h = dam_break(x)
p = 4;
h = zeros(1,length(x));
    for i = 1:length(x)
        if x(i) < p
            h(i) = 2+1;
        elseif x(i)>=p && x(i)<=p+1
            h(i) = 1/2*cos(pi*(x(i)-p))+1.5+1;
        else
            h(i) = 1+1;
        end
    end
end