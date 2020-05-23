classdef DijkstrasAlgorithm < ForwardSearchAlgorithm
    
    methods
        function obj = DijkstrasAlgorithm(map)
            % Calls superclass constuctor
            obj = obj@ForwardSearchAlgorithm(map, "Dijkstra's Search");            
        end
        
        function position = carToPosition(obj, lastPos)
            % Returns an "DijkstraPosition" object that contains
            % the current position of the car.
            
            position = DijkstraPosition(obj.map.getCar());
            
            % If lastPos is given
            if (nargin >= 2)
                position.setLastPos(lastPos)  % Saves the lastPos
                costToPos = lastPos.getCost() + 1;  % Calculates the cost to current point
                position.tryUpdateCost(costToPos);  % Saves cost to current point
            end
        
        end
        
        function position = carToStartingPosition(obj)
            % Returns a "DijkstraPosition" object that contains the current
            % position of the car, with cost 0 and no lastPos.
            
            position = obj.carToPosition();
            position.tryUpdateCost(0)
        
        end
    end
    
    methods (Static)
        function queue = getAlgorithmQueueObj()
            % Returns the DijkstrasPositionQueue object
            queue = DijkstraPositionQueue();
        end
    end
end