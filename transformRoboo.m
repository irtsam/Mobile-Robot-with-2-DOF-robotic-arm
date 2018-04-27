function newRobo=transformRoboo(oldRobo,newX,newY)
    worldFrame=[-2 25 -2 25 0 22];

    %rotate robot if required
    rotatedRobot=rotateHere(oldRobo,newX,newY);
    figure(3)
    title('Robot Simulation')
    plot3(rotatedRobot(1,:),rotatedRobot(2,:),rotatedRobot(3,:));
    axis(worldFrame);title('plot of robot movement');xlabel('x-axis');ylabel('y-axis')
    axis square
    box on

    pause(1);
    
    %translate robot
    translatedRobot=translateHere(rotatedRobot,newX,newY);
    
    newRobo=translatedRobot;
end

function translatedRobot=translateHere(oldRobo,Tx,Ty)
    worldFrame=[-2 25 -2 25 0 22];
    
    %required translation in x and y direction
    Tx=Tx-(oldRobo(1)+oldRobo(7))/2;
    Ty=Ty-(oldRobo(2)+oldRobo(8))/2;
    
    %new code for translation
    global pqrs;
    global a;
    pqrs=pqrs+1;
    a(:,pqrs)=[1,sqrt((Tx*Tx)+(Ty*Ty))/2];
    %new code for translation stop
    
    % get division step for translation
    [txDiv,tyDiv]=getDiv(Tx,Ty);
    
    while((abs(Tx)-abs(txDiv))>=0 && (abs(Ty)-abs(tyDiv))>=0)
        if (Tx<0 && Ty<0)  
            oldRobo=transRobo(oldRobo,-txDiv,-tyDiv);
            Tx=Tx+txDiv;
            Ty=Ty+tyDiv;
        elseif (Tx<0 && Ty>0)
            oldRobo=transRobo(oldRobo,-txDiv,tyDiv);
            Tx=Tx+txDiv;
            Ty=Ty-tyDiv;
        elseif (Tx>0 && Ty<0)
            oldRobo=transRobo(oldRobo,txDiv,-tyDiv);
            Tx=Tx-txDiv;
            Ty=Ty+tyDiv;
        elseif(Tx>0 && Ty>0)
            oldRobo=transRobo(oldRobo,txDiv,tyDiv);
            Tx=Tx-txDiv;
            Ty=Ty-tyDiv;
        elseif(Tx==0 && Ty>0)
            oldRobo=transRobo(oldRobo,txDiv,tyDiv);
%             Tx=Tx-txDiv;
            Ty=Ty-tyDiv;
        elseif(Ty==0 && Tx>0)
            oldRobo=transRobo(oldRobo,txDiv,tyDiv);
            Tx=Tx-txDiv;
%             Ty=Ty-tyDiv;
        end
        figure(3)
        plot3(oldRobo(1,:),oldRobo(2,:),oldRobo(3,:))   %draw robot with filled as green
        axis(worldFrame);title('plot of robot movement');xlabel('x-axis');ylabel('y-axis');  %axis settings for world frame
        axis square;
        box on;
        pause(0.001)
    end
    translatedRobot=oldRobo;   %send back coordinates of new robot
end


function [txDiv,tyDiv]=getDiv(Tx,Ty)    %function to find step division for translation
    if(abs(Tx)>abs(Ty))
        txDiv=0.05;
        div=abs(Tx)/txDiv;
        tyDiv=abs(Ty)/div;
    elseif(abs(Ty)>abs(Tx))
        tyDiv=0.05;
        div=abs(Ty)/tyDiv;
        txDiv=abs(Tx)/div;
    else
        txDiv=0.05;tyDiv=0.05;
    end
    
    if(Tx==0 && abs(Ty)>0)
        txDiv=0; tyDiv=0.05;
    elseif (Ty==0 && abs(Tx)>0)
        txDiv=0.05; tyDiv=0;
    end
        
end

function rotatedRobot= rotateHere(oldRobo,dirX,dirY)
%     worldFrame=[-2 25 -2 25 0 22]; 
    centerOfRobo=[(oldRobo(1)+oldRobo(7))/2;(oldRobo(2)+oldRobo(8))/2];
    headOfRobo=[(oldRobo(13)+oldRobo(16))/2;(oldRobo(14)+oldRobo(17))/2];

%     mySlope=radtodeg(atan((headOfRobo(2)-centerOfRobo(2))/(headOfRobo(1)-centerOfRobo(1))));
    
    degOfRotation=getDeg(centerOfRobo,dirX,dirY);
    degOfHead=getDeg(centerOfRobo,headOfRobo(1),headOfRobo(2));
    
    degOfRotation=degtorad(degOfRotation-degOfHead);
    
    %new code start
    
    global pqrs; 
    global a;
    pqrs=pqrs+1;
     
    b=radtodeg(degOfRotation);
    deg=1.1/180;
    b=b*deg;
    if b<=0
        a(:,pqrs)=[3,-b];
    else
        a(:,pqrs)=[4,b];
    end
          
    %new code ends
     
    rotMat=[cos(degOfRotation) -sin(degOfRotation) 0; sin(degOfRotation) cos(degOfRotation) 0; 0 0 1];  %rotation matrix along z axis
    
    %translation before rotation
    Tx=-centerOfRobo(1);   Ty=-centerOfRobo(2);
    translatedRobot=transRobo(oldRobo,Tx,Ty);   %translate of robot to origin
    
    rotateRobot=rotMat*translatedRobot; %rotate robot to required degree
    
    rotatedRobot=transRobo(rotateRobot,-Tx,-Ty);    %translation after rotation to original position
    
%     fill(rotatedRobot(1,:),rotatedRobot(2,:),'g');
%     axis(worldFrame);title('plot of robot movement');xlabel('x-axis');ylabel('y-axis')
%     axis square
    
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