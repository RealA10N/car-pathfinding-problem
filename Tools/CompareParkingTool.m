classdef CompareParkingTool < CompareTool
    %COMPAREPARKINGTOOL Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        
        function obj = CompareParkingTool()
            % Initialize the problem.
            obj = obj@CompareTool("Placeholder-name");
            obj.OUTPUT_FOLDER = "ParkingCompareOutputes";
            obj.init_problem()
        end
        
        function park(obj, n)
            % Run the comparing algorithem n times.
            for k=1:n
                obj.park_once()
            end
        end
        
        function park_once(obj)
            obj.init_start_point();
            obj.test_name = obj.get_unused_name_path();
            obj.compare();
        end
        
    end
    
    methods (Access = private)

        function init_problem(obj)
            % Configure obstacles and end point.
            obj.setEnd(-90, 2, 10)
            obj.addObstacle([0 2], [0 20])
            obj.addObstacle([1 5], [0 7])
            obj.addObstacle([1 5], [13 20])
        end
        
        function init_start_point(obj)
            % Teleports the car into a random starting position.
            % This method should be called after the `init_problem`
            % method is called.
            obj.map.car_rand_teleport()
        end
        
        function name = get_unused_name_path(obj, iteration)
            % geenrates and returns a name to a
            % new comparing outputs folder.
            
            if (nargin < 2)
                iteration = 1;
            end
            
            name = sprintf('%03d', iteration);
            path = fullfile(obj.OUTPUT_FOLDER, name);
            
            if (exist(path, 'dir'))
                name = obj.get_unused_name_path(iteration + 1);
            end
        end
    end
end

