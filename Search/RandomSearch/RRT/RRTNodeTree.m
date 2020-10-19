classdef RRTNodeTree < handle
    % The queue that is used in the RRT algorithm.
    
    properties (Access = protected)
        tree
        tree_matrix
        
        parent_algorithm
        map
    end
    
    methods
        function obj = RRTNodeTree(parent, map)
            % Creates an empty node tree.
            obj.tree = [];
            obj.tree_matrix = [];
            
            obj.parent_algorithm = parent;
            obj.map = map;
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
            distances = inf(length(obj.tree),1);
            parfor i=1:length(obj.tree)
                % For each node calculate the distance between the node and
                % the given position
                distances(i) = obj.parent_algorithm.twoNodesDistance(positionObj, obj.tree(i));
            end
            
            [~, nearestIndex] = min(distances);
            nearestPosition = obj.tree(nearestIndex);
        end
        
        function show_debug_fig(obj, rnd_point)
            % Show the debug figure: contains all the explored positions
            % and the current random one.
            
            % Configure colors
            start_end_color = [0 1 0]; % green
            start_end_size = 40;
            explored_color = [0 0 1];  % blue
            random_point_color = [1 0 0];  % red
            other_size = 20;
            
            % Add start and end positions
            start_pos = obj.tree_matrix(1, :);
            end_pos = obj.map.getend();
            
            % Get current random position
            rnd_position = rnd_point.getPosition();
            
            % Combine all
            X = [start_pos(:, 1); end_pos(:, 1); obj.tree_matrix(:, 1); rnd_position(:, 1)];
            Y = [start_pos(:, 2); end_pos(:, 2); obj.tree_matrix(:, 2); rnd_position(:, 2)];
            Z = [start_pos(:, 3); end_pos(:, 3); obj.tree_matrix(:, 3); rnd_position(:, 3)];
            
            SIZE = [repmat(start_end_size, 1, 2) ...
                repmat(other_size, 1, size(obj.tree_matrix, 1))  ...
                other_size];
            
            COLOR = [repmat(start_end_color, 2, 1);  ...
                repmat(explored_color, size(obj.tree_matrix, 1), 1);  ...
                random_point_color];
            
            % plot
            scatter3(X, Y, Z, SIZE, COLOR)
            
            % Configure the figure
            xlim([0 obj.map.getSize()])
            ylim([0 obj.map.getSize()])
            zlim([0 360])
            
        
        end
    end
end

