classdef Main
    % This class is the main class of the program.
    % You can use this class in a seperate script, or just run it in the
    % command window!
    
    properties (Access = protected)
        car
        driver
        map
        
        % Defaults
        digits_after_decimal_point  % int. >= 0
        algorithm_list % Contains "algorithm" objects for
                       % every algorithm in the program
        
        % Search related
        stats  % Tracks stats of the search algorithm

    end
    
    methods
        
        function obj = Main()
            % Importing all of the algorithm classes
            addpath General Search
            addpath Search/BreadthFirst
            addpath Search/Dijkstras
            addpath Search/Astar
            
            % Creates the needed objects
            obj.car = SearchCar(5, 5, 0);  % default car location
            obj.driver = CarDriver(obj.car);
            obj.map = PathMap(obj.car);  % default size, no obstacles
            
            % Set default values
            obj.digits_after_decimal_point = 0;
            obj.stats = AlgorithmStats();
            
            % Generates and returns the algorithm list, that contains all
            % the "Algorithm" subclasses.
            obj.algorithm_list = { ...
                BreadthFirstAlgorithm(obj.map, obj.stats), ...
                DijkstrasAlgorithm(obj.map, obj.stats), ...
                AstarAlgorithm(obj.map, obj.stats) ...
                };
        end
        
        function setStart(obj, rotation, x, y)
            % Sets the starting position of the car
            
            if (nargin < 3)
                % if the point (x, y) is not given
                obj.generate()  % generate the map before user input
                [ x, y ] = obj.userInPoints(1);  % user selects the car (x, y)
            end
            
            if (nargin < 2)
                % If rotation is not given
                rotation = 0;
            end
            
            obj.car.teleport(x, y, rotation)
            obj.generate()  % show the map with the new location of the car
            
            % Checking if the car status is good (if not in obstacle or out of map)
            if (obj.map.checkDead())
                error("The position of the car is invalid.")
            end
        end
        
        function setEnd(obj, x, y)
            % Defines the point that the car needs to touch for the
            % algotithm to find a path.
            
            if (nargin < 3)
                % If the point is not given
                obj.generate()  % generate the map before user input
                [ x, y ] = obj.userInPoints(1);  % user selects the end point on graph
            end
            
            obj.map.setend([x y])
            obj.map.generate()  % generate the map with the end point on it
            
            if (obj.map.checkPointDead(x, y))
                error("The position of the end point is invalid.")
            end
            
        end
        
        function addObstacle(obj, x, y)
            % Adds an obstacle to the map. if x or y is not given,
            % the user will be requestd to select two points with the
            % ginput funtion.
            
            if (nargin < 3)
                % If the points are not passed as parameters,
                % use ginput to selet on the graph.
                obj.generate()  % generate the map before user input
                disp("Please select two points on the map to create a rectange obstacle.")
                [ x, y ] = obj.userInPoints(2);
            end
            
            % If duplicate point, sets the size of the obstacle to 1.
            % In implementation, obstacle can't be a point!
            if (x(1) == x(2))
                x(2) = x(2) + 1;
            end
            if (y(1) == y(2))
                y(2) = y(2) + 1;
            end
            
            obstacle = RectangleObstacle(x(1), y(1), x(2), y(2));
            obj.map.addObstacles(obstacle);
            obj.generate()  % generate the map after the obstacle is added
        end
        
        function generate(obj)
            % Shows the current state of the map
            obj.map.generate()
        end
        
        function search(obj, drawEveryStep)
            % A function that will search a path to the end position, with
            % the given algorithm. if an algorithm isn't given, the user
            % will be displayed with a window that asks him to choose one.
            
            algorithmObj = obj.userSelectAlgorithm();
            
            if (nargin < 2)
                % If drawEveryStep is not given
                drawEveryStep = true;
            end

            algorithmObj.run(drawEveryStep); % The search operation

        end
        
    end

    
    methods (Access = protected)
        
        function [ x, y ] = userInPoints(obj, points_num)
            % This method uses the ginput function to take in input from
            % the user, but the points are rounded.
            [ x, y ] = ginput(points_num);
            x = round(x, obj.digits_after_decimal_point);
            y = round(y, obj.digits_after_decimal_point);
        end
        
        function algorithmObj = userSelectAlgorithm(obj)
            % Opens a window that lets the user select a search algorithm
            % from the list. The selected algorithm object is returned!
            
            % The text that will be shown above the list
            prompt = 'Please select the algorithm you want to search with:';
            
            % Getting the avalible algorithm names
            list = obj.getAlgorithmNames();
            
            % Asking user for input
            i = listdlg('ListString', list, 'SelectionMode', 'single', ...
                'PromptString', prompt, 'ListSize', [300 150]);

            algorithmObj = obj.algorithm_list{i};
        end
        
        function names = getAlgorithmNames(obj)
            % Generates and returns the algorithm list, that contains all
            % the "Algorithm" subclasses.
            
            names = [];
            for i=1:length(obj.algorithm_list)
                curAlgorithm = obj.algorithm_list{i};
                curName = curAlgorithm.getAlgorithmName();
                names = [ names curName ];
            end
            
        end
        
    end

end

