classdef RRTAlgorithm < Algorithm
    % Defines the RRT algorithm in the program.
    
    methods
        
        function obj = RRTAlgorithm(map, stats)
            % Calls superclass constuctor
            obj = obj@Algorithm(map, stats, "RRT");
        end
        
        function found_path = run(obj, drawEveryStep, pauseEveryStep)
            % Runs the RRT Algorithm and returns the end position.
            
            tree = RRTNodeTree(obj, obj.map);  % Create a queue
            cur_pos = obj.carToStartingPosition();  % Get the starting position
            tree.addPosition(cur_pos)  % Add the starting position to the queue
            
            while (~obj.map.check_if_end())  %  While path not found
                random_point = SmartRandomPoint(obj.map);  % Generate a random point
                close_node = tree.getNearPosition(random_point);  % Get the closest tree node
                close_node.teleport()  % Teleport the car to the closest node in the tree
                obj.stepTowardsPoint(random_point, close_node)  % Move the car one step towards the random point
                cur_pos = obj.carToPosition(close_node);  % Saves the current position of the car
                cur_pos.teleport();
                
                if (~obj.map.checkDead())
                    tree.addPosition(cur_pos)  % Save the new position in the tree!

                    if (drawEveryStep == true)
                        hold off
                        obj.map.show_path(cur_pos);
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
            
            found_path = cur_pos;  % Return the final path
            disp("Path Found!")
            
            obj.map.show_path(cur_pos);

        end
    end
    
    methods (Access = protected)
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
                
                curDistance = obj.twoNodesDistance(point, newPos);  % Calculate the current distance from given point
                
                new_positions = [new_positions newPos];  % Save new position in the positions array
                position_distances = [position_distances curDistance];  % Save new distance in the distances array
            end
            
            % Teleport to the closest position to the given point
            [~, min_position_index] = min(position_distances);
            new_positions(min_position_index).teleport();  
        end
    end
    
    methods (Static)
        function distance = twoNodesDistance(p1, p2)
            % This function recives two points arrays, when in each point
            % array the first two elements indicates the x and y values of
            % the point, and the last one indicates the rotation of the car
            % in degrees (0-360)
            
            % Convert position object to an array with x, y, and rotation
            % valiues.
            p1 = p1.getPosition();
            p2 = p2.getPosition();
            
            % Calculate the difference
            xy_vector = p1(1:2)-p2(1:2);
            rotation = mod(p1(3)-p2(3), 360);
            
            % deal with rotations over 180, when the shortest path
            % may cross 360 degrees
            if (rotation > 180)
                rotation = 180 - mod(rotation, 180);
            end
            
            % The rotation strength in relation to the xy strength
            rotation = rotation * 0.125;  
            
            % Calculating the distance using the Pythagorean Theorem
            distance = norm([xy_vector rotation]);
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

