function simrobo (g)

axis(gca,'equal')
% axis([0 8 0 8 0 8])
% robot frame
roboX=[-0.7 0.7 0.7 0.2 0.2 -0.2 -0.2 -0.7 -0.7]*2;
roboY=[-1 -1 1 1 1.2 1.2 1 1 -1]*2;
roboZ=[0 0 0 0 0 0 0 0 0]; %dummy vector here

% armX=[-0.2 0.2 0.2 -0.2 -0.2 -0.2 0.2 0.2 -0.2 -0.2 -0.2];
% armY=[-0.2 -0.2 0.2 0.2 -0.2 -0.2 -0.2 0.2 0.2 -0.2 -0.2];
% armZ=[0 0 0 0 0 1 1 1 1 1 0];

% arm=[armX;armY;armZ];

px=[0 0 0];py=[0 0 2];
pz=[0 3 3];
arm1=[px;py;pz];

robo=[roboX;roboY;roboZ];

robot=[robo,arm1];

figure(3)
worldFrame=[-2 22 -2 22 0 20]; % world frame
plot3(roboX,roboY,roboZ);    %plot the robot
axis(worldFrame);title('plot of robot movement');xlabel('x-axis');ylabel('y-axis');zlabel('z-axis')

axis([-5 20 -5 20 0 20])

%axis equal;
% hold on;
plot3(robot(1,:),robot(2,:),robot(3,:));
% fill3(robo);
box on

% fill3(robo(1,:),robo(2,:),robo(3,:),'r');
robo1=robot;

%new code start
global pqrs;
global a;
a=[0;0];
pqrs=0;
%new code ends
n= size(g,2);
 for i=2:n
    robo1=transformRoboo(robo1,g(1,i), g(2,i));
 end
 
 robo1=rotateHere(robo1,17,15);

%harsha code
ox=15;oy=15;
px=1.5;py=0.866;pz=4;
X=Inverse2(px,py,pz)

%Desired values of theta
theta1d=X(1)
theta2d=X(2)
theta1=0;theta2=0
while theta1<theta1d || theta2<theta2d

% %Using forward kinematics to find end effector position
P=Forwardkine2(theta1,theta2)
p3x=P(1)
p3y=P(2)
p3z=P(3)

p3=[p3x p3y p3z]
p1=[0 0 0];
p2=[0 0 3];
%line animation of the 3dof manipulator

bot1=line([p1(1)+ox p2(1)+ox],[p1(2)+oy p2(2)+oy],[p1(3) p2(3)]) 
bot2=line([p2(1)+ox p3(1)+ox],[p2(2)+oy p3(2)+oy],[p2(3) p3(3)]) 


drawnow

%incrementing theta(s) values after each iteration
if theta1<theta1d
   theta1=theta1+0.1

end
    
if theta2<theta2d
   theta2=theta2+0.1

end

if theta1~=theta1d & theta2~=theta2d
    delete(bot1)
delete(bot2)
end

end
hold on
bot1=line([p1(1)+ox p2(1)+ox],[p1(2)+oy p2(2)+oy],[p1(3) p2(3)]) 
bot2=line([p2(1)+ox p3(1)+ox],[p2(2)+oy p3(2)+oy],[p2(3) p3(3)]) 



 
 
 
 
 

