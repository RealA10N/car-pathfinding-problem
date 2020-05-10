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
            % Returns true if the car is touching on or more obstacles
            
            overlapTable = overlaps(obj.get_all_shapes());
            
            boolean = 0;
            for i = 2:length(overlapTable)
                if(overlapTable(1, i) == 1)
                    boolean = 1;
                end
            end
        
        end
        
        
        function generate(obj)
            % Shows & Updates the graph!
            
            if(obj.checkDead())
                disp("You are dead!");
            end
            
            plot(obj.get_obstacle_shapes(), 'FaceColor', '#b0000f', 'FaceAlpha', 1);
            hold on
            plot(obj.car.get_shape(), 'FaceColor', '#00dfcb', 'FaceAlpha', 1);
            obj.fig_config()
            hold off

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
        
        function fig_config(obj)
            % commands that will set up and draw the figure
            
            axis equal
            xlim([0 obj.maxSize])
            ylim([0 obj.maxSize])
            drawnow
            
        end
        
    end
end










