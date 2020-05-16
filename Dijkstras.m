% The current dijkstra algorithem will run like breadth-first,
% because the cost of each road is 1.


addpath General Search Search/Dijkstras

global map driver

car = SearchCar(3,3,90);
driver = CarDriver(car);

% obstacle = Obstacle(5,5,4);
% obstacle2 = Obstacle(12,15,2);
% obstacle3 = Obstacle(2,12,6);

obstacle = RectangleObstacle(1, 7, 12, 11);
obstacle2 = RectangleObstacle(14, 12, 20, 17);
obstacle3 = RectangleObstacle(3, 15, 8, 17);

map = PathMap(car, [obstacle obstacle2 obstacle3]);

% map.generate()
% map.setend(ginput(1))
map.setend([17 10])
map.generate()

Visited = zeros(0, 3);
queue = PositionQueue();

starting_pos = car.getCurSearchPosition().toDijkstraPosition();
starting_pos.tryUpdateCost(0);
queue.addPosition(starting_pos);

all_directions = fieldnames(driver.directions);


tic
while(~queue.isEmpty())

    curPos = queue.pullOut();
    
    if (~curPos.ifVisited())
        
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
            cur_direction = all_directions{k};
            curPos.teleport()
            driver.directions.(cur_direction).move()
            new_pos = DijkstraPosition(car, car.xPos, car.yPos, car.Rotation);
            new_pos.setLastPos(curPos)
            new_pos.tryUpdateCost(curPos.getCost() + 1)
            if (~queue.checkIfEncountered(new_pos))
                queue.addPosition(new_pos)
            end
        end
    
        curPos.markVisited();
        
    end
end
toc