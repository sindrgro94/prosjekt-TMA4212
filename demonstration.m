%% Demonstration
choice = 2;
while choice ~= 1 
    choice = menu('What do you want to do?','End demonstration','Plot a wave',...
        'Plot numerical vs analytical solution','Plot dam break with flat and uneven sea-bed');
    switch choice
        case 2
            H = menu('Choose initial start height','Wavetop center','Wavetop shifted','Analytic wave');
            switch H
                case 1
                    h0 = 'wavetop';
                case 2
                    h0 = 'wavetop shifted';
                case 3
                    h0 = 'approx';
            end
            B = menu('Choose sea-bed','flat','uneven');
            switch B
                case 1
                    seaBed = 'none';
                case 2
                    seaBed = 'cosine in middle';
            end
            method = menu('Choose your method','Leap frog','Full discretization','Richtmyer',...
                'Lax Friedrich','Lax Wendroff','Analytic');
            switch method
                case 1
                    if B == 2
                        disp('Leap frog is not implemented with uneven sea-bed')
                        break
                    end
                    method = 'leap frog';
                case 2
                    if B == 2
                        disp('Full discretization is not implemented with uneven sea-bed')
                        break
                    end
                    method = 'full discretization';
                case 3
                    method = 'richtmeyer';
                case 4
                    method = 'lax friedrich';
                case 5
                    if B == 2
                        disp('Lax Wendroff is not implemented with uneven sea-bed')
                        break
                    end
                    method = 'lax wendroff';
                case 6
                    if H == 3 && B == 1
                        method = 'analytic';
                    else
                        disp('Analytic solver can not solve this case');
                        break;
                    end
            end
            solveWave(100, 5000, -5, 5 , 2 , method, seaBed,h0, true,true);
        case 3
            numericalVSanalytic
            choice = 2;
        case 4
            dam_break_ploter
            choice = 2;
    end
end