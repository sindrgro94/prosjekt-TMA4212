%% dam_break_ploter
clear all
close all
clc
method = 'lax friedrich';
[Ht,Bt,~] = dam_break_solver(true,method);
[Hf,Bf,x] = dam_break_solver(false,method);
[N,~] = size(Hf);
figure
for i = 1:round(N/300):N
    plot(x,Ht(i,:)+Bt,'r'); %Plot wave
    hold on
    plot(x,Hf(i,:)+Bf,'b'); %Plot wave
    plot(x,Bt,'r'); %sea bed
    plot(x,Bf,'b');
    ylim([0,2])
    xlim([0,x(end)]); % Consistent width
    hold off
end
%% make subplot
fig = figure;
time = [1 round(N/7) round(N/4)];
for i = 1:3
    subplot(1,3,i)
    plot(x,Ht(time(i),:)+Bt,'r'); %Plot wave
    hold on
    plot(x,Hf(time(i),:)+Bf,'b'); %Plot wave
    plot(x,Bt,'r'); %sea bed
    plot(x,Bf,'b'); 
    ylim([0,2])
    xlim([0,x(end)]); % Consistent width
    legend('uneven sea-bed','flat sea-bed')
    set(gca,'fontsize',18)
    hold off
    if i == 2
        title('Dam break')
    end
end
% saveTightFigure(fig,'Figurer/figureName.pdf');