classdef RandomEdge < handle
    % Gets two random points, and connects them with an edge.
    
    properties (Access = protected)
        pointOne
        pointTwo
    end
    
    methods
        
        function obj = RandomEdge(pointOne, pointTwo)
            obj.pointOne = pointOne;
            obj.pointTwo = pointTwo;
        end
        
        function [p1, p2] = getPoints(obj)
            % Returns the points that form the edge. 
            p1 = obj.pointOne;
            p2 = obj.pointTwo;
        end
        
        function plot(obj)
            % Draws the edge between the two points.
            
            [p1x, p1y] = obj.pointOne.getPosition();
            [p2x, p2y] = obj.pointTwo.getPosition();
            
            line = plot([p1x p2x], [p1y p2y]);
            line.Color = "#e46100";
        end
    end
end

