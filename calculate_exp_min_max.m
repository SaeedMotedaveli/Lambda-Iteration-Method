% calculate_exp_min_max.m
% @author Saeed Motedaveli (9415624)

function exp_matrix = calculate_exp_min_max(min_max)
% Compare max with min
% Check this: (max > min) and (min < max)
% if max < min => exp_matrix[i] = max
% if min > max => exp_matrix[i] = min

exp_min = zeros(1, length(min_max));
exp_max = zeros(1, length(min_max));
exp_matrix = zeros(1, length(min_max));

for i = 1 : length(min_max)
    for j = 1 : length(min_max)
        if min_max(i, 2) < min_max(j, 1)
            exp_min(i) = min_max(i, 2);
            break;
        end
        
    end
    
    for j = 1 : length(min_max)
        if min_max(i, 1) > min_max(j, 2)
            exp_max(i) = min_max(i, 1);
            break;
        end
    end
end

for i = 1 : length(exp_min)
    if  exp_min(i) * exp_max(i) == 0
        exp_matrix(i) = exp_min(i) + exp_max(i);
    end
end

isAllArgExist = 1;
for  i = 1 : length(exp_matrix)
    isAllArgExist = isAllArgExist * (exp_matrix(i) > 0);
end

if isAllArgExist
    
    zeros_of_max = 0;
    for i = 1 : length(exp_max)
        if exp_max(i) == 0
            zeros_of_max = zeros_of_max + 1;
        end
    end
    
    zeros_of_min = 0;
    for i = 1 : length(exp_min)
        if exp_min(i) == 0
            zeros_of_min = zeros_of_min + 1;
        end
    end
    
    if zeros_of_max > zeros_of_min
        exp_matrix = exp_max;
    else
        exp_matrix = exp_min;
    end
    
end
