classdef PrmMap < PathMap
    % A PathMap with the abillity to create a probabalistic road map on it.
    
    properties (Access = private)
        randomPoints  % A RandomPoint object list
        randomPointValues  % A matrix containing the x and y of each
                           % point in the randomPoints list
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
            obj.randomPointValues = [];
        end
        
    end
    
    methods (Access = protected)
        
        function plot_all(obj)
            % Plots the car, obstacles, end point and nodes to the graph.
            plot_all@PathMap(obj)
            obj.plot_nodes()
        end
    
        function addRandomNode(obj)
            % Creates one random point, and if the point appears to be in
            % the free space, added it to the saved points array.
            
            point = RandomPoint(obj);
            position = point.getPosition();
            
            obj.randomPoints = [ obj.randomPoints point ];
            obj.randomPointValues = [ obj.randomPointValues; position ];
        end
        
        function plot_nodes(obj)
            % Adds all of the nodes to the graph.
            
            for i=1:length(obj.randomPoints)
                obj.randomPoints(i).plot()
            end
        end
    
    end
    

end