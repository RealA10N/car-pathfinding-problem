classdef Shape < handle
    % Defines every shape in the program
    % Inherets from this class: Car, Obstacle
    
    properties (Access=protected)
        vertices
        % 2 Column matrix containing [x,y]
        % of each vertex in the shape in order.
    end
    
    methods

        function update(obj)
            % Some shapes will need a function to update their
            % vertices property before using "get_shape()"
        end
        
        function shape = get_shape(obj)
            % Returns a shape you can plot.
            obj.vertices = obj.update();
            shape = polyshape(obj.vertices);
        end

        function plot(obj)
            plot(obj.get_shape());
        end
        
    end
end

