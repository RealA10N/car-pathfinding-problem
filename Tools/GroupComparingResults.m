% The comapring tool saves the results of each run on each problem seperetly.
% This tool will group all of the results into one Excel file.

%% Load the comparing output folder
root = uigetdir();
root_dir = dir(root);

%% Generate a struct representing each of the runs
run_folders = root_dir([root_dir(:).isdir]);
% remove '.' and '..'
run_folders = run_folders(~ismember({run_folders(:).name},{'.','..'}));

%% Configure the final excel path
[~, root_dir_name] = fileparts(root);
final_path = fullfile(root, root_dir_name + ".xlsx");

%% Define algoritm sheets empty list
algorithm_names = [];   % represents the algorithm names
algorithm_tables = {};  % represents the algorithm sheets

%% Load the copy the info of each run into the new file

number_of_results = size(run_folders, 1);
for i=1:number_of_results
    
    % Save current dir and name
    run_id = run_folders(i).name;
    curdir = fullfile(run_folders(i).folder, run_id);
    curname = run_folders(i).name;
    
    % Open the tables inside the current dir
    table_files = dir(fullfile(curdir, '*.xlsx'));
    tables = size(table_files, 1);
    
    % For each table in the current dir,
    % save the table and collect the data.
    for k=1:tables
        table_path = fullfile(curdir, table_files(k).name);
        table = readtable(table_path);
        
        % Add the run id into the table
        table_rows = size(table, 1);
        ID = repmat(run_id, table_rows, 1);
        table = addvars(table, ID, 'Before', 'Row');
        
        % Save table to the matching worksheet
        [algorithm_names, algorithm_tables] = save_table(table, algorithm_names, algorithm_tables);
    end

end
    
% Display the saved tables
num_of_tables = size(algorithm_tables, 2);
for k=1:num_of_tables
    cur_name = string(algorithm_names(k));
    cur_table = algorithm_tables{k};
    writetable(cur_table, final_path, 'Sheet', cur_name)
end
%% Functions

function [algorithm_names, algorithm_tables] = save_table(table, algorithm_names, algorithm_tables)
    rows_num = size(table, 1);
    
    for i=1:rows_num
        currow = table(i, :);
        algorithm_name = string(table{i, 2});
        
        % get algorithm worksheet index
        [index, algorithm_names, algorithm_tables] = get_algorithm_worksheet_index(algorithm_name, algorithm_names, algorithm_tables);
        cur_algorithm_table = algorithm_tables{index};
        algorithm_tables{index} = append_row_to_table(currow, cur_algorithm_table);
    end
end

function table = append_row_to_table(row, table)
    
    if istable(table)
        % If table, append the row
        table = outerjoin(table, row, 'MergeKeys', true);
        
    else
        % If not table, create a new one!
        table = row;
    end
end

function [index, algorithm_names, algorithm_tables] = get_algorithm_worksheet_index(algorithm_name, algorithm_names, algorithm_tables)
    
    % Check if algorithm already saved in list
    algorithm_name = convertStringsToChars(algorithm_name);
    algorithm_match_matrix = strcmp(algorithm_names, algorithm_name);
    is_algorithm_known = any(algorithm_match_matrix);
    
    if (is_algorithm_known)
        [~, index] = find(algorithm_match_matrix);
    else
        algoritm_count = size(algorithm_names, 2);
        index = algoritm_count + 1;
        algorithm_names{index} = algorithm_name;
        algorithm_tables{index} = {0};
    end
end