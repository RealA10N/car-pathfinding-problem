clear all
close all
clc

speed = 0;
speedAcc = 1 / 1000;

rotation = 0;
rotationAcc = pi / 50;

xPos = 0;
yPos = 0;

size = 40;
xCarSize = 1;
yCarSize = 2;

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
            rotation = rotation - rotationAcc;

        case 'leftarrow'
            rotation = rotation + rotationAcc;
        
        % Stop
        case 'numpad0'
            break;
        
        % If any other key is pressed, the object will keep moving
        % in the same direction (same rotation) at the same speed.

    end

    xDifference = cos(rotation) * speed;
    yDifference = sin(rotation) * speed;

    xPos = xPos + xDifference;
    yPos = yPos + yDifference;

    scatter(xPos,yPos,'filled','b')

    txt = sprintf("Speed: %.3f \n Rotation: %.3f", speed, rotation);
    text(0, 0, txt);
    
    axis equal
    xlim([-size/2 size/2])
    ylim([-size/2 size/2])

    drawnow

end

close;

function dir = stroke(src,event)
end