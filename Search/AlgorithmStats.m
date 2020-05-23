classdef AlgorithmStats < handle
    % ALGORITHMSTATS Records and displays stats about every search
    % algorithm.
    
    properties (Access = protected)
        algorithm  % Saves the running algorithm
        timer  % Used with the tic toc command
        is_running = false;  % boolean: true if the method "search" is running
    end
    
    methods

        function startRecord(obj, algorithm)
            % Called before starting a search. Resets the counters and
            % starts the timer.
            obj.algorithm = algorithm;
            obj.is_running = true;
            obj.timer = tic();
        end
            
        function stopRecord(obj, drawEveryStep)
            % Called when the search is over. indecates that
            % the search was stopped was completed successfully.
            
            if (obj.is_running)
                obj.timer = toc(obj.timer);
                obj.is_running = false;

                % Prints the stats of a successful search.
                disp(obj.algorithm.getAlgorithmName() + " complete!")
                disp(" - Every Step Drawing: " + drawEveryStep)
                disp(" - Time: " + obj.timer)
                
            end
            
        end
        
    end

end

