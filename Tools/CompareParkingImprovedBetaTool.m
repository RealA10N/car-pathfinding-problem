classdef CompareParkingImprovedBetaTool < CompareParkingTool
    
    methods
        
        function obj = CompareParkingImprovedBetaTool(test_name)
            obj = obj@CompareParkingTool(test_name);
            
            % Set the algorithms to compare
            obj.algorithm_list = {};
        end
        
        function set_v_values(obj, row_matrix)
            % This function recives inputs from the user, and sets the
            % beta v values to the given ones.
            % If the matrix is not provided, the users will be asked to
            % input the beta values in the console.
            
            if (nargin < 2)
                % Input using console
                
                row_matrix = [];
                
                disp("Enter v values. To stop, enter an invalid value (char for example)")
                cur_in = input('');
                
                while isnumeric(cur_in)
                    row_matrix = [row_matrix, cur_in];
                    cur_in = input('');
                end
                
                disp("Entred v values are: " + mat2str(row_matrix))
            end
            
            obj.algorithm_list = {};
            
            for i=1:size(row_matrix, 2)
                obj.algorithm_list{end+1} = ImprovedRRTAlgorithm(obj.map, row_matrix(i));
            end
            
        end
        
    end
end

