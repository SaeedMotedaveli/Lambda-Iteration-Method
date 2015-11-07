% power_progress.m
% @author Saeed Motedaveli (9415624)

lambda_min_max = zeros(num, 2);

% Calculate min and max of lambda of every power station
for i = 1 : num
    lambda_min_max(i, 1) = eval(['lambda', int2str(i), '(1);']);
    lambda_min_max(i, 2) = eval(['lambda', int2str(i), '(length(', 'lambda', int2str(i),'));']);
end

plot_min_y = min(lambda_min_max(:, 1));
plot_max_y = max(lambda_min_max(:, 2));
delta_y = (plot_max_y - plot_min_y) / 10;
plot_min_y = plot_min_y - delta_y;
plot_max_y = plot_max_y + delta_y;

% [Fingilish!!!]: mahdude ba'zi az matris landa ha ba digar anha hampushani
% nadarand. min in matris landa ha bishtar az max sayerein mibashad va ya
% bel'ax. hadaf shanasayie in niroogaha ast.
lambda_exp = calculate_exp_min_max(lambda_min_max);

% delete rows that lambda_exp > 0
i = 1;
j = 1;
while i <= length(lambda_min_max)
    
    if lambda_exp(j) == lambda_min_max(i,1)
        lambda_min_max(i,:) = [];
        eval(['P(', int2str(j), ') = p', int2str(j), '(1);']);
    elseif lambda_exp(j) == lambda_min_max(i,2)
        lambda_min_max(i,:) = [];
        eval(['P(', int2str(j), ') = p', int2str(j), '(length(', 'p', int2str(j),'));']);
    else
        i = i + 1;
    end
    
    j = j + 1;
    
end

% Calculate Powers : Step 1
lambda = max(lambda_min_max(:, 1));
step = 1;
calculate_power();

% Calculate Powers : Step 2
lambda = min(lambda_min_max(:, 2));
step = 2;
calculate_power();

% more steps
err = 0.01;
err_old = 0;
step = 3;

while abs(Pr - power_sum) > err
   
    % calculate lambda
    lambda = double(solve(poly2sym(polyfit([lambda_eps_odd(1) lambda_eps_even(1)], [lambda_eps_odd(2) lambda_eps_even(2)], 1), x) == 0, x));        
    calculate_power();
    
     if step > 3 &&  floor((abs(Pr - power_sum) / err) * 10) >= floor((err_old / err) * 10)
        break;
    end
    
    err_old = abs(Pr - power_sum);
    step = step + 1;
end
