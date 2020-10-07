classdef SmartRandomPoint < RandomPoint
    % when created, generates a random point on the map and saves it.
    
    methods (Access=protected)
        
        function size = getRandomPointXY(~, goal_value, mapObj)
            % Returns a 'smart' random dimention of the point (x or y).
            % This size leans towards the goal point.
            
            mu = goal_value / mapObj.getSize();
            v = 2;
            
            beta_dist_A = mu * v;
            beta_dist_B = (1 - mu) * v;
            
            size = betarnd(beta_dist_A, beta_dist_B);
            size = size * mapObj.getSize();
            
        end
    end

end