classdef ImprovedRandomPoint < RandomPoint
    % when created, generates a random point on the map and saves it.
    
    methods (Access=protected)
        
        function value = getRandomPointXY(~, goal_value, mapObj)
            % Returns a 'smart' random dimention of the point (x or y).
            % This size leans towards the goal point.
            
            mu = goal_value / mapObj.getSize();
            v = 5;
            
            beta_A = mu * v;
            beta_B = (1 - mu) * v;
            
            value = betarnd(beta_A, beta_B);
            value = value * mapObj.getSize();
            
        end

                
        function value = getRandomPointRotation(~, goal_rotation)
            % Returns a smart random rotation (number) between 0 and 360
            
            goal_rotation = mod(goal_rotation, 360);
            mu = 0;
            sigma = 90;
            
            value = normrnd(mu, sigma);
            value = value + goal_rotation;
            value = mod(value, 360);
            
        end
    end

end