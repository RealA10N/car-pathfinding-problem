classdef ImprovedRRTAlgorithm < RRTAbstractAlgorithm
    
    methods
    
        function obj = ImprovedRRTAlgorithm(map, stats)
            % Calls superclass constuctor
            obj = obj@RRTAbstractAlgorithm(map, stats, "Improved RRT");
        end
    
    end
    
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = ImprovedRandomPoint(obj.map);
        end
        
    end
end

