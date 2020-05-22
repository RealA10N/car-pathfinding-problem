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
        
        function outputObj = convertToDijkstraPosition(obj, cost)
            % Returns an "DijkstraPosition" object that contains
            % the current position of the car
            
            if (nargin < 2)
                outputObj = DijkstraPosition(obj, obj.xPos, obj.yPos, obj.Rotation);
            else
                outputObj = DijkstraPosition(obj, obj.xPos, obj.yPos, obj.Rotation, cost);
            end
        end
        
        function outputObj = convertToAstarPosition(obj, endPoint, cost, pullingStrength)
            % Returns an "AstarPosition" object that contains
            % the current position of the car
            
            if (nargin < 3)
                outputObj = AstarPosition(obj, obj.xPos, obj.yPos, obj.Rotation, endPoint);
            elseif (nargin == 3)
                outputObj = AstarPosition(obj, obj.xPos, obj.yPos, obj.Rotation, endPoint, cost);
            else
                outputObj = AstarPosition(obj, obj.xPos, obj.yPos, obj.Rotation, endPoint, cost, pullingStrength);
            end
        end
    
    end
end

