classdef PathMap < Map
    % A map with start and end points.
    
    properties (Access = private)
        startPosition;
        endPoint;
    end
    
    methods
        
        function setstart(obj, x, y, rotation)
            % Sets the starting point of the search
            obj.startPosition = [x y rotation];
        end
        
        function setend(obj, xy)
            % Sets the goal point of the search
            obj.endPoint = xy;
        end
        
        function xy = getend(obj)
            % Returns the end point of the search
            xy = obj.endPoint;
        end
        
        
        function generate(obj)
            % Shows & Updates the graph!
            
            obj.plot_car()
            hold on
            obj.plot_obstacles()
            obj.plot_end()
            
            hold off
            obj.fig_config()
            
        end
        
        function show_path(obj, position)
            % Shows the postions from the start postion to the given one.
            
            position.teleport()
            plot(obj.car.get_shape(), 'FaceColor', '#7994fb', 'FaceAlpha', 0.5);
            
            hold on
            obj.plot_obstacles()
            obj.plot_end()
            
            while(position.ifLastPosition())
                position = position.lastPos;
                plot(obj.car.get_shape(), 'FaceColor', '#f8ea79', 'FaceAlpha', 0.1);
                position.teleport();
            end
            
            % Starting position
            plot(obj.car.get_shape(), 'FaceColor', '#74f931', 'FaceAlpha', 0.5);
            
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
        
        function teleportToStart(obj)
            % Teleports the car to the given start position
            if (~isempty(obj.startPosition))
                obj.car.teleport(obj.startPosition(1), obj.startPosition(2), obj.startPosition(3))
            end
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

