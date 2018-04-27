function initRobo(ard)

   %globalize dc motor variables
   global dc_LM_PWM
   global dc_LM_IN1 
   global dc_LM_IN2 
   
   global dc_RM_PWM 
   global dc_RM_IN1 
   global dc_RM_IN2 
   
   %assign pin to control dc motors
   dc_LM_PWM='D5'; %pin to speed of left motors
   dc_LM_IN1='D3'; %pin to configure direction of left motor
   dc_LM_IN2='D4'; %pin to configure direction of left motor
   
   dc_RM_PWM='D6'; %pin to speed of right motors
   dc_RM_IN1='D7'; %pin to configure direction of right motor
   dc_RM_IN2='D8'; %pin to configure direction of right motor
   
   %globalize servo motor parameters
   global servo1 
   global servo2 
   global servo3 
   
   %assign pin tp 3 servo motors
   servo1=servo(ard,'D9'); % base servo connected to pin 9 of arduino
   servo2=servo(ard,'D10'); % 2nd servo connected to pin 10 of arduino
   servo3=servo(ard,'D11'); % end effector servo connected to pin 1 of arduino
   
end

