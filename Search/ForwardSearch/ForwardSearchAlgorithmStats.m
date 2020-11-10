classdef ForwardSearchAlgorithmStats < AlgorithmStats
    % Records and displays stats about every forward search run.
    
    
    methods
        
        function stop_recording(obj, path_obj, queue)
            % Stop recording, and save the run stats.
            
            stop_recording@AlgorithmStats(obj, path_obj)
            obj.save_explored_positions(queue)
            obj.save_queued_positions(queue)         
        end
        
    end
    
    methods (Access = private)
        
        function save_explored_positions(obj, queue)
            % Calculates and saves the number of explored positions.
            obj.explored = queue.getPulledCount();
        end
        
        function save_queued_positions(obj, queue)
            % Calculates and saves the number of explored positions.
            obj.queued = queue.getQueuedCount();
        end
    end

end

