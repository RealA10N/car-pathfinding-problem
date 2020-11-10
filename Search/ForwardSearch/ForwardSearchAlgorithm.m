classdef (Abstract) ForwardSearchAlgorithm < Algorithm
    % FORWARDSEARCHALGORITHM defines every forward-search algorithm in the
    % program. read more in the README.md file
    
    methods (Static, Abstract)
        queue = getAlgorithmQueueObj(obj)
    end
    
    methods (Abstract)
        position = carToPosition(obj, lastPos)
        % A method that takes the current car position and returns a
        % position object. If "lastPos" is given, the method will set the
        % methods last position as the given one.
        
        position = carToStartingPosition(obj)
        % A method that takes the current car position and returns a
        % position object, in the form of a starting point (with matching
        % cost, etc.)
    end
    
    methods
        
        function statsObj = run(obj, drawEveryStep, pauseEveryStep)
            % drawEveryStep is a boolean. if contains true, each step in
            % the search will be plotted to the figure. otherwise, you will
            % just see the final path. Returns true if the algorithm found
            % a path, and if not returns false.
            
            % Start recording stats
            statsObj = ForwardSearchAlgorithmStats(obj);
            statsObj.start_recording()
            
            % Create the queue, based on the current algorithm
            queue = obj.getAlgorithmQueueObj();
            
            % Generate start position and add to queue
            startPosition = obj.carToStartingPosition();
            startxyz = startPosition.getPosition();
            obj.map.setstart(startxyz(1), startxyz(2), startxyz(3))
            queue.addPosition(startPosition);
            
            % Save all the possible moving directions of the car
            possible_moves = obj.driver.getDirectionNames();
            
            % Start searching
            while (~queue.isEmpty())
                
                % Pull out the next positin from the queue, mark as visited
                % and teleport the cur to this position.
                curPos = queue.pullOut();
                curPos.markVisited();
                curPos.teleport();
                
                if(obj.map.checkDead())
                    % If the current position is invalid (touches
                    % obstacles or outside of the graph), continue to next
                    % position in the queue.
                    continue;
                end
                
                if (obj.map.check_if_end())
                    % if the goal is reached, which means the search is
                    % over!
                    break;
                end
                
                
                % Add the next moves to the queue.
                for move=1:length(possible_moves)
                    % for every move that the car can move to
                    
                    % Teleport back to the original position
                    curPos.teleport();
                    
                    % move to the next direction
                    curMove = possible_moves{move};
                    [x_steps, y_steps] = obj.driver.getDirection(curMove).move();
                    
                    % Saves the new position, with a pointer to the last
                    % one
                    newPos = obj.carToPosition(curPos);
                    
                    % Saves all of the curve vertices
                    newPos.set_small_steps(x_steps, y_steps)

                    % Adds the new position to the queue
                    queue.addPosition(newPos)
                    
                end
                
                if (drawEveryStep == true)
                    % Draws and plottes the path the car took to drive to
                    % the current position in the search.
                    obj.map.show_path(curPos, statsObj);
                elseif (drawEveryStep == 'd')  % debug mode
                    queue.show_debug_fig(obj.map);
                end
                
                if pauseEveryStep
                    pause
                end
            end
            
            is_path_found = ~queue.isEmpty();
            
            if is_path_found
                path_obj = obj.map.get_path(curPos);
            end
            
            % Stops recording stats, saves and prints them!
            statsObj.stop_recording(path_obj, queue)
            statsObj.print_stats()
                        
            if (is_path_found)
                % Shows the found path
                obj.map.show_path(curPos, statsObj)
                obj.map.teleportToStart()

            else
                obj.map.teleportToStart()
                obj.map.generate()
            end


        end
    
    end
end

