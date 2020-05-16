classdef DijkstraPosition < CarSearchPosition
    % Saves the position of the car, with an edition to
    % use Dikstra's search algorithem.
    
    properties (SetAccess = protected, GetAccess = public)
        costToPosition  % The total cost from the start position
    end
    
    methods
        
        function obj = DijkstraPosition(car, xPos, yPos, Rotation)
            % Calls "CarSearchPosition" constructor
            % and sets the cost of the position to infinity.
            
            obj = obj@CarSearchPosition(car, xPos, yPos, Rotation);
            obj.costToPosition = Inf;            
        end
        
        function tryUpdateCost(obj, cost)
            % if the given cost to the position is lower
            % then the current one saved, it will be updated.
            
            if (obj.costToPosition > cost)
                obj.costToPosition = cost;
            end
        end
        
        function cost = getCost(obj)
            % Returns the cost to position from the start position
            cost = obj.costToPosition;
        end
        
    end
end

