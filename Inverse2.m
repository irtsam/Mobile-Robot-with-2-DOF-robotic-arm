function [Q] = Inverse2 (px,py,pz)    
a1=0;d2=0;;d1=3;a2=2;
alpha1=90;alpha2=0;

theta1= atan2d(py,px);

r=sqrt(px^2+py^2);
p=(pz-d1)/r;
theta2=atand(p);



Q=[theta1 theta2]

