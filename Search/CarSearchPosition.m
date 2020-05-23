classdef CarSearchPosition < handle
    % Describes a position of the car
    % Used in path searching algorithems
    % also, saves a pointer to the position before this one
    % and a boolean variable that shows indecates if the position
    % was fully explored or not.
    
    properties (SetAccess = protected)
        car        % Pointer to the car obj
        
        xPos       % The saved position of the car
        yPos
        Rotation
        
        lastPos    % A pointer to the previous position obj
        
        visited    % Boolean value that indicates if the position
                   % was fully explored
    end
    
    methods
        function obj = CarSearchPosition(car, xPos, yPos, Rotation)
            
            if (nargin == 1)
                % If the only parameter is given is the car: save the
                % location of the car!
                xPos = car.xPos;
                yPos = car.yPos;
                Rotation = car.Rotation;
            end
            
            obj.car = car;
            obj.xPos = xPos;
            obj.yPos = yPos;
            obj.Rotation = Rotation;
            
            % By default:
            obj.lastPos = [];
            obj.visited = false;
            % those can be set by seperate methods!
        end
        
        function [ xyrot ] = getPosition(obj)
            % Returns a 3d position of the car.
            xyrot = [obj.xPos obj.yPos obj.Rotation];
        end
        
        function teleport(obj)
            % Teleports the car to the saved position
            obj.car.teleport(obj.xPos, obj.yPos, obj.Rotation)
        end
        
        function markVisited(obj)
            % Sets the stauts of this position to visited
            obj.visited = true;
        end
        
        function visited = ifVisited(obj)
            % Returns true if position is fully explored
            % if not, returns false
            visited = obj.visited;
        end
        
        function boolean = ifEqual(obj, positionObj)
            % Returns true if the parameter object has the
            % same property values as this one.
            
            boolean = (obj.xPos == positionObj.xPos) ...
                && (obj.yPos == positionObj.yPos) ...
                && (obj.Rotation == positionObj.Rotation);
        end
        
        function setLastPos(obj, positionObj)
            % Saves the last position of the car by pointer
            % used to trace back.
            
            obj.lastPos = positionObj;
        end
        
        function boolean = ifLastPostion(obj)
            % Returns true if there is a "last postion" value.
            
            boolean = ~isempty(obj.lastPos);
        end
        
        function pos = getLastPos(obj)
            % Returns a CarPosition object that came before this one.
            pos = obj.lastPos;
        end
        
    end
end

