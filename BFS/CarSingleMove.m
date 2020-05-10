classdef CarSingleMove
    % defines one step in one direction of the car.
    
    properties (Access = protected)
        driver
        rotation
        length
    end
    
    methods
        function obj = CarSingleMove(driver, rotation, length)
            obj.driver = driver;
            obj.rotation = rotation;
            obj.length = length;
        end
        
        function move(obj, length)
            % Moves the car in the given direction,
            % and with the given length
            obj.driver.car.rotate(obj.rotation)
            obj.driver.car.move_8directions(obj.length)
        end
    end
end

