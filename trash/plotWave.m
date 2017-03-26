function plotWave(H,x,t,B)
x0 = min(x);
xend = max(x);
y0 = 0;
yend = max(max(H));
time = t(end);
N = length(t);
figure
%X=[x,fliplr(x)];                %#create continuous x value array for plotting
%Y=[y1,fliplr(y2)];              %#create y values for out and then back
%fill(X,Y,'b');
for i = 1:ceil(N/100):N
%     X=[B(x),fliplr(B(x))];
%     h = [H(i,:),fliplr(H(i,:))];
%     fill(X,h,'b');
    ax = axes();
    area(ax,x,H(i,:));
    ylim([y0,yend+1]); 
    xlim([x0,xend]);
    axis manual;
    F(i) = getframe;  % capture it
    pause(time/(15*N)-0.03);
 end

end