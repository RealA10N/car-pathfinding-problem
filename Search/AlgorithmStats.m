classdef AlgorithmStats < handle
    % ALGORITHMSTATS Records and displays stats about every search
    % algorithm.
    
    properties (Access = protected)
        algorithm_obj   % given to the constructor
        algorithm_name  % string
        
        is_running = false;  % boolean: true if the method "search" is running
        timer  % Used with the tic toc command
        
        %% Stats in each run
        path_found = false;
        path_obj = NaN % `Path` object
        steps_to_finish = 0;
        explored = 0;
        queued = 0;
    end
    
    %% Public methods
    
    methods
        %% Constructor
        
        function obj = AlgorithmStats(algorithm)
            obj.algorithm_obj = algorithm;
            obj.algorithm_name = obj.algorithm_obj.getAlgorithmName();  % string
        end

        %% Start and stop recording
       
        function start_recording(obj)
            % Called before starting a search. Resets the counters and
            % starts the timer.
            obj.is_running = true;
            obj.timer = tic();
            
            obj.path_found = false;
            obj.steps_to_finish = 0;
            obj.explored = 0;
            obj.queued = 0;
        end
            
        function stop_recording(obj, path_obj)
            % Called when the search is over. indecates that
            % the search was stopped was completed successfully.

            if (isa(path_obj, 'double'))  % If NaN
                % If path not found
                obj.path_found = false;
                obj.steps_to_finish = NaN;
            else
                % If path found
                obj.path_found = true;
                obj.path_obj = path_obj;
                obj.steps_to_finish = path_obj.path_len();
            end

            if (obj.is_running)
                obj.timer = toc(obj.timer);
                obj.is_running = false;
            end
            
        end
        
        %% Output
        
        function print_stats(obj)
            % Displays the stats of the last algorithm run.
            disp(obj.get_stats_table())
        end
        
        function t = get_stats_table(obj)
            % Returns a table object representing the last algorithm run
            % stats.
            
            t = table(obj.path_found, obj.steps_to_finish, ...
                      obj.explored, obj.queued, obj.timer, ...
            'VariableNames', {'Path found', 'Nodes in path', ...
                        'Explored nodes', 'Queued nodes', 'Run time (s)'}, ...
            'RowNames', cellstr(obj.algorithm_name));
        
        end
        
        function save_path_video(obj, path, filename)
            % Saves the path as a `.mp4` video.
            % Only if a path is found!
            % To save in cwd, but with a custom name, specify path as
            % '' (0 char string).

            
            if obj.path_found
                
                if (nargin < 3)
                    expression = '\W';
                    name = regexprep(obj.algorithm_name, expression, '_');
                    filename = name + "_path.mp4";
                end
                
                if (nargin > 1)
                    filename = fullfile(path, filename);
                end
                
                obj.path_obj.save(filename, obj.algorithm_name)
            end
                
        end
        
        %% Gets
        
        function name = get_algorithm_name(obj)
            name = obj.algorithm_name;
        end
        
        function boolean = get_is_running(obj)
            boolean = obj.is_running;
        end
        
    end
end

