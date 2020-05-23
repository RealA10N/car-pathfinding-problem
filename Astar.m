addpath General Search
addpath Search/Astar Search/Dijkstras

car = SearchCar(3,3,90);
driver = CarDriver(car);

obstacle = RectangleObstacle(1, 7, 12, 11);
obstacle2 = RectangleObstacle(14, 12, 20, 17);
obstacle3 = RectangleObstacle(3, 15, 8, 17);

map = PathMap(car, [obstacle obstacle2 obstacle3]);

map.generate()

endPoint = [17 10];  % User goal input
% endPoint = ginput(1);  % Constant goal value

map.setend(endPoint)
map.generate()

queue = AstarPositionQueue();

starting_pos = car.convertToAstarPosition(endPoint);
starting_pos.tryUpdateCost(0);
queue.addPosition(starting_pos);

all_directions = driver.getDirectionNames();

tic
while(~queue.isEmpty())

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

    map.show_path(curPos)

    for k=1:length(all_directions)
        
        % Move car to the given direction
        cur_direction = all_directions{k};
        curPos.teleport()
        driver.directions.(cur_direction).move()
        
        % Generate car position
        new_pos = car.convertToAstarPosition(endPoint);
        new_pos.setLastPos(curPos)
        new_pos.tryUpdateCost(curPos.getCost() + 1)
        
        % Adds the position to the queue. only if the cost of the current
        % position is the lowest!
        queue.addPosition(new_pos)

    end

        
end
toc