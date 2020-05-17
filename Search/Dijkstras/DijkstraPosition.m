classdef DijkstraPosition < CarSearchPosition
    % Saves the position of the car and the cost from the start position
    % to this one. Has an edition to be used in Dikstra's search
    % algorithm.
    
    properties (Access = protected)
        costToPosition  % The total cost from the start position
    end
    
    methods
        
        function obj = DijkstraPosition(car, xPos, yPos, Rotation, cost)
            % Calls "CarSearchPosition" constructor
            % and sets the cost of the position to infinity.
            
            obj = obj@CarSearchPosition(car, xPos, yPos, Rotation);
            
            if (nargin < 5)
                obj.costToPosition = Inf;
            else
                obj.costToPosition = cost;
            end
            
        end
        
        function boolean = ifCostLower(obj, cost)
            % Returns true if the given point cost is lower
            % than the saved one.
            boolean = obj.costToPosition > cost;
        end
        
        function tryUpdateCost(obj, cost)
            % if the given cost to the position is lower
            % then the current one saved, it will be updated.
            
            if (obj.ifCostLower(cost))
                obj.costToPosition = cost;
            end
        end
        
        function cost = getCost(obj)
            % Returns the cost to position from the start position
            cost = obj.costToPosition;
        end
        
        function cost = getTotalCost(obj)
            % Returns the total cost from the start position
            cost = obj.getCost();
        end
        
    end
end

