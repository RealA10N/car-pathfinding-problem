classdef Car < Shape
    % Defines a car in the plot.
    % The car's position depends on 3 properties:
    % x position, y position and rotation.
    
    properties
        % Properties of the car
        xPos
        yPos
        Rotation
    end
    
    properties (Access = protected)
        % Generates the shape of the car by default (Facing right)
        % The middle of the car is (0,0)
        defaultVertices = [2 1; 1 0; 2 -1; -2 -1; -2 1]
        
        % Discretization settings
        posJumps = 0.1
        
    end
    
    
    methods
        
        function obj = Car(xStart, yStart, rotStart)
            % Defines the starting position of the car
            
            obj.xPos = xStart;
            obj.yPos = yStart;
            obj.Rotation = rotStart;
        end
        
        function vertices = update(obj)
            % Calculate car's vertices locations in the
            % current position (x, y, rotation) of the car
    
            obj.vertices = [];
            for i = 1:length(obj.defaultVertices)
                [x, y] = obj.calc_vertex(obj.defaultVertices(i,:));
                obj.vertices = [obj.vertices; x y];
            end
            vertices = obj.vertices;
        end
        
        function move(obj, steps, rotation)
            % Moves the car one step (obj.posJump) with the given rotation
            % and steps.
                        
            obj.Rotation = obj.Rotation + rotation;
            obj.xPos = obj.xPos + ((cos(obj.Rotation) * obj.posJumps) * steps);
            obj.yPos = obj.yPos + ((sin(obj.Rotation) * obj.posJumps) * steps);
        end
        
    end
    
    methods (Access = private)
        
        function [x, y] = calc_vertex(obj, startVertex)
            % Returns the new location of a given vertex
            % in the current position (x, y, rotation) of the car
            
            r = sqrt(sum(startVertex.^2));
            extraAngle = atan2(startVertex(1), startVertex(2));
            
            x = (sin(extraAngle - obj.Rotation) * r) + obj.xPos;
            y = (cos(extraAngle - obj.Rotation) * r) + obj.yPos;
        end
        
    end
    
end

