classdef PositionQueue < handle
    % Stores an array of car positions.
    % Knows how to compare them, sort them,
    % and pull in and out positions.
    
    properties (Access = public)
        queue   % The queue
        queue_matrix
        pulled  % Position that were queued and pulled out
        pulled_matrix
    end
    
    methods
        function obj = PositionQueue()
            % by deafult, the queue will be empty.
            obj.queue = [];
            obj.queue_matrix = [];
            
            obj.pulled = [];
            obj.pulled_matrix = [];
        end
        
        function addPosition(obj, positionObj)
            % Adds a position object to the queue
            obj.queue = [obj.queue positionObj];
            obj.queue_matrix = [obj.queue_matrix; positionObj.getPosition()];
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
        
        function boolean = isEmpty(obj)
            % Returns true if the queue is empty
            % and false if contains at least one position.
            boolean = isempty(obj.queue);
        end
        
        function boolean = checkInQueue(obj, positionObj)
            % returns true if position object already in the queue.           
            boolean = ismember(positionObj.getPosition(), obj.queue_matrix, 'rows');
        end
        
        function boolean = checkIfPulled(obj, positionObj)
            % Returns true if the given object appers in the pulled list.
            boolean = ismember(positionObj.getPosition(), obj.pulled_matrix, 'rows');
        end
        
        function boolean = checkIfEncountered(obj, positionObj)
            % Returns true if the given position appers in the queue OR
            % appeared in it in the past.
            
            boolean = obj.checkInQueue(positionObj) ...
                || obj.checkIfPulled(positionObj);
        end
        
    end
    
    methods (Static)
        
        function distance = distanceTwoPoints(posObj1, posObj2)
            % Returns the distance between two points (xy only)
            % Euclidean distance
            points = [posObj1.xPos posObj1.yPos; posObj2.xPos posObj2.yPos];
            distance = pdist(points);
        end
        
    end
end

