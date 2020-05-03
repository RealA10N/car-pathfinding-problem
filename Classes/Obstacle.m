classdef Obstacle < Shape
    % Defines every obstable in the program
    % Right now, obstables are squares only (may change)
    
    methods
        
        function obj = Obstacle(x, y, size)
            % Obatacle gets starting (x, y) position and size
            % of obstable -> Generates vertices obstable
            
            xEnd = x + size;
            yEnd = y + size;
            obj.vertices = [x y; x yEnd; xEnd yEnd; xEnd y];
        end
        
        function vertices = update(obj)
            vertices = obj.vertices;
        end

    end
end

