% The current dijkstra algorithem will run like breadth-first,
% because the cost of each road is 1.


addpath General Search Search/Dijkstras

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

Visited = zeros(0, 3);
queue = DijkstraPositionQueue();

starting_pos = car.getCurSearchPosition().toDijkstraPosition();
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
        new_pos = DijkstraPosition(car, car.xPos, car.yPos, car.Rotation);
        new_pos.setLastPos(curPos)
        
        % Adds the position to the queue. only if the cost of the current
        % position is the lowest!
        queue.addPosition(new_pos)

    end

        
end
toc