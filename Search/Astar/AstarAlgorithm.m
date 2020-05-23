classdef AstarAlgorithm < ForwardSearchAlgorithm
    
    properties (Access = protected)
        pullingStrength
    end
    
    methods
        function obj = AstarAlgorithm(map)
            % Calls superclass constuctor
            obj = obj@ForwardSearchAlgorithm(map, "A* Search");
            
            obj.pullingStrength = 1;
        end
        
        function position = carToPosition(obj, lastPos)
            % Returns an "AstarPosition" object that contains
            % the current position of the car.
            
            position = AstarPositon(obj.map.getCar());
            
            % Saves the end point
            position.setEndGoal(obj.map.getend());
            
            % Update pulling strength
            position.setPullingStrength(obj.pullingStrength)
            
            % If lastPos is given
            if (nargin >= 2)
                position.setLastPos(lastPos)  % Saves the lastPos
                costToPos = lastPos.getCost() + 1;  % Calculates the cost to current point
                position.tryUpdateCost(costToPos);  % Saves cost to current point
            end
        
        end
    end
    
    methods (Static)
        function queue = getAlgorithmQueueObj()
            % Returns the AstarPositionQueue object
            queue = AstarPositionQueue();
        end
    end
end