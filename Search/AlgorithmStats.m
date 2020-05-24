classdef AlgorithmStats < handle
    % ALGORITHMSTATS Records and displays stats about every search
    % algorithm.
    
    properties (Access = protected)
        algorithm  % Saves the running algorithm
        is_running = false;  % boolean: true if the method "search" is running
        
        
        timer  % Used with the tic toc command
        drawingEveryStep  % boolean: true if the algorithm draws itself every step.
        queueObj  % A queue object that contains all of the points in the search (pointer)
        steps  % the number of steps in the final path
    end
    
    methods (Access = private)
        
        function printAlgorithmStats(obj)
            % Prints the statistics of the given statsObj.
            
            disp(obj.algorithm.getAlgorithmName() + " complete!")
            disp(" - Every step drawing: " + obj.drawingEveryStep)
            disp(" - Time: " + obj.timer)
            disp(" - Fully explored positions: " + obj.queueObj.getPulledCount())
            disp(" - Final path steps: " + obj.steps)
        end
    end
    
    methods

        function startRecord(obj, algorithm)
            % Called before starting a search. Resets the counters and
            % starts the timer.
            obj.algorithm = algorithm;
            obj.is_running = true;
            obj.timer = tic();
        end
            
        function stopRecord(obj)
            % Called when the search is over. indecates that
            % the search was stopped was completed successfully.
            
            if (obj.is_running)
                obj.timer = toc(obj.timer);
                obj.is_running = false;

                % Prints the stats of a successful search
                obj.printAlgorithmStats()
            end
            
        end
        
        function setQueue(obj, queueObj)
            % Sets the queue of the search, and saves a pointer to it.
            obj.queueObj = queueObj;
        end
        
        function setDrawEveryStep(obj, boolean)
            % Saves a boolean that indecats if the search draws every step
            % in it or not.
            obj.drawingEveryStep = boolean;
        end
        
        function setEndPosition(obj, position)
            % Updates the path's equlidean and regular step lengths.
            
            obj.steps = 0;
            % euclidean_path = 0;
            
            while(position.ifLastPosition())
                position = position.lastPos;
                position.teleport;
                
                obj.steps = obj.steps + 1;
            end
                        
        end
        
        
    end

end

