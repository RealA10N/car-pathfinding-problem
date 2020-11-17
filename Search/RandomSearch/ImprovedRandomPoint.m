classdef ImprovedRandomPoint < RandomPoint
    % when created, generates a random point on the map and saves it.
    
    properties (Access = protected)
        v;
    end
    
    methods
        
        function obj = ImprovedRandomPoint(mapObj, v)
            obj = obj@RandomPoint(mapObj);
            
            if (nargin < 2)
                obj.v = 15;
            else
                obj.v = v;
            end
        end
        
        function generate(obj)
            endpoint = obj.mapObj.getend();
            % Generate random x, y and rotation            
            obj.x = obj.getRandomPointXY(endpoint(1));
            obj.y = obj.getRandomPointXY(endpoint(2));
            obj.rotation = obj.getRandomPointRotation(endpoint(3));              
        end
    end
    
    methods (Access=protected)
        
        function value = getRandomPointXY(obj, goal_value)
            % Returns a 'smart' random dimention of the point (x or y).
            % This size leans towards the goal point.
            
            mu = goal_value / obj.mapObj.getSize();
            
            beta_A = mu * obj.v;
            beta_B = (1 - mu) * obj.v;
            
            value = betarnd(beta_A, beta_B);
            value = value * obj.mapObj.getSize();
            
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