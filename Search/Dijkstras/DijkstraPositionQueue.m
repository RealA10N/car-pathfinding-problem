classdef DijkstraPositionQueue < PositionQueue
    % Saves the given car position,
    % +the total cost from the start position.
    
    properties (Access = protected)
        costArray
    end
    
    methods
        
        function obj = DijkstraPositionQueue()
            % Calls "PositionQueue" constructor
            % Creates new cost array, for more efficient search.
            
            obj = obj@PositionQueue();
            obj.costArray = [];
        end
        
        function addPosition(obj, positionObj)
            % Adds a position object to the queue
            % and adds the cost of the given position to the cost array.
            
            obj.queue = [obj.queue positionObj];
            obj.queue_matrix = [obj.queue_matrix; positionObj.getPosition()];
            obj.costArray = [obj.costArray positionObj.getCost()];
        end
        
        function nextPos = pullOut(obj)
            % Pulls out the lowest cost position
            % and removes it from the queue.
            % The pulled out point is added to the "pulledPoints" array
            
            lowest_cost = min(obj.costArray);
            lowest_index = find(obj.costArray == lowest_cost);
            
            obj.pulled = [obj.pulled obj.queue(lowest_index)];  % Add item to pulled list
            obj.pulled_matrix = [obj.pulled_matrix; obj.queue_matrix(lowest_index,:)];
            
            nextPos = obj.queue(lowest_index);
            
            obj.queue(lowest_index) = []; % Remove item from queue list
            obj.queue_matrix(lowest_index,:) = [];
        end
        
    end
end

