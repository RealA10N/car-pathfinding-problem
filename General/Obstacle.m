classdef Obstacle < Shape
    % Defines every obstable in the program
    % Obstables is a square.
    
    methods
        
        function obj = Obstacle(x, y, size)
            % Obatacle gets starting (x, y) position and size
            % of obstable -> Generates vertices obstable
            
            xEnd = x + size;
            yEnd = y + size;
            obj.vertices = [x y; x yEnd; xEnd yEnd; xEnd y];
        end

    end
end

