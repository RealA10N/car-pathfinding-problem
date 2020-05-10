addpath Classes

global map driver

car = Car(5,5,0);
driver = CarDriver(car);

obstacle = Obstacle(10,10,5);
obstacle2 = Obstacle(15,15,2);

map = PathMap(car, [obstacle obstacle2]);

fig = figure;

map.generate()
map.setend(ginput(1))
map.generate()

Visited = zeros(0, 3);
Q = [car.xPos, car.yPos, car.Rotation;];  % Queue

all_directions = fieldnames(driver.directions);

while(~isempty(Q))

    x = Q(1,:);
    Q(1,:) = [];
    
    if (~ismember(x, Visited, 'rows'))
        
        car.teleport(x(1), x(2), x(3));
        if (map.check_if_end())
            disp("end!")
            break
        end

        map.generate()

        for k=1:length(all_directions)
            cur_direction = all_directions{k};
            driver.directions.(cur_direction).move()
            new_pos = [round(car.xPos,1), round(car.yPos,1), round(car.Rotation,1)];

            % Checking if visited same place
            if (~ismember(new_pos, Visited, 'rows'))
                % if not
                Q = [Q; new_pos;];
            end
        end
    
        Visited = [Visited; x];
        
    end
end

map.generate()