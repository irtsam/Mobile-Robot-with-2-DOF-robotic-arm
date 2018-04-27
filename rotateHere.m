function rotatedRobot= rotateHere(oldRobo,dirX,dirY)
    worldFrame=[-2 25 -2 25 0 22]; 
    centerOfRobo=[(oldRobo(1)+oldRobo(7))/2;(oldRobo(2)+oldRobo(8))/2];
    headOfRobo=[(oldRobo(13)+oldRobo(16))/2;(oldRobo(14)+oldRobo(17))/2];

%     mySlope=radtodeg(atan((headOfRobo(2)-centerOfRobo(2))/(headOfRobo(1)-centerOfRobo(1))));
    
    degOfRotation=getDeg(centerOfRobo,dirX,dirY);
    degOfHead=getDeg(centerOfRobo,headOfRobo(1),headOfRobo(2));
    
    degOfRotation=degtorad(degOfRotation-degOfHead);
    rotMat=[cos(degOfRotation) -sin(degOfRotation) 0; sin(degOfRotation) cos(degOfRotation) 0; 0 0 1];  %rotation matrix along z axis
    
    %translation before rotation
    Tx=-centerOfRobo(1);   Ty=-centerOfRobo(2);
    translatedRobot=transRobo(oldRobo,Tx,Ty);   %translate of robot to origin
    
    rotateRobot=rotMat*translatedRobot; %rotate robot to required degree
    
    rotatedRobot=transRobo(rotateRobot,-Tx,-Ty);    %translation after rotation to original position
    
%     fill(rotatedRobot(1,:),rotatedRobot(2,:),'g');
%     axis(worldFrame);title('plot of robot movement');xlabel('x-axis');ylabel('y-axis')
%     axis square
    plot3(rotatedRobot(1,:),rotatedRobot(2,:),rotatedRobot(3,:));
    axis(worldFrame);title('plot of robot movement');xlabel('x-axis');ylabel('y-axis')
    axis square
    box on
end

function degOfRotation=getDeg(centerOfRobo,dirX,dirY)
    slope=(dirY-centerOfRobo(2))/(dirX-centerOfRobo(1)); %slope = dy/dx
    slope=radtodeg(atan(slope));
    if(dirX>centerOfRobo(1))
        if(dirY==centerOfRobo(2))
            degOfRotation=0;
        elseif(dirY>centerOfRobo(2))
            degOfRotation=slope;
        else
            degOfRotation=270+(90+slope);
        end
        
    elseif (dirX<centerOfRobo(1))
        if(dirY==centerOfRobo(2))
            degOfRotation=180;
        else
            degOfRotation=90+(90+slope);
        end
        
    else
        if(dirY==centerOfRobo(2))
            degOfRotation=0;
        elseif(dirY>centerOfRobo(2))
            degOfRotation=90;
        else
            degOfRotation=270;
        end
    end    
end
    
function translatedRobot=transRobo(oldRobo,Tx,Ty)
    dummyVector(1:size(oldRobo,2))=1;
%     dummyVector(1,:)=1;
    oldRobo=[oldRobo;dummyVector];
    translationMatrix=[1 0 0 Tx;0 1  0 Ty; 0 0 1 0;0 0 0 1];
    translatedRobot=translationMatrix*oldRobo;
    translatedRobot(4,:)=[];
end