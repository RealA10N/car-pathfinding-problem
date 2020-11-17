classdef RandomPoint < handle
    % when created, generates a random point on the map and saves it.
    
    properties (Access = protected)
        % Randomly generated in the constructor
        
        x
        y  
        rotation  % rotation in degrees (0-360)
        
        mapObj
    end
    
    
    methods
        
        function obj = RandomPoint(mapObj)
            obj.mapObj = mapObj;
        end
        
        function generate(obj)
            % Generates a new random point
            endpoint = obj.mapObj.getend();
            % Generate random x, y and rotation            
            obj.x = obj.getRandomPointXY(endpoint(1));
            obj.y = obj.getRandomPointXY(endpoint(2));
            obj.rotation = obj.getRandomPointRotation(endpoint(3));
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
        
        function value = getRandomPointXY(obj, ~)
            % Returns a random dimention of the point (x or y).
            size = obj.mapObj.getSize();
            value = rand * size;
            
        end
        
        function value = getRandomPointRotation(~, ~)
            % Returns a random rotation (number) between 0 and 360
            value = 360 * rand();
        end
    end

end