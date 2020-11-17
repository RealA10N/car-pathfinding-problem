classdef HistogramTool
    % A handy tool that will generate a map and
    % random points on it. The random points can
    % and will be displayed as a Histogram.
    
    properties (Access = private)
        size
        car
        map
    end
    
    methods
        function obj = HistogramTool(size)
            % Create a new map with the given size.
            
            if (nargin < 1)
                size = 20;
            end
            
            obj.size = size;
            obj.car = Car(-5, -5, 90);  % Create a car, but outside of the map
            obj.map = PathMap(obj.car, obj.size);
            
            obj.generate()
        end
        
        function setEnd(obj, rotation, x, y)
            % Set the end, target point.
            
            if (nargin < 2)
                rotation = 0;
            end
            
            if (nargin < 4)
                obj.generate()
                [ x, y ] = obj.userInPoints(1);
            end
            
            obj.map.setend([x y rotation])
            obj.generate()
        end
        
        function throw_random_points(obj, num)
            % throw 'num' random points on the map and show the histogram.
            point = RandomPoint(obj.map);
            obj.throw_points(num, point);
        end
        
        function throw_improved_points(obj, num, beta_dist_v)
            % throw 'num' random special points on the map and show the histogram.

            if (nargin < 3)
                beta_dist_v = 15;  % default v value
            end
            
            point = ImprovedRandomPoint(obj.map, beta_dist_v);
            obj.throw_points(num, point);
        end
        
        function throw_balanced_points(obj, num, beta_dist_v)
            % throw a mixture of random and special points on the map and show the histogram.
            
            if (nargin < 3)
                beta_dist_v = 15;  % default v
            end
            
            point = BalancedRandomPoint(obj.map, beta_dist_v);
            obj.throw_points(num, point);
        end
    end
    
    methods (Access = private)
        
        function generate(obj)
            obj.map.generate()
        end
        
        function [x, y] = userInPoints(~, num_of_points)
            % This method uses the ginput function to take in input from
            % the user, but the points are rounded.
            [ x, y ] = ginput(num_of_points);
            x = round(x);
            y = round(y);
        end
 
        function point = string_to_point(obj, string)
            % Convert the given string to a new random point
            
            if string == "Random"
                point = RandomPoint(obj.map);
            
            elseif string == "Improved"
                point = ImprovedRandomPoint(obj.map);
            
            elseif string == "Balanced"
                point = BalancedRandomPoint(obj.map);
            
            end
        end
        
        function throw_points(~, num, point)
            % Throws num amount of points onto the map.
            % The points are from the given type.
            
            rand_points = zeros(num, 3);
            
            for count = 1:num
                point.generate()
                rand_points(count, :) = point.getPosition();
            end
            
            hist3([rand_points(:, 1), rand_points(:, 2)], 'CDataMode', 'auto')
            pause
            histogram(rand_points(:, 3))
            xlim([0 360])
            
        end
        
    end
    
end

