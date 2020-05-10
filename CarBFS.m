addpath General BFS

global map driver

car = SearchCar(5,5,0);
driver = CarDriver(car);

obstacle = Obstacle(10,10,5);
obstacle2 = Obstacle(15,15,2);

map = PathMap(car, [obstacle obstacle2]);

fig = figure;

map.generate()
map.setend(ginput(1))
map.generate()

Visited = zeros(0, 3);
queue = PositionQueue();
queue.addPosition(car.getCurSearchPosition());

all_directions = fieldnames(driver.directions);

while(~queue.isEmpty())

    curPos = queue.pullOut();
    
    if (~curPos.ifVisited())
        
        curPos.teleport();  % teleports the car to the x position
        
        % map.generate()
        
        if (map.check_if_end())
            map.show_path(curPos);
            break
        end

        for k=1:length(all_directions)
            cur_direction = all_directions{k};
            curPos.teleport()
            driver.directions.(cur_direction).move()
            new_pos = CarSearchPosition(car, car.xPos, car.yPos, car.Rotation);
            new_pos.setLastPos(curPos)
            if (~queue.checkInQueue(new_pos))
                queue.addPosition(new_pos)
            end
        end
    
        curPos.markVisited();
        
    end
end