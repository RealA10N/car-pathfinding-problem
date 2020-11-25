classdef ImprovedRRTAlgorithm < RRTAbstractAlgorithm
    
    properties (Access = private)
        beta_dist_v_value = 15;  % default value
    end
    
    methods
    
        function obj = ImprovedRRTAlgorithm(map, beta_dist_v_value)
            % Calls superclass constuctor
            obj = obj@RRTAbstractAlgorithm(map, "Improved RRT");
            
            if (nargin > 1)
                % Save the given beta v value, if given
                % and update the algorithm name
                obj.beta_dist_v_value = beta_dist_v_value;
                obj.name = obj.name + " (v=" + beta_dist_v_value + ")";
            end
        end
    
    end
    
    
    methods (Access = protected)
        
        function random_point = generateRandomPoint(obj)
            % generated and returns a random point object
            random_point = ImprovedRandomPoint(obj.map, obj.beta_dist_v_value);
            random_point.generate()
        end
        
    end
end

