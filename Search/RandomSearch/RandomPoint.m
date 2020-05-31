classdef RandomPoint < handle

    properties (Access = protected)
        x
        y
    end
    
    
    methods
        
        function obj = RandomPoint(mapObj)
            % Generates a new random point
            
            max_size = mapObj.getSize();
            
            % Generate random x and y
            obj.x = randi([0, max_size]);
            obj.y = randi([0, max_size]);
            
        end
    
        function [x, y] = getPosition(obj)
            % Returns the position of the random genereted point.
            x = obj.x;
            y = obj.y;
        end
        
        function boolean = isInFreeSpace(obj)
            % Returns true if the random point is in the free space.
            % Returns false if the point appears inside the obstacle.
            boolean = ~mapObj.checkObstaclePointIntersect(obj.x, obj.y);
        end
        
        function plot(obj)
            % Shows the point on the graph
            
            point = plot(obj.x, obj.y, '.');
            point.MarkerEdgeColor = '#ffa100';
            point.MarkerSize = 10;
        end
        
    end

end