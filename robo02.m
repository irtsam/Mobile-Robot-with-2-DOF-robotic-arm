function robo02 ()

%clear connection to arduino
clc
if ~isempty(instrfind)
    fclose(instrfind);
    delete(instrfind);
end
clc
clear; %clear all connection variables of arduino
global ard;
ard=arduino();  %define an object of type arduino
global a;

initRobo(ard); %initialize parameters of robot

%2.4 clc
% 3.2 aclk

global servo1 
global servo2 
global servo3 

% servo rotation start
% for angle =0.2:1/90:0.5 %loop for 0 to 180 degree in radians
% %    angle=degtorad(i);
%    writePosition(servo1,angle);
%    currentPosition=readPosition(servo1);
%    fprintf('Current motor position is %d degree\n',currentPosition*180);
%    pause(0.1);
% end
% 
% for angle =0.5:1/90:0.7 %loop for 0 to 180 degree in radians
% %    angle=degtorad(i);
%    writePosition(servo2,angle);
%    currentPosition=readPosition(servo2);
%    fprintf('Current motor position is %d degree\n',currentPosition*180);
%    pause(0.1);
% end
% 
% for angle =0:1/90:1  %loop for 0 to 180 degree in radians
%    angle=degtorad(i);
%    writePosition(servo3,angle);
%    currentPosition=readPosition(servo3);
%    fprintf('Current motor position is %d degree\n',currentPosition*180);
%    pause(0.1);
% end
% servo rotation stop


% roboMove(move,val):-- move is direction(1=forward, 2=reverse, 3= clk
% wise, 4=Aclk wise). val is seconds for dc motor to move

% roboMove(4,0.5025);
% deg=1.1/180;

for i=0;size(a)
    roboMove(a(1),a(2));
    roboMove(5,0);
    pause(0.5);
end

disp('a')
end

