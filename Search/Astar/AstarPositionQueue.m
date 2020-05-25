classdef AstarPositionQueue < DijkstraPositionQueue
    % Stores multiple postions of the car, and has methods to add positions
    % and pull-out position from the queue (those methods follow the
    % A* algorithm!)
    
    methods
        
        function addPosition(obj, positionObj)
            % Adds a position object to the queue
            % If the position is already visited and has a cost,
            % the cost will be updated to the lowest one.
            
            positionFromQueue = obj.getPositionInQueue(positionObj);
            
            if (obj.checkInQueue(positionObj))
                
                % if already visited same position -> checks cost and
                % updates if needed!
                if(positionObj.getCost() < positionFromQueue.getCost())
                    obj.removeFromQueue(positionFromQueue);
                    obj.literallyAddPosition(positionObj);
                end
            else
                
                if (~obj.checkIfPulled(positionObj))
                    % If this position is encountered on the first time
                    obj.literallyAddPosition(positionObj);
                end
                % If checkIfPulled returns true, that means that the
                % position was fully explored already.
                
            end
            
        end
                
        function removeFromQueue(obj, positionObj)
            % Removes the given point from the queue, if already in queue.
            
            [member, index] = ismember(positionObj.getPosition(), obj.queue_matrix, 'rows');
            
            if(member)
                obj.queue(index) = [];
                obj.queue_matrix(index,:) = [];
                obj.costArray(index) = [];
            end
        end
        
    end
    
    methods (Access = private)
        
        function literallyAddPosition(obj, positionObj)
            % Adds the given position to the queue.
            
            obj.queue = [obj.queue positionObj];
            obj.queue_matrix = [obj.queue_matrix; positionObj.getPosition()];
            obj.costArray = [obj.costArray positionObj.getTotalCost()];
        end
        
    end
    
end

