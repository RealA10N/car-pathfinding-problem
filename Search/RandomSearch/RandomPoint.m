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
            obj.x = RandomPoint.getRandomPointXY(endpoint(1), mapObj);
            obj.y = RandomPoint.getRandomPointXY(endpoint(2), mapObj);
            obj.rotation = normrnd(endpoint(3), 90);
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
    
    methods (Static)
        function boolean = checkValidXY(size, mapObj)
            % Returns true if the given position (x or y) is inside the
            % board.
            
            boolean = size >= 0 && size <= mapObj.getSize();
        end
        
        function size = getRandomPointXY(goal_value, mapObj)
            % Returns a 'smart' random dimension of the point (x or y).
            % This size leans towards the goal point.
            
            size = normrnd(goal_value, mapObj.getSize() / 2);
            
            size = max([0 size]);
            size = min([mapObj.getSize() size]);
            
        end
    end

end