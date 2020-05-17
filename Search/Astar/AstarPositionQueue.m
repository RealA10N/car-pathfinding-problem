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
            
            if(~isempty(positionFromQueue))
                % if already visited same position -> checks cost and
                % updates if needed!
                
                if(positionObj.getCost() < positionFromQueue.getCost())
                    obj.removeFromQueue(positionFromQueue);
                    obj.literallyAddPosition(positionObj);
                end
                
            else
                obj.literallyAddPosition(positionObj);
            end
        end
        
        function nextPos = pullOut(obj)
            % Pulls out the lowest cost position
            % and removes it from the queue.
            % The pulled out point is added to the "pulledPoints" array
            
            lowest_cost = min(obj.costArray);
            lowest_index = find(obj.costArray == lowest_cost);
            
            if (length(lowest_index) > 1)
                lowest_index = lowest_index(1);
            end
            
            obj.pulled = [obj.pulled obj.queue(lowest_index)];  % Add item to pulled list
            obj.pulled_matrix = [obj.pulled_matrix; obj.queue_matrix(lowest_index,:)];
            
            nextPos = obj.queue(lowest_index);
            
            obj.queue(lowest_index) = []; % Remove item from queue list
            obj.queue_matrix(lowest_index,:) = [];
            obj.costArray(lowest_index) = [];
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
    
    methods (Access = protected)
                
        function position = getPositionInQueue(obj, positionObj)
            % Returns the saved position in the queue, that has the same
            % xyz as the given position. if not in queue, returns [].
            
            if (obj.isEmpty())
                position = [];
                return
            end
            
            [ifmember, index] = ismember(positionObj.getPosition(), obj.queue_matrix, 'rows');
            
            if(ifmember)
                position = obj.queue(index);
            else
                position = [];
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

