classdef SearchCar < Car
    % Car that is used in searching algorithems
    % Contains different methods that might help and make
    % it easier to use in searching algorithem!
    
    
    methods
        
        function outputObj = convertToPosition(obj)
            % Returns an "CarSearchPosition" object that contains
            % the current position of the car
            outputObj = CarSearchPosition(obj, obj.xPos, obj.yPos, obj.Rotation);
        end
        
        function outputObj = convertToDijkstraPosition(obj)
            % Returns an "DijkstraPosition" object that contains
            % the current position of the car
            outputObj = DijkstraPosition(obj, obj.xPos, obj.yPos, obj.Rotation);
        end
        
        function outputObj = convertToAstarPosition(obj, endPoint)
            % Returns an "AstarPosition" object that contains
            % the current position of the car
            outputObj = AstarPosition(obj, obj.xPos, obj.yPos, obj.Rotation, endPoint);
        end
    
    end
end

