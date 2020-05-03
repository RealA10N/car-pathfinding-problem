classdef CarDriver
    % defines all of the possible movments of the car
    % and allows you to name them and move the car just by
    % using the "move" function and the name of the move.
    
    properties (Access = protected)
        directions
    end
    
    methods
        function obj = CarDriver(car)
            
            jumps = 0.1;
            positive_rotation = pi/100;
                        
            obj.directions = struct();
            obj.directions.uparrow = CarSingleMove(car, jumps, 0);
            obj.directions.downarrow = CarSingleMove(car, -jumps, 0);
            obj.directions.leftarrow = CarSingleMove(car, jumps, positive_rotation);
            obj.directions.rightarrow = CarSingleMove(car, jumps, -positive_rotation);
            
        end
        
        function move(obj, direction)
            % will move the car in the given direction, if exsistes.
            
            if (isfield(obj.directions, direction))
                obj.directions.(direction).move();
            end
            
        end
        
        
        
    end
end

