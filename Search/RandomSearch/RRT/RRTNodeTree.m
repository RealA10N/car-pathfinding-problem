classdef RRTNodeTree < handle
    % The queue that is used in the RRT algorithm.
    
    properties (Access = protected)
        tree
        tree_matrix
        
        parent_algorithm
    end
    
    methods
        function obj = RRTNodeTree(parent)
            % Creates an empty node tree.
            obj.tree = [];
            obj.tree_matrix = [];
            
            obj.parent_algorithm = parent;
        end
        
        function addPosition(obj, positionObj)
            % Add the given position to the tree.
            obj.tree = [obj.tree positionObj];
            obj.tree_matrix = [obj.tree_matrix; positionObj.getPosition()];
        end
        
        function nearestPosition = getNearPosition(obj, positionObj)
            % Returns the closest position to the given one in the tree.            
            
            % Creates a distances array (with zeros).
            distances = zeros(1, length(obj.tree));
            
            % Loops over each node in the tree
            for i=1:length(obj.tree)
                % For each node calculate the distance between the node and
                % the given position
                distances(i) = obj.parent_algorithm.twoNodesDistance(positionObj, obj.tree(i));
            end
            
            [~, nearestIndex] = min(distances);
            nearestPosition = obj.tree(nearestIndex);
        end
    end
end

