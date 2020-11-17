classdef BalancedRandomPoint < RandomPoint
    % when created, generates a random yet balanced point on the map and saves it.
    
    properties (Access = protected)
        v
    end
    
    properties (Access = private, Constant)
        completly_random_weight = .5;
    end
    
    methods
        
        function obj = BalancedRandomPoint(mapObj, v)

            obj = obj@RandomPoint(mapObj);
            
            if (nargin < 2)
                obj.v = 15;
            else
                obj.v = v;
            end
        end
        
        function generate(obj)
            if rand() < BalancedRandomPoint.completly_random_weight
                point = RandomPoint(obj.mapObj);
            else
                point = ImprovedRandomPoint(obj.mapObj);
            end
            
            position = point.getPosition();
            obj.x = position(1);
            obj.y = position(2);
            obj.rotation = position(3);
        end

    end

end