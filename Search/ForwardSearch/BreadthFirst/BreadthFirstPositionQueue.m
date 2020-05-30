classdef BreadthFirstPositionQueue < PositionQueue
    % Stores an array of car positions.
    % Knows how to compare them, sort them,
    % and pull in and out positions.
    
    methods
        
        function addPosition(obj, positionObj)
            % Adds a position object to the queue
            
            if (~obj.checkIfEncountered(positionObj))
                obj.queue = [obj.queue positionObj];
                obj.queue_matrix = [obj.queue_matrix; positionObj.getPosition()];
            end
        end
        
        function nextPos = pullOut(obj)
            % Pulls out the next position in order
            % and removes it from the queue.
            % The pulled out point is added to the "pulledPoints" array
            
            obj.pulled = [obj.pulled obj.queue(1)];  % Add item to pulled list
            obj.pulled_matrix = [obj.pulled_matrix; obj.queue_matrix(1,:)];
            
            nextPos = obj.queue(1);
            
            obj.queue(1) = []; % Remove item from queue list
            obj.queue_matrix(1,:) = [];
        end
        
    end

end

