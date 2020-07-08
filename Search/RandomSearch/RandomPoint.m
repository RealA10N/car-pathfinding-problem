classdef RandomPoint < handle
    % when created, generates a random point on the map and saves it.
    
    properties (Access = protected)
        % Randomly generated in the constructor
        
        x
        y  
        rotation  % rotation in degrees (0-360)
    end
    
    
    methods
        
        function obj = RandomPoint(mapObj)
            % Generates a new random point
            
            max_size = mapObj.getSize();
            
            % Generate random x, y and rotation
            obj.x = rand() * max_size;
            obj.y = rand() * max_size;
            obj.rotation = rand() * 360;
        end
    
        function position = getPosition(obj)
            % Returns the position of the random genereted point.
            position = [obj.x obj.y obj.rotation];
        end
        
        function plot(obj)
            % Shows the point on the graph

            str = strcat('\leftarrow ', num2str(obj.rotation), '°');
            text(obj.x, obj.y, str)
            
        end
    end

end