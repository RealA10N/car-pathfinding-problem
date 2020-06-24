classdef CarCurvedSearchPosition < CarSearchPosition
    % Describes a position of the car
    % Saves an array that indecates the curve of the step between the saved
    % position and the last position.
    
    properties (SetAccess = private)
        small_steps_x  % Two arrays that contain x and y of each mini-step
        small_steps_y  % in the step that makes the curve.
    end
    
    methods
        function add_small_step(obj, x, y)
            % Adds a part of the curve/step and saves it to print it later.
            obj.small_steps = [obj.small_steps; x y;];
        end
        
        function set_small_steps(obj, x_arr, y_arr)
            % Sets the vertices of the curse and saves it to print it
            % later.
            
            obj.small_steps_x = x_arr;
            obj.small_steps_y = y_arr;
        end
        
        function plot_position(obj)
            % Plots all of the points that make up the position.
            
            for i=1:length(obj.small_steps_x)
                point = plot(obj.small_steps_x(i), obj.small_steps_y(i), '.');
                point.MarkerEdgeColor = 'black';
                point.MarkerSize = 2.5;
            end
        end
        
        
    end
end

