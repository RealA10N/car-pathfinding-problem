classdef RRTAlgorithmStats < AlgorithmStats
    % Records and displays stats about every RRT search run.
    
    methods
        
        function stop_recording(obj, path_found, tree, end_pos)
            % Stop recording, and save the run stats.
            
            stop_recording@AlgorithmStats(obj, path_found)
            obj.save_path_len(end_pos)
            obj.save_explored_positions(tree)
            obj.save_queued_positions()         
        end
        
    end
    
    methods (Access = private)
    
        function save_path_len(obj, pos)
            % Calculates and saved the length of the found path
            
            if obj.path_found
                
                % If path found, calculate the path length
                len = 0;

                while(pos.ifLastPosition())
                    pos = pos.lastPos;  
                    len = len + 1;
                end     

                obj.steps_to_finish = len;
            
            else
                
                % If path not found, set steps to finish to infinite.
                obj.steps_to_finish = NaN;
                
            end
            
        end
        
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

