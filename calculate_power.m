% calculate_power.m
% @author Saeed Motedaveli (9415624)

% this m.file calculate power of every power station and print it.
syms x;
fprintf([int2str(step), '.\n']);

for i = 1 : num
    if lambda_exp(i) > 0
        fprintf('   P%d = %0.4f,    λ = %0.4f\n', i, P(i), lambda_exp(i));
        lambda_final(i) = lambda_exp(i);
        continue;
    end
    
    if lambda <= eval(['lambda', int2str(i), '(1);'])
        eval(['P(', int2str(i), ') = p', int2str(i), '(1);']);
        eval(['lambda_final(', int2str(i), ') = lambda', int2str(i), '(1);']);
    elseif lambda >= eval(['lambda', int2str(i), '(length(', 'lambda', int2str(i),'));'])
        eval(['P(', int2str(i), ') = p', int2str(i), '(length(', 'p', int2str(i),'));']);
        eval(['lambda_final(', int2str(i), ') = lambda', int2str(i), '(length(', 'lambda', int2str(i),'));']);
    else
        
         lambda_final(i) = lambda;
        arg = 2;
        for j = 2 : eval(['length(lambda', int2str(i), ')'])
            if lambda < eval(['lambda', int2str(i), '(', int2str(j), ')'])
                arg = j;
                break;
            end
        end
        
        eq = char(poly2sym(polyfit([eval(['p', int2str(i), '(', int2str(arg - 1), ')']) eval(['p', int2str(i), '(', int2str(arg), ')'])], [eval(['lambda', int2str(i), '(', int2str(arg - 1), ')']), eval(['lambda', int2str(i), '(', int2str(arg), ')'])], 1)));
        eval(['P(', int2str(i), ') = solve(', eq, ' == ', num2str(lambda), ', x);']);
    end
    
    fprintf('   P%d = %0.4f\n', i, P(i));
end

power_sum = sum(P(1, :));

if mod(step,2) == 1
        lambda_eps_odd = [lambda (Pr - power_sum)];
        fprintf('------------------------------------------\n   ∑P = %0.4f\n   ε = %0.4f\n   λ = %0.4f\n\n', power_sum, lambda_eps_odd(2), lambda);
    else
        lambda_eps_even = [lambda (Pr - power_sum)];
        fprintf('------------------------------------------\n   ∑P = %0.4f\n   ε = %0.4f\n   λ = %0.4f\n\n', power_sum, lambda_eps_even(2), lambda);
end
