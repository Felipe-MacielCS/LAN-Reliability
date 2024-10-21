%% Function runSingleLinkSim()
% Parameters
% K - the number of packets in the application message
% p - the probability of failure
% N - the number of simulations to run
%
% Returns: the average numeric result across the total simulations
function result = runSingleLinkSim(K, p, N)
    simResults = ones(1, N); % store the result of each simulation

    for i = 1:N
        txAttemptCount = 0; % transmission count
        pktSuccessCount = 0; % number of packets that have been transmitted

        while pktSuccessCount < K
            r = rand; % generate random number to check if packet is successful
            txAttemptCount = txAttemptCount + 1; % count the first attempt

            % While transmission is unsuccessful (r < p), try again
            while r < p
                r = rand; % generate a new random number for success check
                txAttemptCount = txAttemptCount + 1; % count additional attempts
            end

            pktSuccessCount = pktSuccessCount + 1; % increase success count after successful transmission
        end

        simResults(i) = txAttemptCount; % record the total number of transmissions
    end
    
    result = mean(simResults); % return the average number of transmissions
end
