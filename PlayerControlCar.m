global map driver

car = Car(5,5,0);
driver = CarDriver(car);

obstacle = Obstacle(10,10,5);
obstacle2 = Obstacle(15,15,2);

map = Map(car, [obstacle obstacle2]);


fig = figure;
map.generate();
set(fig,'KeyPressFcn',@KeyPressCb);

function KeyPressCb(~,event)

    global map driver

    % fprintf('key pressed: %s\n',event.Key);
    
    driver.move(event.Key);
    map.generate();

end