classdef BreadthFirstAlgorithm < ForwardSearchAlgorithm
    
    methods
        function obj = BreadthFirstAlgorithm(map)
            % Calls superclass constuctor
            obj = obj@ForwardSearchAlgorithm(map, "Breadth First Search");            
        end
        
        function position = carToPosition(obj, lastPos)
            % Returns an "CarSearchPosition" object that contains
            % the current position of the car
            
            position = CarSearchPosition(obj.map.getCar());
            
            if (nargin >= 2)
                position.setLastPos(lastPos)
            end
            
        end
        
        function position = carToStartingPosition(obj)
            % Returns a "AstarPosition" object that contains the current
            % position of the car with no lastPos.
            position = obj.carToPosition();
        end
        
        
    end
    
    methods (Static)
        function queue = getAlgorithmQueueObj()
            % Returns the BreadthFirstPositionQueue object
            queue = BreadthFirstPositionQueue();
        end
    end
end