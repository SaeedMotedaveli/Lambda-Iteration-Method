% final_check.m
% @author Saeed Motedaveli

if (power_sum + err) < Pr
    arg = 0;
    for i = 1 : num
        if P(i) == eval(['p', int2str(i), '(1)'])
            arg = i;
            break;
        end
    end
    
    delta_power = (Pr - power_sum) + eval(['p', int2str(arg), '(1)']);
    for i = 1 : eval(['p', int2str(arg), '(length(p', int2str(arg), '));'])
        if delta_power < eval(['p', int2str(arg), '(', int2str(i), ')'])
            break;
        end
    end
    
    P(arg) = delta_power;
    lambda_final(arg) =  polyval(polyfit([eval(['p', int2str(arg), '(', int2str(i - 1), ')']) eval(['p', int2str(arg), '(', int2str(i), ')'])], [eval(['lambda', int2str(arg), '(', int2str(i - 1), ')']), eval(['lambda', int2str(arg), '(', int2str(i), ')'])], 1), delta_power);
    
end

if (power_sum - err) > Pr
    arg = 0;
    for i = 1 : num
        if P(i) == eval(['p', int2str(i), '(length(p', int2str(i), '))'])
            arg = i;
            break;
        end
    end
    
    delta_power = Pr - (power_sum - eval(['p', int2str(arg), '(length(p', int2str(arg),'))']));
    for i = 1 : eval(['p', int2str(arg), '(length(p', int2str(arg), '));'])
        if delta_power < eval(['p', int2str(arg), '(', int2str(i), ')'])
            break;
        end
    end
    
    P(arg) = delta_power;
    lambda_final(arg) =  polyval(polyfit([eval(['p', int2str(arg), '(', int2str(i - 1), ')']) eval(['p', int2str(arg), '(', int2str(i), ')'])], [eval(['lambda', int2str(arg), '(', int2str(i - 1), ')']), eval(['lambda', int2str(arg), '(', int2str(i), ')'])], 1), delta_power);
    
end
