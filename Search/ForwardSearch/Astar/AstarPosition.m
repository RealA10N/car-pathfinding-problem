classdef AstarPosition < DijkstraPosition
    % Saves the position of the car and the cost from the start position
    % to this one. Has method to calculate the distance ("cost") to the end
    % position, to use in the A* algorithm.
    
    properties (SetAccess = protected, GetAccess = public)
        distanceToGoal  % The estimated cost to the goal
        pullStrength  % Multiplier of the distance cost. default value is 1
    end
    
    methods
        
        function obj = AstarPosition(car, xPos, yPos, Rotation)
            % Calls "DijkstraPosition" constructor
            % and sets the cost of the position to infinity.
            
            if (nargin == 1)
                % If the only parameter is given is the car: save the
                % location of the car!
                xPos = car.xPos;
                yPos = car.yPos;
                Rotation = car.Rotation;
            end
            
            obj = obj@DijkstraPosition(car, xPos, yPos, Rotation);

        end
        
        function setEndGoal(obj, endPoint)
            % Set the end point and calculates the euclidean distance
            % between the point and the goal.
            
            % Getting xy of this point
            curPoint = obj.getPosition();
            curPoint = curPoint(1:2);
            
            obj.distanceToGoal = norm(endPoint(1:2)-curPoint);
        end
        
        function distance = getDistanceToGoal(obj)
            % Returns the euclidean distance from the point to the given
            % goal point.
            distance = obj.distanceToGoal;
        end
        
        function cost = getTotalCost(obj)
            % Returns the total cost of the current position
            % (Used in the A* Algorithm!)
            cost = obj.getCost() + (obj.getDistanceToGoal() * obj.getPullingStrength());
        end
        
        function strength = getPullingStrength(obj)
            % Returns the pulling strength of the distance to the goal.
            % If this value is high, the algorithm will give more weight to
            % the distance from the position to the end point, and if this
            % value is low the algorithm will give more weight to the
            % number of steps. The default value is 1.
            strength = obj.pullStrength;
        end
        
        function setPullingStrength(obj, weight)
            % If this value is high, the algorithm will give more weight to
            % the distance from the position to the end point, and if this
            % value is low the algorithm will give more weight to the
            % number of steps. The default value is 1.
            obj.pullStrength = weight;
        end
        
    end
end

