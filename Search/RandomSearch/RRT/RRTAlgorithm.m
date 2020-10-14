classdef RRTAlgorithm < RRTAbstractAlgorithm
    
    methods
    
        function obj = RRTAlgorithm(map, stats)
            % Calls superclass constuctor
            obj = obj@RRTAbstractAlgorithm(map, stats, "RRT");
        end
    
    end
    
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = RandomPoint(obj.map);
        end
        
    end
end

