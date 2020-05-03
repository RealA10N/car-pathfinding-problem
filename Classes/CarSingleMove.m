classdef CarSingleMove
    % defines one step in one direction of the car.
    
    properties (Access = protected)
        car
        jump
        rotation
    end
    
    methods
        function obj = CarSingleMove(car, jump, rotation)
            obj.car = car;
            obj.jump = jump;
            obj.rotation = rotation;
        end
        
        function move(obj)
            % moves the car in the given direction.
            obj.car.move(obj.jump, obj.rotation)
        end
    end
end

