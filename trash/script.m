x = linspace(0,1,100);
t = linspace(0,10,10000);
h = zeros(length(t),length(x));
for n = 1:length(t)
    for m = 1:length(x)
        h(n,m) = river_sim(x(m),t(n));
    end
end

 for i = 1:100 %
    plot(x,h(i,:));  % plot
    ylim([0,2]); 
    xlim([0,1]); % guarantee consistent height
    F(i) = getframe;  % capture it
 end