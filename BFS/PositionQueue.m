classdef PositionQueue < handle
    % Stores an array of car positions.
    % Knows how to compare them, sort them,
    % and pull in and out positions.
    
    properties (Access = protected)
        queue
        pullPosition
    end
    
    methods
        function obj = PositionQueue()
            % by deafult, the queue will be empty.
            obj.queue = [];
            obj.pullPosition = 0;
        end
        
        function addPosition(obj, positionObj)
            % Adds a position object to the queue
            obj.queue = [obj.queue positionObj];
        end
        
        function nextPos = pullOut(obj)
            % Pulls out the next position in order
            % and removes it from the queue
            obj.pullPosition = obj.pullPosition + 1;
            nextPos = obj.queue(obj.pullPosition);
        end
        
        function boolean = isEmpty(obj)
            % returns true if the queue is empty
            % and false if contains at least one position.
            boolean = isempty(obj.queue);
        end
        
        function boolean = checkInQueue(obj, positionObj)
            % returns true if position object already in the queue.
           
            boolean = false;
            for k=1:length(obj.queue)
                curPos = obj.queue(k);
                
                if (positionObj.ifEqual(curPos))
                    boolean = true;
                    break
                end
            end
            
        end
        
    end
end

