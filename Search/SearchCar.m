classdef SearchCar < Car
    % Car that is used in searching algorithems
    % Contains different methods that might help and make
    % it easier to use in searching algorithem!
    
    
    methods
        
        function outputObj = getCurSearchPosition(obj)
            % Returns an "CarSearchPosition" object that contains
            % the current position of the car
            outputObj = CarSearchPosition(obj, obj.xPos, obj.yPos, obj.Rotation);
        end
    
    end
end

