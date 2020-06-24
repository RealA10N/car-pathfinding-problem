classdef CarCurvedSingleMove < CarSingleMove
    % defines one step in one direction of the car. This step is not
    % straight, but curved - just like in real life.
    
    properties (Access = protected)
        parts  % The number of parts in each whole step.
               % The higher the number, the more smooth the curve will look,
               % but the longer it will take to calculate it.
    end
    
    methods
        function obj = CarCurvedSingleMove(driver, rotation, length, parts)
            obj = obj@CarSingleMove(driver, rotation, length);
            obj.parts = parts;
        end
        
        function [small_steps_x, small_steps_y] = move(obj)
            % Moves the car in the given curved direction,
            % and the given length.
            small_steps_x = zeros(1, obj.parts);
            small_steps_y = zeros(1, obj.parts);
            
            for i=1:obj.parts
                obj.driver.car.rotate(obj.rotation/obj.parts)
                obj.driver.car.jump(obj.length/obj.parts)
                small_steps_x(i) = obj.driver.car.xPos;
                small_steps_y(i) = obj.driver.car.yPos;
            end
        end
    end
end

