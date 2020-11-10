classdef PathMap < Map
    % A map with start and end points.
    
    properties (Access = private)
        startPosition;
        endPoint;
    end
    
    properties (Constant)
        goal_radius_xy = 1;
        goal_radius_rotation = 22.25;  % in degrees
    end
    
    methods
        
        function setstart(obj, x, y, rotation)
            % Sets the starting point of the search
            obj.startPosition = [x y rotation];
        end
        
        function setend(obj, xyrotation)
            % Sets the goal point of the search
            obj.endPoint = xyrotation;
        end
        
        function xyrotation = getend(obj)
            % Returns the end point of the search
            xyrotation = obj.endPoint;
        end
        
        function show_path(obj, position, statsObj)
            % Shows the postions from the start postion to the given one.
            
            base_postion = position;
            
            position.teleport()
            plot(obj.car.get_shape(), 'FaceColor', '#7994fb', 'FaceAlpha', 0.5);
            
            hold on
            position.plot_position();
            obj.plot_obstacles()
            obj.plot_end()
            
            while(position.ifLastPosition())
                position = position.lastPos;
                plot(obj.car.get_shape(), 'FaceColor', '#f8ea79', 'EdgeColor', '#999999', 'EdgeAlpha', 0.5, 'FaceAlpha', 0.00);
                position.plot_position();
                position.teleport();
            end
            
            % Starting position
            plot(obj.car.get_shape(), 'FaceColor', '#74f931', 'FaceAlpha', 0.5);
            
            hold off
            obj.fig_config();
            
            if (nargin >= 3)
                % If statsObj is given: generate figure title!
                name = convertCharsToStrings(statsObj.get_algorithm_name());
                
                if (statsObj.get_is_running())
                    string = name + " - Running";
                else
                    string = name + " - Final path";
                end
                
                title(string)
            end
            
            base_postion.teleport()
            
        end
        
        function boolean = check_if_end(obj)
            % Returns true if the search should for the end position should
            % end.
            
            boolean = obj.check_if_close_to_end(2);
            % boolean = obj.check_if_touching_end();
        end
        
        function boolean = check_if_car_in_end(obj)
            % Returns true if the car is in the end position
            
            if(isempty(obj.endPoint))
                boolean = false;
            else
                car = obj.getCar();
                boolean = all([car.xPos, car.yPos, car.Rotation] == obj.endPoint);
            end
            
        end
        
        function boolean = check_if_close_to_end(obj, range)
            % Returns true (1) if the car is close to the end position
            % Else, returns false (0).
            
            car_pos = [obj.car.xPos, obj.car.yPos, obj.car.Rotation];
            end_pos = obj.getend();
            
            diff = obj.twoNodesDistance(car_pos, end_pos);
            boolean = diff <= range;
        end
        
        function boolean = check_if_touching_end(obj)
            % Returns true if car is touching the end point
            
            if(isempty(obj.endPoint))
                boolean = false;
            else
                                
                % Checking location
                
                x_dist_from_goal = abs(obj.getCar().xPos - obj.endPoint(1));
                y_dist_from_goal = abs(obj.getCar().yPos - obj.endPoint(2));
                
                boolean = hypot(x_dist_from_goal, y_dist_from_goal) <= obj.goal_radius_xy;
                
                % Checking rotation
                
                rotation = mod(obj.endPoint(3)-obj.car.Rotation, 360);

                if (rotation > 180)
                    rotation = 180 - mod(rotation, 180);
                end     
       
                boolean = boolean && rotation <= obj.goal_radius_rotation;  % Checking rotation
                
            end
        end
        
        function teleportToStart(obj)
            % Teleports the car to the given start position
            if (~isempty(obj.startPosition))
                obj.car.teleport(obj.startPosition(1), obj.startPosition(2), obj.startPosition(3))
            end
        end
        
    end
    
    methods (Access = protected)
    
        function plot_all(obj)
            % Plots the car, obstacles and end point to the graph.
            plot_all@Map(obj)
            obj.plot_end()
        end
    
    end
    
    methods (Access = private)
        
        function plot_end(obj)
            % Puts the end point (if given) on the graph.
            if(~isempty(obj.endPoint))
                point = plot(obj.endPoint(1), obj.endPoint(2), 'pentagram black');
                point.MarkerFaceColor = 'green';
                point.MarkerSize = 10;
            end
        end
    
    end
end

