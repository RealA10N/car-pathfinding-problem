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
            endpoint = mapObj.getend();
            
            % Generate random x, y and rotation            
            obj.x = obj.getRandomPointXY(endpoint(1), mapObj);
            obj.y = obj.getRandomPointXY(endpoint(2), mapObj);
            obj.rotation = mod(normrnd(endpoint(3), 90), 360);
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
    
    methods (Access=protected)
        
        function value = getRandomPointXY(~, ~, mapObj)
            % Returns a random dimention of the point (x or y).
            
            size = mapObj.getSize();
            value = rand * size;
            
        end
    end

end