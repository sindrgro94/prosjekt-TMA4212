function dam_break_ploter()
[Ht,Bt,~] = dam_break_solver(true);
[Hf,Bf,x] = dam_break_solver(false);
[N,~] = size(Hf);
figure
    for i = 1:round(N/300):N
        plot(x,Ht(i,:)+Bt); %Plot wave
        hold on
        plot(x,Hf(i,:)+Bf); %Plot wave
        plot(x,Bf);
        plot(x,Bt); %sea bed
        ylim([0,2])
        xlim([0,x(end)]); % Consistent width
        F = getframe;
        hold off
    end
end