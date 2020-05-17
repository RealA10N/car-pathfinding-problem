addpath General Search
addpath Search/BreadthFirst

% Create car and car-driver
car = SearchCar(3,3,90);  % default start position
driver = CarDriver(car);

% Create obstacles
obstacle = RectangleObstacle(1, 7, 12, 11);
obstacle2 = RectangleObstacle(14, 12, 20, 17);
obstacle3 = RectangleObstacle(3, 15, 8, 17);

% Create map with car and obstacles
map = PathMap(car, [obstacle obstacle2 obstacle3]);

map.generate()  % Show the map

% map.setend(ginput(1))  % User input end point
map.setend([17 10])  % Constant goal point

map.generate()  % Show the map with end point

% Create the point queue, add the starting point
queue = BreadthFirstPositionQueue();
queue.addPosition(car.convertToPosition());

% Get all the move directions from car-driver
all_directions = fieldnames(driver.directions);


tic
while(~queue.isEmpty())
    
    % Pull out position from the queue
    curPos = queue.pullOut();
    curPos.markVisited();
    curPos.teleport();
    
    if(map.checkDead())
        continue
    end

    if (map.check_if_end())
        map.show_path(curPos);
        break
    end

    % map.show_path(curPos)  % Show the search process
    
    % For every move avalible from current position
    for k=1:length(all_directions)
        
        % Move car to the given direction
        cur_direction = all_directions{k};
        curPos.teleport()
        driver.directions.(cur_direction).move()
        
        % Generate car position
        new_pos = car.convertToPosition();
        new_pos.setLastPos(curPos)
        
        % Add to queue if never visited
        queue.addPosition(new_pos)
    end

end
toc