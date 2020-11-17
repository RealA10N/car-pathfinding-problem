classdef BalancedRRTAlgorithm < RRTAbstractAlgorithm
    
    methods
    
        function obj = BalancedRRTAlgorithm(map)
            % Calls superclass constuctor
            obj = obj@RRTAbstractAlgorithm(map, 'Balanced RRT');
        end
    
    end
    
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = BalancedRandomPoint(obj.map);
            random_point.generate()
        end
        
    end
end

