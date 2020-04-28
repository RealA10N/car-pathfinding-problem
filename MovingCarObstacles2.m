global map car

car = Car(5,5,0);
obstacle = Obstacle(10,10,5);
obstacle2 = Obstacle(15,15,2);

map = Map(car, [obstacle obstacle2]);

fig = figure;
map.generate();
set(fig,'KeyPressFcn',@KeyPressCb);

function KeyPressCb(~,event)

    global map car

    %fprintf('key pressed: %s\n',event.Key);
    
    switch event.Key
        
        case 'leftarrow'
            map.move_car(pi/100);
            map.generate();
            
        case 'rightarrow'
            map.move_car(-pi/100);
            map.generate();
    end
end