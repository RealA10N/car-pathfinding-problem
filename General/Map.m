classdef Map < handle
    % Contains one car and an array of obstacles.
    
    properties (Access = protected)
        car
        obstacles
        maxSize
    end
    
    methods
        
        function obj = Map(car, obstacles, size)
            % Creates an empty map & puts the car on it.
            
            if (nargin < 3)
                size = 20;
            end
            
            obj.car = car;
            obj.obstacles = obstacles;
            obj.maxSize = size;
            
        end
        
        function setSize(obj, size)
            % Changes the size of the map
            obj.maxSize = size;
        end
        
        function addObstacles(obj, obstacles)
            % Adds one or more obstacles to the map.
            obj.obstacles = [ obj.obstacles obstacles ];
        end
        
        
        function boolean = checkDead(obj)
            % Returns true if the car should be "dead".
            boolean = (obj.checkObstacleCarIntersect() || obj.checkIfOutOfGraph());
        end
        
        function boolean = checkObstacleCarIntersect(obj)
            % Returns true if the car is touching one or more obstacles.
            
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
            boolean = (...
            any(any(obj.car.vertices > obj.maxSize)) || ...
            any(any(obj.car.vertices < 0)));
        end
        
        function generate(obj)
            % Shows & Updates the graph!
            
            if(obj.checkDead())
                disp("You are dead!");
            end
            
            obj.plot_car()
            hold on
            obj.plot_obstacles()
            hold off

            obj.fig_config()

        end
            
    end
    
    methods (Access = protected)
        
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
                plot(shapes, 'FaceColor', '#b0000f', 'FaceAlpha', 1);
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
end