classdef AstarPosition < DijkstraPosition
    % Saves the position of the car and the cost from the start position
    % to this one. Has method to calculate the distance ("cost") to the end
    % position, to use in the A* algorithm.
    
    properties (SetAccess = protected, GetAccess = public)
        distanceToGoal  % The estimated cost to the goal
    end
    
    methods
        
        function obj = AstarPosition(car, xPos, yPos, Rotation, endPoint, cost)
            % Calls "DijkstraPosition" constructor
            % and sets the cost of the position to infinity.
            
            obj = obj@DijkstraPosition(car, xPos, yPos, Rotation);
            
            if (nargin > 5)
                obj.tryUpdateCost(cost);
            end

            obj.setEndGoal(endPoint);
        end
        
        function setEndGoal(obj, endPoint)
            % Set the end point and calculates the euclidean distance
            % between the point and the goal.
            
            % Getting xy of this point
            curPoint = obj.getPosition();
            curPoint = curPoint(1:2);
            
            obj.distanceToGoal = norm(endPoint-curPoint);
        end
        
        function distance = getDistanceToGoal(obj)
            % Returns the euclidean distance from the point to the given
            % goal point.
            distance = obj.distanceToGoal;
        end
        
        function cost = getTotalCost(obj)
            % Returns the total cost of the current position
            % (Used in the A* Algorithm!)
            cost = obj.getCost() + obj.getDistanceToGoal();
        end
        
    end
end

