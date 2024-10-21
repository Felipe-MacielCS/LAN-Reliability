%% Script mainScript to run runSingleLinkSim.m() Function.
%
% Parameters:
% Ks - array for the number of packets(K)
% N - the number of simulations for each K
% p_vals - array of probabilities of failure for each transmission
% colors - array of colors for plot in Ks values
%
% Output: 
% Plots (Graphs) showing the calculated and simulated number of transmissions for different values of K and p
% - Individual plots for each K
% - Combined plot for all K values
%

% Define parameters
Ks = [1, 5, 15, 50, 100]; 
N = 1000; 
p_vals = 0:0.01:0.99; 
colors = ['r', 'g', 'b', 'm', 'c']; 

% Tracking of calculated and simulated results
calculated_results = zeros(length(Ks), length(p_vals)); 
simulated_results = zeros(length(Ks), length(p_vals)); 

% For loop for each value of K 
for k_idx = 1:length(Ks)
    K = Ks(k_idx); % Current value in the array
    
    % For loop through for each value of p
    for p_idx = 1:length(p_vals)
        p = p_vals(p_idx); % Get the current value of p
        
        simulated_result = runSingleLinkSim(K, p, N); % Simulated average transmissions
        simulated_results(k_idx, p_idx) = simulated_result; % Store simulated result
        
        % Calculate the theoretical expected result using geometric distribution formula
        % Formula: K / (1 - p), where (1 - p) is the probability of success
        calculated_results(k_idx, p_idx) = K / (1 - p); % Expected number of transmissions
    end
    
    % Plot the results for the current value of K
    % Plotting:
    % p_vals - x-axis, represents failure probabilities
    % calculated_results - y-axis for calculated transmissions (solid line)
    % simulated_results - y-axis for simulated transmissions (circles)
    figure;
    semilogy(p_vals, calculated_results(k_idx,:), colors(k_idx), 'LineWidth', 2); % Plot calculated results (solid line)
    hold on;
    semilogy(p_vals, simulated_results(k_idx,:), [colors(k_idx), 'o'], 'MarkerSize', 5, 'MarkerFaceColor', colors(k_idx)); % Plot simulated results (circles)
    title(['Transmissions for K = ', num2str(K)]); % Title for the plot
    xlabel('Failure probability (p)'); % Label for x-axis
    ylabel('Average number of transmissions'); % Label for y-axis
    legend('Calculated', 'Simulated'); % Add legend to differentiate calculated and simulated results
    grid on; % Add grid for better visualization
    set(gca, 'YScale', 'log'); % Set y-axis to a logarithmic scale for better readability
    hold off; % Stop adding to the current plot
end

figure;
for k_idx = 1:length(Ks)
    % Plot calculated results for each K value (solid lines)
    semilogy(p_vals, calculated_results(k_idx,:), colors(k_idx), 'LineWidth', 2); 
    hold on;
    % Plot simulated results for each K value (hollow circles)
    semilogy(p_vals, simulated_results(k_idx,:), [colors(k_idx), 'o'], 'MarkerSize', 5, 'MarkerFaceColor', colors(k_idx)); 
end
xlabel('Failure probability (p)'); % Label for x-axis
ylabel('Average number of transmissions'); % Label for y-axis
legend('K=1 (Calc)', 'K=1 (Sim)', 'K=5 (Calc)', 'K=5 (Sim)', 'K=15 (Calc)', 'K=15 (Sim)', ...
    'K=50 (Calc)', 'K=50 (Sim)', 'K=100 (Calc)', 'K=100 (Sim)'); % Create a legend for all K values
set(gca, 'YScale', 'log'); % Set y-axis to logarithmic scale
grid on; % Add grid for better visualization
hold off; % Stop adding to the current plot

