classdef RRTAbstractAlgorithm < Algorithm
    % Defines the RRT algorithm in the program.
    
    properties (Constant, Access=private)
       TIMEOUT_IN_SECONDS = 360  % 6 minutes
    end
    
    methods
        
        function statsObj = run(obj, drawEveryStep, pauseEveryStep)
            % Runs the RRT Algorithm and returns the end position.
            
            % Start recording stats
            statsObj = RRTAlgorithmStats(obj);
            statsObj.start_recording()
            
            tree = RRTNodeTree(obj, obj.map);  % Create a queue
            cur_pos = obj.carToStartingPosition();  % Get the starting position
            tree.addPosition(cur_pos)  % Add the starting position to the queue
            is_dead = obj.map.checkDead();

            run_timer = tic;
            path_found = true;
            
            while (~(obj.map.check_if_end() && ~is_dead))  %  While path not found
                
                if (toc(run_timer) > obj.TIMEOUT_IN_SECONDS)
                    % Timeout - path not found!
                    path_found = false;
                    break
                end
                
                random_point = obj.generateRandomPoint();  % Generate a random point
                random_point.generate();
                close_node = tree.getNearPosition(random_point);  % Get the closest tree node
                close_node.teleport()  % Teleport the car to the closest node in the tree
                obj.stepTowardsPoint(random_point, close_node)  % Move the car one step towards the random point
                cur_pos = obj.carToPosition(close_node);  % Saves the current position of the car
                cur_pos.teleport();
                
                is_dead = obj.map.checkDead();
                if (~is_dead)
                    tree.addPosition(cur_pos)  % Save the new position in the tree!

                    if (drawEveryStep == true)
                        hold off
                        obj.map.show_path(cur_pos, statsObj);
                        hold on
                        random_point.plot();
                    
                    elseif (drawEveryStep == 'd')  % debug mode
                        tree.show_debug_fig(random_point)
                    end
                    
                    if pauseEveryStep
                        pause
                    end
                    
                end
            end
            
            if path_found
                path_obj = obj.map.get_path(cur_pos);
            else
                path_obj = NaN;
            end
            
            % Stops recording stats
            statsObj.stop_recording(path_obj, tree)
            
            obj.map.show_path(cur_pos, statsObj);
            obj.map.teleportToStart()
 
        end
    end
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = RandomPoint(obj.map);
        end
        
        function stepTowardsPoint(obj, point, curPos)
            % Move the car one step towards the given point.
            
            moves = obj.driver.getDirectionNames();  % Possible moves
            
            new_positions = [];
            position_distances = [];
            
            % for each possible move, move forward and save the new
            % position and distance from the given point
            for move_i=1:length(moves)
                curPos.teleport()
                move = moves{move_i};  % Get current move
                
                [x_steps, y_steps] = obj.driver.getDirection(move).move();  % move in the current position
                newPos = obj.carToPosition(curPos);  % Save the new position with a pointer to the last one
                newPos.set_small_steps(x_steps, y_steps)  % Saves all of the curve vertices
                
                curDistance = obj.map.twoNodesDistance(point.getPosition(), newPos.getPosition());  % Calculate the current distance from given point
                
                new_positions = [new_positions newPos];  % Save new position in the positions array
                position_distances = [position_distances curDistance];  % Save new distance in the distances array
            end
            
            % Teleport to the closest position to the given point
            [~, min_position_index] = min(position_distances);
            new_positions(min_position_index).teleport();  
        end
    end

    methods (Access = private)
        function position = carToStartingPosition(obj)
            % Returns a "CarSearchPosition" object that contains the current
            % position of the car, without lastPos.
            position = obj.carToPosition();
        end
        
        function position = carToPosition(obj, lastPos)
            % Returns an "CarSearchPosition" object that contains
            % the current position of the car.
            
            position = CarCurvedSearchPosition(obj.map.getCar());

            % If lastPos is given
            if (nargin >= 2)
                position.setLastPos(lastPos)  % Saves the lastPos
            end
        end
    end
    
end

