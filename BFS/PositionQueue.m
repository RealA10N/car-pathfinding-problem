classdef PositionQueue < handle
    % Stores an array of car positions.
    % Knows how to compare them, sort them,
    % and pull in and out positions.
    
    properties (Access = protected)
        queue   % The queue
        pulled  % Position that were queued and pulled out
    end
    
    methods
        function obj = PositionQueue()
            % by deafult, the queue will be empty.
            obj.queue = [];
            obj.pulled = [];
        end
        
        function addPosition(obj, positionObj)
            % Adds a position object to the queue
            obj.queue = [obj.queue positionObj];
        end
        
        function nextPos = pullOut(obj)
            % Pulls out the next position in order
            % and removes it from the queue.
            % The pulled out point is added to the "pulledPoints" array
            obj.pulled = [obj.pulled obj.queue(1)];
            nextPos = obj.queue(1);
            obj.queue(1) = [];
        end
        
        function boolean = isEmpty(obj)
            % Returns true if the queue is empty
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
        
        function boolean = checkIfPulled(obj, positionObj)
            % Returns true if the given object appers in the pulled list.
            
            boolean = false;
            for k=1:length(obj.pulled)
                curPos = obj.pulled(k);
                
                if (positionObj.ifEqual(curPos))
                    boolean = true;
                    break
                end
            end
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

