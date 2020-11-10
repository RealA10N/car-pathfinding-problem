classdef Map < handle
    % Contains one car and an array of obstacles.
    
    properties (Access = protected)
        car
        obstacles
        maxSize
    end
    
    methods
        
        function obj = Map(car, size, obstacles)
            % Creates an empty map & puts the car on it.
            
            if (nargin < 3)
                obstacles = [];
            end
            
            obj.car = car;
            obj.maxSize = size;            
            obj.obstacles = obstacles;
            
        end
        
        function car = getCar(obj)
            % Returns the car on the map.
            car = obj.car;
        end
        
        function setSize(obj, size)
            % Changes the size of the map
            obj.maxSize = size;
        end
        
        function size = getSize(obj)
            % Returns the size of the map
            size = obj.maxSize;
        end
        
        function addObstacles(obj, obstacles)
            % Adds one or more obstacles to the map.
            obj.obstacles = [ obj.obstacles obstacles ];
        end
        
        function car_rand_teleport(obj)
            % Teleports the car into a random location in the map.
            
            x = randi([0 obj.getSize()]);
            y = randi([0 obj.getSize()]);
            rot = Map.generate_random_rot(22.5);
            
            obj.car.teleport(x, y, rot);
            
            if (obj.checkDead())
                % Generate random location again, until the found
                % location is valid.
                obj.car_rand_teleport()
            end
        end
        
        
        function boolean = checkDead(obj)
            % Returns true if the car should be "dead".
            boolean = (obj.checkObstacleCarIntersect() || obj.checkIfOutOfGraph());
        end
        
        function boolean = checkObstacleCarIntersect(obj)
            % Returns true if the car is touching one or more obstacles.
            
            if (isempty(obj.obstacles))
                % if there is no obstacles
                boolean = false;
                return
            end
            
            intersectionsCount = sum(overlaps(obj.get_car_shape(), obj.get_obstacle_shapes()));
            
            if (intersectionsCount > 0)
                % If car intersects with at least one obstacle
                boolean = true;
            else
                % If the car is safe
                boolean = false;
            end
        
        end
        
        function boolean = checkIfOutOfGraph(obj)
            % Returns true if the car touches the borders of the graph.
            
            vertices = obj.car.update();

            boolean = (...
            any(any(vertices > obj.maxSize)) || ...
            any(any(vertices < 0)));
        
        end
        
        function boolean = checkPointDead(obj, x, y)
            % Returns true if the given point is outside of the map or
            % touches one or more obstacles.
            boolean = obj.checkObstaclePointIntersect(x, y) ...
                || obj.checkIfPointOutOfGraph(x, y);
        end
        
        function boolean = checkObstaclePointIntersect(obj, x, y)
            % Returns true if the given point is inside one of the
            % obstacles on the map.
            if (isempty(obj.obstacles))
                boolean = false;
            else
                shapes = obj.get_obstacle_shapes();                
                for i=1:length(shapes)
                    if (isinterior(shapes(i), x, y))
                        boolean = true;
                        return;
                    end
                end
                boolean = false;
            end
        end
        
        function boolean = checkIfPointOutOfGraph(obj, x, y)
            % Returns true if the given point is inside the map.
            boolean = (x > obj.maxSize) || (y > obj.maxSize);
            boolean = boolean || (x < 0) || (y < 0);
        end
                
        function generate(obj)
            % Shows & Updates the graph!
            obj.plot_all()
            hold off
            obj.fig_config()
        end

        function distance = twoNodesDistance(~, p1, p2)
            % This function recives two points arrays, when in each point
            % array the first two elements indicates the x and y values of
            % the point, and the last one indicates the rotation of the car
            % in degrees (0-360)
            
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
    
    methods (Access = protected)
        
        function plot_all(obj)
            % Plots the car and the obstacles to the graph.
            obj.plot_car()
            hold on
            obj.plot_obstacles()
        end
        
        function shapes = get_obstacle_shapes(obj)
            % Returns an array of polyshape objects; each polyshape
            % represents an obstacle.
                        
            shapes = [];
            for i = 1:length(obj.obstacles)
                shapes = [shapes obj.obstacles(i).get_shape()];
            end
        end
        
        function shape = get_car_shape(obj)
            % Returns the polyshape of the car.
            shape = obj.car.get_shape();
        end
        
        function shapes = get_all_shapes(obj)
            % Returns an array of polyshape objects; the first one
            % represents the car, the others represent different
            % obstacles.
            
            shapes = [obj.get_car_shape() obj.get_obstacle_shapes()];
        end
        
        function plot_obstacles(obj)
            % Puts the obstacles on the graph.
            shapes = obj.get_obstacle_shapes();
            if (~isempty(shapes))
                plot(shapes, 'FaceColor', '#b0000f', 'FaceAlpha', 1, 'EdgeAlpha', 0);
            end
        end
        
        function plot_car(obj)
            % Puts the car on the graph.
            shapes = obj.car.get_shape();
            if (~isempty(shapes))
                plot(shapes, 'FaceColor', '#00dfcb', 'FaceAlpha', 1);
            end
        end
        
        function fig_config(obj)
            % commands that will set up and draw the figure
            
            axis equal
            xlim([0 obj.maxSize])
            ylim([0 obj.maxSize])
            drawnow limitrate
            
        end
        
    end
    
    methods (Access = private, Static)
        
        function rot = generate_random_rot(rotation_jumps)
            % Generates a random rotation for the car.
            
            options = 360 / rotation_jumps;
            selected = randi([0 options]);
            rot = selected * rotation_jumps;
        end
        
    end
end