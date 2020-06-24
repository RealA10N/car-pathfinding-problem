classdef DijkstraPosition < CarCurvedSearchPosition
    % Saves the position of the car and the cost from the start position
    % to this one. Has an edition to be used in Dikstra's search
    % algorithm.
    
    properties (Access = protected)
        costToPosition  % The total cost from the start position
    end
    
    methods
        
        function obj = DijkstraPosition(car, xPos, yPos, Rotation)
            % Calls "CarSearchPosition" constructor
            % and sets the cost of the position to infinity.
            
            if (nargin == 1)
                % If the only parameter is given is the car: save the
                % location of the car!
                xPos = car.xPos;
                yPos = car.yPos;
                Rotation = car.Rotation;
            end
            
            obj = obj@CarCurvedSearchPosition(car, xPos, yPos, Rotation);
            obj.costToPosition = Inf;
            
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

