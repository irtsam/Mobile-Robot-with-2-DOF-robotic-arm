function roboMove(move,val)
    
    global ard
    global dc_LM_PWM
    global dc_RM_PWM
    dc_PWM=5;
    
    if (move==1)
        roboForward;
    elseif (move==2)
        roboReverse;
    elseif (move==3)
        roboClk;
    elseif (move==4)
        roboAClk
    elseif (move==5)
        roboStop;
    end
    
    writePWMVoltage(ard,dc_LM_PWM,dc_PWM);
    writePWMVoltage(ard,dc_RM_PWM,dc_PWM);
    pause(val);
    %write pwm to the dc motors given by val
    
end

function roboForward
   
   global ard
   global dc_LM_IN1 
   global dc_LM_IN2 
   
   global dc_RM_IN1 
   global dc_RM_IN2 
   
   %configure dc motors to forward forward in configuration
   writeDigitalPin(ard,dc_LM_IN1,1);   
   writeDigitalPin(ard,dc_LM_IN2,0);
   writeDigitalPin(ard,dc_RM_IN1,1);
   writeDigitalPin(ard,dc_RM_IN2,0);

end

function roboReverse
   global ard
   global dc_LM_IN1 
   global dc_LM_IN2 
   
   global dc_RM_IN1 
   global dc_RM_IN2 
   
   %configure dc motors to forward forward in configuration
   writeDigitalPin(ard,dc_LM_IN1,0);   
   writeDigitalPin(ard,dc_LM_IN2,1);
   writeDigitalPin(ard,dc_RM_IN1,0);
   writeDigitalPin(ard,dc_RM_IN2,1);

end

function roboClk
   global ard
   global dc_LM_IN1 
   global dc_LM_IN2 
   
   global dc_RM_IN1 
   global dc_RM_IN2 
   
   %configure dc motors to forward forward in configuration
   writeDigitalPin(ard,dc_LM_IN1,1);   
   writeDigitalPin(ard,dc_LM_IN2,0);
   writeDigitalPin(ard,dc_RM_IN1,0);
   writeDigitalPin(ard,dc_RM_IN2,1);

end

function roboAClk
   global ard
   global dc_LM_IN1 
   global dc_LM_IN2 
   
   global dc_RM_IN1 
   global dc_RM_IN2 
   
   %configure dc motors to forward forward in configuration
   writeDigitalPin(ard,dc_LM_IN1,0);   
   writeDigitalPin(ard,dc_LM_IN2,1);
   writeDigitalPin(ard,dc_RM_IN1,1);
   writeDigitalPin(ard,dc_RM_IN2,0);

end

function roboStop
   global ard
   global dc_LM_IN1 
   global dc_LM_IN2 
   
   global dc_RM_IN1 
   global dc_RM_IN2 
   
   %configure dc motors to forward forward in configuration
   writeDigitalPin(ard,dc_LM_IN1,0);   
   writeDigitalPin(ard,dc_LM_IN2,0);
   writeDigitalPin(ard,dc_RM_IN1,0);
   writeDigitalPin(ard,dc_RM_IN2,0);

end