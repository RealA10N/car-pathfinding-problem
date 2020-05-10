classdef PathMap < Map
    % A map with start and end points.
    
    properties (Access = private)
        startPoint;
        endPoint;
    end
    
    methods
        
        function setstart(obj, xy)
            % Sets the starting point of the search
            obj.startPoint = xy;
        end
        
        function setend(obj, xy)
            % Sets the goal point of the search
            obj.endPoint = xy;
        end
        
        
        function generate(obj)
            % Shows & Updates the graph!
            
            plot(obj.get_obstacle_shapes(), 'FaceColor', '#b0000f', 'FaceAlpha', 1);
            hold on
            plot(obj.car.get_shape(), 'FaceColor', '#00dfcb', 'FaceAlpha', 0.5);
            
            % plot start & end points
            if(~isempty(obj.startPoint))
                obj.plot_start()
            end
            if(~isempty(obj.endPoint))
                obj.plot_end()
            end
            
            if(obj.checkDead())
                disp("You are dead!");
            end
            
            hold off
            obj.fig_config()
            
        end
        
        function boolean = check_if_end(obj)
            % Returns true if car is touching the end point
            
            if(isempty(obj.endPoint))
                boolean = 0;
            else
                boolean = isinterior(obj.car.get_shape(), ...
                obj.endPoint(1), obj.endPoint(2));
            end
        end
        
    end
    
    methods (Access = private)
        
        function plot_start(obj)
            point = plot(obj.startPoint(1), obj.startPoint(2), 'square black');
            point.MarkerFaceColor = 'blue';
            point.MarkerSize = 10;
        end
        
        function plot_end(obj)
            point = plot(obj.endPoint(1), obj.endPoint(2), 'pentagram black');
            point.MarkerFaceColor = 'green';
            point.MarkerSize = 10;
        end
    
    end
end

