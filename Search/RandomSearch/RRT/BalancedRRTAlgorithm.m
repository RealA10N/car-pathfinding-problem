classdef BalancedRRTAlgorithm < RRTAbstractAlgorithm
    
    methods
    
        function obj = BalancedRRTAlgorithm(map, stats)
            % Calls superclass constuctor
            obj = obj@RRTAbstractAlgorithm(map, stats, "Balanced RRT");
        end
    
    end
    
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = BalancedRandomPoint(obj.map);
        end
        
    end
end

