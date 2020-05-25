classdef (Abstract) Algorithm < handle
    %ALGORITHM defines every algorithm in the program
    
    properties (Access = protected)
        name  % String that holds the algorithm name
        stats  % Objcets that tracks every search stats and displays them
        map  % A Map object that contains a car and obstacles
        driver  % CarDriver object that contains all the directons the car can move to
    end
    
    methods (Abstract)
        logical = run(obj, drawEveryStep)  % A function that runs the search algorithm
                                           % Returns a logical (true/false)
                                           % that indecates if the algorithm
                                           % found a path or not.
    end
    
    methods
        
        function obj = Algorithm(map, stats, name)
            obj.name = name;
            obj.stats = stats;
            obj.map = map;
            obj.driver = CarDriver(map.getCar());  % Creates the driver
        end
        
        function name = getAlgorithmName(obj)
            % Returns a string that contains the name of the algorithm
            name = obj.name;
        end
        
    end
end

