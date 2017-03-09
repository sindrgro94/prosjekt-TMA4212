function init = dam_break(x)
    init = zeros(1,length(x));
%     dam = ceil(length(x)/4);
%     elv = length(x)-dam;
    
    init(1:5) = 0.5*cos(pi*x(1:5)/5)+1;
    init(6:100) = 1;
end