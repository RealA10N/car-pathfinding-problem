classdef AlgorithmStats < handle
    % ALGORITHMSTATS Records and displays stats about every search
    % algorithm.
    
    properties (Access = protected)
        algorithm  % Saves the running algorithm
        is_running = false;  % boolean: true if the method "search" is running
        
        
        timer  % Used with the tic toc command
        drawingEveryStep  % boolean: true if the algorithm draws itself every step
        queueObj  % A queue object that contains all of the points in the search (pointer)
        steps  % the number of steps in the final path
        euclidean_distance  % the distance of the found path in euclidean form
    end
    
    methods (Access = private)
        
        function printAlgorithmStats(obj, path_found)
            % Prints the statistics of the given statsObj.
            
            if (path_found)
                disp(obj.algorithm.getAlgorithmName() + " complete!")
                disp(" - Final path steps: " + obj.steps)
                disp(" - Final path euclidean distance: " + obj.euclidean_distance)
            else
                disp(obj.algorithm.getAlgorithmName() + " didn't find a path.")
            end
            
            disp(" - Every step drawing: " + obj.drawingEveryStep)
            disp(" - Time: " + AlgorithmStats.timeToString(obj.timer))
            disp(" - Fully explored positions: " + obj.queueObj.getPulledCount())
            
        end
        
    end
    
    methods (Access = private, Static)
    
        function str = timeToString(timeInSeconds)
            % Gets a time in seconds, and returns a string that represents
            % the given time. for exmaple: "33 seconds" or "1 minute and 33 seconds"
            
            % generate seconds only time
            str = mod(round(timeInSeconds), 60) + " seconds";
            
            % generate minutes only time
            if (timeInSeconds >= 60)
                minutes = floor(round(timeInSeconds)/60);
                str = mod(minutes, 60) + " minutes and " + str;
            end
            
            % generate hours only time
            if (timeInSeconds >= 60*60)
                hours = floor(round(timeInSeconds)/(60*60));
                str = hours + " hours, " + str;
            end
            
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
            
        function stopRecord(obj, path_found)
            % Called when the search is over. indecates that
            % the search was stopped was completed successfully.
            
            if (nargin < 2)
                path_found = true;  % assumes that found a path
            end
            
            if (obj.is_running)
                obj.timer = toc(obj.timer);
                obj.is_running = false;

                % Prints the stats of a successful search
                obj.printAlgorithmStats(path_found)
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
            obj.euclidean_distance = 0;
            
            position_before = position;
            while(position.ifLastPosition())
                
                % Go back one position
                position = position.lastPos;  
                
                % Calculate the euclidean distance between current and
                % last point
                curxy = position.getPosition();
                lastxy = position_before.getPosition();
                curxy = curxy(1:2);   % Remove the rotation from the position
                lastxy = lastxy(1:2);
                curdistance = norm(curxy - lastxy);
                obj.euclidean_distance = obj.euclidean_distance + curdistance;
                
                % Update counters
                obj.steps = obj.steps + 1;
                
                % Set the last position to the current one
                position_before = position;
            end
                        
        end
        
    end

end

