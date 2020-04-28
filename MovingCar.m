speed = 0;
speedAcc = 1 / 1000;
rotationAcc = pi / 100;

size = 40;

car = Car(0,0,0);

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
            car.Rotation = car.Rotation - rotationAcc;

        case 'leftarrow'
            car.Rotation = car.Rotation + rotationAcc;
        
        % Stop
        case 'numpad0'
            break;
        
        % If any other key is pressed, the object will keep moving
        % in the same direction (same rotation) at the same speed.

    end

    xDifference = cos(car.Rotation) * speed;
    yDifference = sin(car.Rotation) * speed;

    car.xPos = car.xPos + xDifference;
    car.yPos = car.yPos + yDifference;
    
    car.plot()
    
    axis equal
    xlim([-size/2 size/2])
    ylim([-size/2 size/2])
    drawnow

end

close;

function dir = stroke(src,event)
end