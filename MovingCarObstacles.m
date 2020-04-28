
speed = 0;
speedAcc = 1 / 1000;
rotationAcc = pi / 100;


car = Car(5,5,0);
obstacle = Obstacle(10,10,5);
obstacle2 = Obstacle(15,15,2);

map = Map(car, [obstacle obstacle2]);

set(gcf,'KeyPressFcn',@stroke)

while true
    
    switch get(gcf,'CurrentKey')

        % Speed
        case 'uparrow'
            speed = speed + speedAcc;
        
        case 'downarrow'
            speed = speed - speedAcc;
            
        % Rotation
        case 'rightarrow'
            map.car.Rotation = map.car.Rotation - rotationAcc;

        case 'leftarrow'
            map.car.Rotation = map.car.Rotation + rotationAcc;
        
        % Stop
        case 'numpad0'
            break;
        
        % If any other key is pressed, the object will keep moving
        % in the same direction (same rotation) at the same speed.

    end

    xDifference = cos(map.car.Rotation) * speed;
    yDifference = sin(map.car.Rotation) * speed;

    map.car.xPos = map.car.xPos + xDifference;
    map.car.yPos = map.car.yPos + yDifference;

    map.plot()

end

close;

function dir = stroke(src,event)
end