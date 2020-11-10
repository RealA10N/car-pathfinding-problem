classdef Path
    %PATH Is an object that saves the path of the car.
    %   It can show the path in a [x,y,z] table, or even
    %   animate it.
    
    properties (Access = protected)
        path_matrix = []
        map
        car
    end
    
    properties (Access = protected, Constant)
        TIME_BETWEEN_STEPS = 0.25  % seconds, between each 'frame' of path animation
    
    end
    
    methods
        
        function obj = Path(map, path_matrix)
            % `path_matrix` is a matrix with 3 columns.
            % The first column represents the x position of the car
            % in each step, the second one represents the y postion,
            % and the third represents the rotation of the car (in
            % degrees).
            % The first row represents the starting point of the path.
            
            obj.map = map;
            obj.car = map.getCar();
            
            if (nargin > 1)
                % Saves the path, if given
                obj.path_matrix = path_matrix;
            end
            
        end
        
        function obj = add_step(obj)
            % Saves the current car position to the path.
            cur_pos = [obj.car.xPos, obj.car.yPos, obj.car.Rotation];
            obj.path_matrix = [obj.path_matrix; cur_pos];
        end
        
        function show(obj)
            % Shows the path animation.
            
            x = obj.car.xPos;
            y = obj.car.yPos;
            r = obj.car.Rotation;
                
            for i=1:size(obj.path_matrix, 1)
                cur_pos = obj.path_matrix(i, :);
                cur_x = cur_pos(1);
                cur_y = cur_pos(2);
                cur_rot = cur_pos(3);
                
                obj.car.teleport(cur_x, cur_y, cur_rot)
                obj.map.generate()
                pause(obj.TIME_BETWEEN_STEPS)
            end
            
            pause
            obj.car.teleport(x, y, r)
            obj.map.generate()
        end
        
        function save(obj, filename, fig_title)
            % Save the path as a video file.
            
            x = obj.car.xPos;
            y = obj.car.yPos;
            r = obj.car.Rotation;
            
            v = VideoWriter(filename, 'MPEG-4');
            v.FrameRate = 1 / obj.TIME_BETWEEN_STEPS;
            v.Quality = 100;
            
            open(v)
            
            for i=1:size(obj.path_matrix, 1)
                cur_pos = obj.path_matrix(i, :);
                cur_x = cur_pos(1);
                cur_y = cur_pos(2);
                cur_rot = cur_pos(3);
                
                obj.car.teleport(cur_x, cur_y, cur_rot)
                obj.map.generate()
                
                if (nargin > 2)
                    title(fig_title)
                end
                
                writeVideo(v, getframe(gcf));
            end
            
            close(v)
            obj.car.teleport(x, y, r)
            obj.map.generate()
        end
        
        function int = path_len(obj)
            % Returns the length of the path.
            int = size(obj.path_matrix, 1);
        end
        
    end
end

