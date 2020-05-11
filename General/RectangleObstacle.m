classdef RectangleObstacle < Shape
    % Defines a rectangle shaped obstacle
    
    methods

        function obj = RectangleObstacle(x, y, x2, y2)
            % Obatacle gets starting (x, y) position and size
            % of obstable -> Generates vertices obstable
            
            obj.vertices = [x y; x y2; x2 y2; x2 y];
        end

    end
end

