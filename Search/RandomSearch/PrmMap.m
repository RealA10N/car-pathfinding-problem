classdef PrmMap < PathMap
    % A PathMap with the abillity to create a probabalistic road map on it.
    
    properties (Access = private)
        randomPoints  % A RandomPoint object list
        randomPointsMatrix  % A matrix containing the x and y of each
                            % point in the randomPoints list
        randomEdges  % A RandomEdge object list
    end
    
    methods
    
        function addRandomNodes(obj, amount)
            % Tries to add the given amount of random points to the prm map
            % If, for example, amount = 30, and there are two points that
            % generated the same x and y, then the final amount of added
            % points will be 29.
            
            for i=1:amount
                obj.addRandomNode()
            end
            
        end
        
        function clearNodes(obj)
            % Clears all the nodes in the map. used when a new obstacle
            obj.randomPoints = [];
            obj.randomPointsMatrix = [];
            obj.randomEdges = [];
        end
        
    end
    
    methods (Access = protected)
        
        function plot_all(obj)
            % Plots the car, obstacles, end point and nodes to the graph.
            plot_all@PathMap(obj)
            obj.plot_edges()
            obj.plot_nodes()
        end
    
        function addRandomNode(obj)
            % Creates one random point, and if the point appears to be in
            % the free space, added it to the saved points array.
            
            point = RandomPoint(obj);
            [x, y] = point.getPosition();
            
            if (~isempty(obj.randomPoints))
                % if not the first point added
                if (ismember([x, y], obj.randomPointsMatrix, 'rows'))
                    % if point already added
                    return;
                end
            end
            
            % If the random generated point is not in the randomPoints
            % array, which means it is not generated already.
            
            closest_edges = obj.closest_edges_to_point(point, 3);
            
            % Delete edges that are already saved
            for i=1:length(closest_edges)
                if (obj.if_edge_saved(closest_edges(i)))
                    closest_edges(i) = [];
                end
            end
            
            obj.randomPoints = [ obj.randomPoints point ];
            obj.randomPointsMatrix = [ obj.randomPointsMatrix; x, y ];
            obj.randomEdges = [ obj.randomEdges closest_edges ];
        end
        
        function plot_nodes(obj)
            % Adds all of the nodes to the graph.
            
            for i=1:length(obj.randomPoints)
                obj.randomPoints(i).plot()
            end
        end
        
        function boolean = if_edge_saved(obj, edge)
            % Returns true if the given edge is already saved in the map.
            
            for i=1:length(obj.randomEdges)
                if (PrmMap.compareEdges(edge, obj.randomEdges(i)))
                    boolean = true;
                    return;
                end
            end
            
            boolean = false;
        end
                
        function list = closest_edges_to_point(obj, pointObj, numOfEdges)
            % Returns a list with edges that are close to the given point.
            
            points = obj.closest_points_to_point(pointObj, numOfEdges);
            
            list = [];
            for i=1:length(points)
                edge = RandomEdge(pointObj, points(i));
                list = [list edge];
            end
        end
        
        function list = closest_points_to_point(obj, pointObj, numOfPoints)
            % Returns a list with points that are close to the given point.
            
            numOfPoints = min(numOfPoints, length(obj.randomPoints));
            
            distances = obj.distance_from_points(pointObj);
            
            list = [];
            for i=1:numOfPoints
                closest_i = find(distances == min(distances));
                list = [list obj.randomPoints(closest_i)];
                distances(closest_i) = inf;
            end
        end
        
        function distance_arr = distance_from_points(obj, pointObj)
            % Repeats over all of the saved random points and returns an
            % array of the distances from the point to each other point.
            % The array is not sorted and the indexs are the same as the
            % saved randomPoints and randomPointsMatrix.
            
            [x, y] = pointObj.getPosition();
            distance_arr = [];
            
            for i=1:length(obj.randomPoints)
                cur_point = obj.randomPointsMatrix(i,:);
                cur_distance = norm(cur_point - [x, y]);
                distance_arr = [distance_arr cur_distance];
            end
        end
        
        function plot_edges(obj)
            % Plots the edges between the random nodes onto the map.
            for i=1:length(obj.randomEdges)
                edge = obj.randomEdges(i);
                edge.plot()
            end
        end
    
    end
    
    methods (Static)
        
        function boolean = compareEdges(edgeOne, edgeTwo)
            % Returns true if the given edges are equal.
            
            [edge1point1, edge1point2] = edgeOne.getPoints();
            [edge2point1, edge2point2] = edgeTwo.getPoints();
            
            if (PrmMap.comparePoints(edge1point1, edge2point1) ...
                    && PrmMap.comparePoints(edge1point2, edge2point2))
                boolean = true;
            elseif (PrmMap.comparePoints(edge1point1, edge2point2) ...
                    && PrmMap.comparePoints(edge1point2, edge2point1))
                boolean = true;
            else
                boolean = false;
            end
        end
        
        function boolean = comparePoints(pointOne, pointTwo)
            % Return true if the given points are equal.
            [x1, y1] = pointOne.getPosition();
            [x2, y2] = pointTwo.getPosition();
            boolean = x1 == x2 && y1 == y2;
        end
        
            
        
    end
end