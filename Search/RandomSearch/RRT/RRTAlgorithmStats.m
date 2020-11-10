classdef RRTAlgorithmStats < AlgorithmStats
    % Records and displays stats about every RRT search run.
    
    methods
        
        function stop_recording(obj, path_obj, tree)
            % Stop recording, and save the run stats.
            
            stop_recording@AlgorithmStats(obj, path_obj)
            obj.save_explored_positions(tree)
            obj.save_queued_positions()         
        end
        
    end
    
    methods (Access = private)
        
        function save_explored_positions(obj, tree)
            % Calculates and saves the number of explored positions.
            obj.explored = tree.getTreeSize();
        end
        
        function save_queued_positions(obj)
            % Saves NaN: No queued positions in the RRT algorithm!
            obj.queued = NaN;
        end
    end

end

