% The current dijkstra algorithm will run like breadth-first,
% because the cost of each road is 1. Note that this algorithm won't
% necessery give you the optimal path, and will stop on the first position
% where the car touches the end-point (this happens because the end
% position is a point on the map and not a state of the car).

addpath General Search
addpath Search/Dijkstras

car = SearchCar(3,3,90);
driver = CarDriver(car);

obstacle = RectangleObstacle(1, 7, 12, 11);
obstacle2 = RectangleObstacle(14, 12, 20, 17);
obstacle3 = RectangleObstacle(3, 15, 8, 17);

map = PathMap(car, [obstacle obstacle2 obstacle3]);

map.generate()

% map.setend(ginput(1)) % User goal input
map.setend([17 10])  % Constant goal value

map.generate()

queue = DijkstraPositionQueue();

starting_pos = car.convertToDijkstraPosition();
starting_pos.tryUpdateCost(0);
queue.addPosition(starting_pos);

all_directions = fieldnames(driver.directions);

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

    % map.show_path(curPos)

    for k=1:length(all_directions)
        
        % Move car to the given direction
        cur_direction = all_directions{k};
        curPos.teleport()
        driver.directions.(cur_direction).move()
        
        % Generate car position
        new_pos = car.convertToDijkstraPosition();
        new_pos.setLastPos(curPos)
        new_pos.tryUpdateCost(curPos.getCost() + 1)
        
        % Adds the position to the queue. only if the cost of the current
        % position is the lowest!
        queue.addPosition(new_pos)

    end

        
end
toc