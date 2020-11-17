classdef ImprovedRRTAlgorithm < RRTAbstractAlgorithm
    
    methods
    
        function obj = ImprovedRRTAlgorithm(map)
            % Calls superclass constuctor
            obj = obj@RRTAbstractAlgorithm(map, 'Improved RRT');
        end
    
    end
    
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = ImprovedRandomPoint(obj.map);
            random_point.generate()
        end
        
    end
end

