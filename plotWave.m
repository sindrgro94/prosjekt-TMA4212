function plotWave(H,x,t)
x0 = min(x);
xend = max(x);
y0 = 0;
yend = max(max(H));
N = length(t);
figure
for i = 1:ceil(N/100):N
    %clf
    ax = axes ();
    area(ax,x,H(:,i));
    ylim([y0,yend+1]); 
    xlim([x0,xend]);
    axis manual;
    F = getframe;
 end

end