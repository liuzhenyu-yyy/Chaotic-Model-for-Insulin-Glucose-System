function Bifurcation(which, from, to, step, initial_loc, N_peroid, p)
% construct bifurcation diagram for certain parameter
    options = odeset('RelTol',1e-5); 
    figure;

    for a = from:step:to
        str=['current value of a is '  num2str(a)];
        disp(str);
        p_temp = p;
        p_temp(which) = a;
        [t_temp,loc_temp] = ode45(@Derivative, [0:0.001:100], initial_loc, options, p_temp);
        record = loc_temp(end-N_peroid+1:end,1);
        % time  = t_temp(end-N_peroid+1:end,1);
        % plot(time, record)
        record = findpeaks(record);
        % disp(size(record,1));
        plot(ones(1,size(record,2))*a, record, '.k', 'markersize', 1); 
        hold on; 
    end 
    
    title(['Bifurcation Diagram of a_'  num2str(which)]); 
    xlabel(['a_'  num2str(which)]);  
    ylabel('X_m_a_x'); 