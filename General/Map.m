classdef Map < handle
    % Contains one car and an array of obstacles.
    
    properties
        car
        obstacles 
    end
    
    properties (Constant)
        maxSize = 20
    end
    
    methods
        
        function obj = Map(car, obstacles)
            % Creates an empty map & puts the car on it.
            
            obj.car = car;
            obj.obstacles = obstacles;
        end
        
        
        function boolean = checkDead(obj)
            % Returns true if the car should be "dead".
            boolean = (obj.checkObstacleCarIntersect() || obj.checkIfOutOfGraph());
        end
        
        function boolean = checkObstacleCarIntersect(obj)
            % Returns true if the car is touching one or more obstacles.
            
            overlapTable = overlaps(obj.get_all_shapes());
            
            boolean = false;
            for i = 2:length(overlapTable)
                if(overlapTable(1, i) == 1)
                    boolean = true;
                    return
                end
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
            
            obj.plot_obstacles()
            hold on
            obj.plot_car()
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
        
        function shapes = get_all_shapes(obj)
            % Returns an array of polyshape objects; the first one
            % represents the car, the others represent different
            % obstacles.
            
            shapes = [obj.car.get_shape() obj.get_obstacle_shapes()];
        end
        
        function plot_obstacles(obj)
            % Puts the obstacles on the graph.
            plot(obj.get_obstacle_shapes(), 'FaceColor', '#b0000f', 'FaceAlpha', 1);
        end
        
        function plot_car(obj)
            % Puts the car on the graph.
            plot(obj.car.get_shape(), 'FaceColor', '#00dfcb', 'FaceAlpha', 1);
        end
        
        function fig_config(obj)
            % commands that will set up and draw the figure
            
            axis equal
            xlim([0 obj.maxSize])
            ylim([0 obj.maxSize])
            drawnow
            
        end
        
    end
end