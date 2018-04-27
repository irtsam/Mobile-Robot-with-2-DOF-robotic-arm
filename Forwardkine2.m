function [ P ] = Forwardkine2( theta1,theta2)
a1=0;d2=0;;d1=3;a2=2;
alpha1=90;alpha2=0;
A1=transformation(theta1,a1,d1,alpha1);
A2=transformation(theta2,a2,d2,alpha2);

T=A1*A2
px=T(1,4);
py=T(2,4);
pz=T(3,4);
P=[px py pz];

end



