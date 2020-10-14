classdef BalancedRandomPoint < RandomPoint
    % when created, generates a random yet balanced point on the map and saves it.
    
    properties (Access = private, Constant)
        completly_random_weight = .5;
    end
    
    methods
        
        function obj = BalancedRandomPoint(mapObj)
            % Decide if the point is random or improved:
            
            obj = obj@RandomPoint(mapObj);
            
            if rand() < BalancedRandomPoint.completly_random_weight
                point = RandomPoint(mapObj);
            else
                point = ImprovedRandomPoint(mapObj);
            end
            
            position = point.getPosition();
            obj.x = position(1);
            obj.y = position(2);
            obj.rotation = position(3);
        end

    end

end