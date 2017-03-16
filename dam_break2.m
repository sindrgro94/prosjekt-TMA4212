function H = dam_break2(x)
    for i = 1:length(x)
        if x(i) < 1/2
            H(i) = 1;
        else
            H(i) = 0.5;
        end
    end
end