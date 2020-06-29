classdef AstarAlgorithm < ForwardSearchAlgorithm
    
    properties (Access = protected)
        pullingStrength
    end
    
    methods
        function obj = AstarAlgorithm(map, stats)
            % Calls superclass constuctor
            obj = obj@ForwardSearchAlgorithm(map, stats, "A* Search");
        end
        
        function position = carToPosition(obj, lastPos)
            % Returns an "AstarPosition" object that contains
            % the current position of the car.
            
            position = AstarPosition(obj.map.getCar());
            
            % Saves the end point
            position.setEndGoal(obj.map.getend());
            
            % If lastPos is given
            if (nargin >= 2)
                position.setLastPos(lastPos)  % Saves the lastPos
                costToPos = lastPos.getCost() + 1;  % Calculates the cost to current point
                position.tryUpdateCost(costToPos);  % Saves cost to current point
            end
        
        end
        
        function position = carToStartingPosition(obj)
            % Returns a "AstarPosition" object that contains the current
            % position of the car, with cost 0 and no lastPos.
            
            position = obj.carToPosition();
            position.tryUpdateCost(0)
        
        end
    end
    
    methods (Static)
        function queue = getAlgorithmQueueObj()
            % Returns the AstarPositionQueue object
            queue = AstarPositionQueue();
        end
    end
end