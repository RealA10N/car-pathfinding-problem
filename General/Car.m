classdef Car < Shape
    % Defines a car in the plot.
    % The car's position depends on 3 properties:
    % x position, y position and rotation.
    
    properties (SetAccess = protected, GetAccess = public)
        % Properties of the car
        xPos
        yPos
        Rotation
    end
    
    properties (Access = protected)
        % Generates the shape of the car by default (Facing right)
        % The middle of the car is (0,0)
        defaultVertices = [2 1; 1 0; 2 -1; -2 -1; -2 1]
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
        
        function move(obj, jump, rotation)
            % Moves the car the 'jump' length, in the angle 'rotation'.
            % Notice that the car is first rotated, and only then moved.
            obj.rotate(rotation)
            obj.jump(jump)
        end
        
        function rotate(obj, rotation)
            % Rotates the car in the angle 'rotation'.
            obj.Rotation = obj.Rotation + rotation;
        end
        
        function jump(obj, length)
            % Moves the car forward with given length.
            obj.xPos = obj.xPos + (cosd(obj.Rotation) * length);
            obj.yPos = obj.yPos + (sind(obj.Rotation) * length);
        end
        
        function move_xy(obj, x, y)
            % Moves the car in 2d
            obj.xPos = obj.xPos + x;
            obj.yPos = obj.yPos + y;
        
        end
        
        function move_8directions(obj, length)
            % Moves the car only in jumps of 45deg.
            % if car is rotated on the axis, will jump
            % only on one of the axis. If the car faced
            % in an 45deg angle from the axis, the car
            % will jump on both of them to the faced direction.
            
            rotation = mod(obj.Rotation, 360);
            
            % Y axis
            if (rotation > 0 && rotation < 180)
                % if facing up
                obj.yPos = obj.yPos + length;
            elseif (rotation > 180)
                % if facing down
                obj.yPos = obj.yPos - length;
            end
            
            % X axis
            if (rotation > 90 && rotation < 270)
                % if facing left
                obj.xPos = obj.xPos - length;
            elseif (rotation < 90 || rotation > 270)
                % if facing right
                obj.xPos = obj.xPos + length;
            end
                
            
        end
        
        function teleport(obj, xPos, yPos, rotation)
            % Moves the car to the given position.
            obj.Rotation = rotation;
            obj.xPos = xPos;
            obj.yPos = yPos;
        end

        
    end
    
    methods (Access = private)
        
        function [x, y] = calc_vertex(obj, startVertex)
            % Returns the new location of a given vertex
            % in the current position (x, y, rotation) of the car
            
            r = sqrt(sum(startVertex.^2));
            extraAngle = atan2d(startVertex(1), startVertex(2));
            
            x = (sind(extraAngle - obj.Rotation) * r) + obj.xPos;
            y = (cosd(extraAngle - obj.Rotation) * r) + obj.yPos;
        end
        
    end
    
end

