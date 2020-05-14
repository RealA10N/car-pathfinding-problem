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
            
            obj.plot_car()
            hold on
            obj.plot_obstacles()
            obj.plot_start()
            obj.plot_end()
            
            hold off
            obj.fig_config()
            
        end
        
        function show_path(obj, position)
            % Shows the postions from the start postion to the given one.
            
            obj.plot_car()
            hold on
            obj.plot_obstacles()
            obj.plot_start()
            obj.plot_end()
            
            while(position.ifLastPostion())
                position = position.lastPos;
                position.teleport();
                plot(obj.car.get_shape(), 'FaceColor', '#f8ea79', 'FaceAlpha', 0.1);
            end
            
            hold off
            obj.fig_config();
            
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
            % Puts the start point (if given) on the graph.
            if(~isempty(obj.startPoint))
                point = plot(obj.startPoint(1), obj.startPoint(2), 'square black');
                point.MarkerFaceColor = 'blue';
                point.MarkerSize = 10;
            end
        end
        
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

