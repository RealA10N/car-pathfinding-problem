classdef (Abstract) PositionQueue < handle
    % Stores an array of car positions.
    % Knows how to compare them, sort them,
    % and pull in and out positions.
    
    properties (Access = protected)
        queue   % The queue
        queue_matrix
        pulled  % Position that were queued and pulled out
        pulled_matrix
    end
    
    methods (Abstract)
        addPosition(obj, positionObj)
        nextPos = pullOut(obj)
    end
    
    methods
        function obj = PositionQueue()
            % by deafult, the queue will be empty.
            obj.queue = [];
            obj.queue_matrix = [];
            
            obj.pulled = [];
            obj.pulled_matrix = [];
        end
        
        function boolean = isEmpty(obj)
            % Returns true if the queue is empty
            % and false if contains at least one position.
            boolean = isempty(obj.queue);
        end
        
        function boolean = isPulledEmpty(obj)
            % returns true if not even one position was pulled out from the
            % queue.
            
            boolean = isempty(obj.pulled);
        end
        
        function boolean = checkInQueue(obj, positionObj)
            % returns true if position object already in the queue.
            
            if (obj.isEmpty())
                boolean = false;
                return
            end
            
            boolean = ismember(positionObj.getPosition(), obj.queue_matrix, 'rows');
        end
        
        function boolean = checkIfPulled(obj, positionObj)
            % Returns true if the given object appers in the pulled list.
            
            if (obj.isPulledEmpty())
                boolean = false;
                return
            end
            
            boolean = ismember(positionObj.getPosition(), obj.pulled_matrix, 'rows');
        end
        
        function boolean = checkIfEncountered(obj, positionObj)
            % Returns true if the given position appers in the queue OR
            % appeared in it in the past.
            
            boolean = obj.checkInQueue(positionObj) ...
                || obj.checkIfPulled(positionObj);
        end
        
        function removeFromQueue(obj, positionObj)
            % Removes the given point from the queue, if already in queue.
            
            [member, index] = ismember(positionObj.getPosition(), obj.queue_matrix, 'rows');
            
            if(member)
                obj.queue(index) = [];
                obj.queue_matrix(index,:) = [];
            end
        end
        
        function count = getPulledCount(obj)
            % Returns the number of the positions that are fully explored.
            count = length(obj.pulled);
        end
        
        function count = getQueuedCount(obj)
            % Returns the number of the position currently in the queue.
            count = length(obj.queue);
        end
            
        
        function show(obj)
            % Uses the "scatter3" function to show every visited, queued
            % and explored position in the search.
            
            clf
            marker_size = 100;
         
            x = []; y = []; rotation = []; color = [];
            
            % Add the queued points
            matsize = size(obj.queue_matrix());
            if (matsize(1) > 0)
                x = obj.queue_matrix(:,1)';
                y = obj.queue_matrix(:,2)';
                rotation = obj.queue_matrix(:,3)';
                color = [1 0.7 0.67];
                
                hold on
                scatter3(x, y, rotation, marker_size, color, 'filled')
                hold off
                
            end
            
            % Add the visited pointes
            matsize = size(obj.pulled_matrix());
            if (matsize(1) > 0)
                x = obj.pulled_matrix(:,1)';
                y = obj.pulled_matrix(:,2)';
                rotation = obj.pulled_matrix(:,3)';
                color = [0.125 0.65 0.65];
                
                hold on
                scatter3(x, y, rotation, marker_size, color, 'filled')
                hold off
            end
            
            % Show the graph
            % scatter3(x, y, rotation, 100, color, 'filled');
            legend(["Visited", "In queue"],'Location','Best');

            
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

