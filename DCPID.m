% DC Motor Modelling. Will change to stepper

J = 3.2284E-6;  % moment of inertia of the rotor
b = 3.5077E-6;  % motor viscous friction constant
K = 0.0274;     % electromotive force & Motor torque constant 
R = 4;          % Armature resistance
L = 2.75E-6;    %Armature Inductance

% Laplace 

s = tf('s'); 
% Simple PID control

P_motor = K/(s*((J*s+b)*(L*s+R)+K^2)); 

%PID Design

Kp = 21;
Ki = 500;
Kd = 0.05;

% Adjust for peak time etc later. Currently simple PID

for i = 1:3
    C(:,:,i) = pid(Kp,Ki,Kd);
    Kd = Kd + 0.1;
end


% Plot 
sys_cl = feedback(C*P_motor,1);
t = 0:0.001:0.1;
step(sys_cl(:,:,1), sys_cl(:,:,2), sys_cl(:,:,3), t)
ylabel('Position, \theta (radians)')
title('Response to a Step Reference with K_p = 21, K_i = 500 and Different Values of K_d')
legend('K_d = 0.05', 'K_d = 0.15', 'K_d = 0.25')
