% start.m
% @author Saeed Motedaveli

clc;

% [Fingilish]: ebteda dade ha meghdar dehi mishavand. in kar az tarigh
% m.file "input_data.m" anjam mishavad:
input_data();

% Power Matrix
P = zeros(1, num);

% Lambda Matrix
lambda_final = zeros(1, num);

% [Finglish]: barrasi dadehaye voroodi: dar soorati ke tavan mored niaz
% kamtar az min haye niroogah ha bashad, niroogah ha dar min tavan kar
% khahand kard va bel'ax:
isPrLessThanMinOrMax = 0;
P_max = 0;
P_min = 0;
for i = 1 : num
    P_min = P_min + eval(['p', int2str(i), '(1);']);
    P_max = P_max + eval(['p', int2str(i), '(length(p', int2str(i), '));']);
end

if Pr <= P_min
    isPrLessThanMinOrMax = 1;
    for i = 1 : num
    P(i) = eval(['p', int2str(i), '(1);']);
    lambda_final(i) = eval(['lambda', int2str(i), '(1);']);
    end
    
elseif Pr >= P_max
    isPrLessThanMinOrMax = 1;
    for i = 1 : num
    P(i) = eval(['p', int2str(i), '(length(p', int2str(i), '));']);
    lambda_final(i) = eval(['lambda', int2str(i), '(length(p', int2str(i), '));']);
    end
end

% [Finglish]: analize dade hye voroodi:
if ~isPrLessThanMinOrMax
    power_progress();
    
    % Final Check
    final_check();
end

% [Finglish]: rasm nemoodar
for i =  1 : num
    subplot(1, num, i);
    plot(eval(['p', int2str(i)]), eval(['lambda', int2str(i)]));
    title(['P', int2str(i),' = ', num2str(P(i))]);
    xlabel('P (MW)');
    ylabel('λ');
    ylim([plot_min_y plot_max_y]);
    xlim([(eval(['p', int2str(i), '(1)']) - 50),(eval(['p', int2str(i), '(length(', 'p', int2str(i),'))']) + 50)]); 
    line([0 P(i)], [lambda_final(i) lambda_final(i)], 'Color','r');
    line([P(i) P(i)], [0 lambda_final(i)], 'Color','r');
end
