classdef CompareTool < Main
    %COMPARETOOL Is used to compare different algorithms on the same problems,
    % and save the results and figures of each algorithm!
    
    properties
        test_name
    end
    
    properties (Access = protected)
        
        % Configure strings
        OUTPUT_FOLDER = "CompareOutputs"
        PATHS_OUTPUT_FOLDER = "Paths"
        FIG_FILE_EXTANTION = "_figure.fig"
        PATH_FIGS_FILE_EXTANTION = "_path.fig"
        TABLE_FILE_EXTANTION = "_table.xlsx"

    end
    
    methods
        
        function obj = CompareTool(test_name, size)
            
            % If the size of the map is not given
            if (nargin < 2)
                size = 20;
            end
            
            obj@Main(size)            
            obj.test_name = test_name;            
            
            % Set the algorithms to compare
            obj.algorithm_list = { ...
                BreadthFirstAlgorithm(obj.map), ...
                AstarAlgorithm(obj.map), ...
                RRTAlgorithm(obj.map), ...
                ImprovedRRTAlgorithm(obj.map), ...
                BalancedRRTAlgorithm(obj.map) ...
            };
        end
        
        function compare(obj)
            % Start comparing the algorithms!
            % Output files will be saved in the output folder.
            
            output_folder = fullfile(obj.OUTPUT_FOLDER, obj.test_name);
            paths_output_folder = fullfile(output_folder, obj.PATHS_OUTPUT_FOLDER);
            mkdir(output_folder)
            mkdir(paths_output_folder)
            
            % Generate a figure and save the starting position image
            obj.map.generate()
            savefig(fullfile(output_folder, obj.test_name + obj.FIG_FILE_EXTANTION))
            
            table = [];
            
            % loop over each algorithm
            for i=1:length(obj.algorithm_list)
                
                % append current algorithm stats table to the tables list
                statObj = obj.search(false, false, i);
                table = [table; statObj.get_stats_table()];
                
                % Save the figure
                alg_name = convertStringsToChars(obj.algorithm_list{i}.getAlgorithmName());
                alg_fixed_name = alg_name(isstrprop(alg_name, 'alpha'));
                savefig(fullfile(paths_output_folder, alg_fixed_name + obj.PATH_FIGS_FILE_EXTANTION));
                
            end
            
            % Save the final stats table
            writetable(table, fullfile(output_folder, obj.test_name + obj.TABLE_FILE_EXTANTION), ...
                       'WriteRowNames', true)
            disp(table);
            
        end
        
    end
    
    methods (Access = protected, Static)
    
        function table = merge_tables(tables)
            % Recives a list of tables, and merges them into a single one.
            
            table = tables{1};
            for i=2:length(tables)
                table = outerjoin(table, tables{i}, 'MergeKeys', true);
            end
        end
    
    end
end

