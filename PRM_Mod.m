
clf();
figure(1)
hold on
title('Obstacle Map');
rectangle('Position',[1 2 3 4])
rectangle('Position',[9 3 3 8])
grid on
axis([0 15 0 15 0 15])
% x = rand(2,15)*5
x = randi([0 15],2,300);
plot(x(1,:),x(2,:),'*');
% plotManage();
hold off
% ss=[0;0];
% x= filterRepeatedNodes(x,ss);

% for i=0:i<(sizeof(x));
%     i++;
%     line([x(1,i)x(2,:),'r');
% end



% 
Ax=[];
Ay=[];
for i=1:size(x,2)
    if((x(1,i)<1 || x(1,i)>4) && (x(1,i)<9 || x(1,i)>12))
          Ax = [Ax;x(1,i)];
          Ay = [Ay;x(2,i)];
    end
    
    if(x(1,i)>=1 && x(1,i)<=4)
        if(x(2,i)<2 || x(2,i)>6)
          Ax = [Ax;x(1,i)];
          Ay = [Ay;x(2,i)];
        end
    end
        
        
  if(x(1,i)>=9 && x(1,i)<=12 )
        if(x(2,i)<3 || x(2,i)>11)
          Ax = [Ax;x(1,i)];
          Ay = [Ay;x(2,i)];
        end
  end
        
       
        
A=[transpose(Ax);transpose(Ay)] ;   
end

       
xlim([0 15]);
ylim([0 15]);
figure(1)
hold on 
title('Probabilistic Roadmap');
rectangle('Position',[1 2 3 4])
rectangle('Position',[9 3 3 8])
plot(A(1,:),A(2,:),'o')
% plot(x(1,:),x(2,:),'*', 'b');
% X=[];
for i=1:size(A,2)
    for j=2:size(A,2)
        if (abs(A(1,i)-A(1,j))<3) && (abs(A(2,i)-A(2,j))<3)
%            figure(2)
            
           l1=line([A(1,i) A(1,j)],[A(2,i) A(2,j)], [0 0],'Color','r');
         
        end
        
    end
    pause(0.005);
end
p=[0 0];
f=p;%starting point
g=[15 15]%goal;
P=[p(1,1) g(1,1);p(1,2) g(1,2)];
plot(P(1,:),P(2,:),'*', 'color','g');
A=[A,P(:,1)];
A=[A,P(:,2)];
X=[];
Y=[];
C=[];
sx=[];
sy=[];
k=1;
while p(1)~=g(1) || p(2)~=g(2)
    for j=1:size(A,2)
        if (abs(p(1)-A(1,j))<3) && (abs(p(2)-A(2,j))<3)
X=[X;A(1,j)];
Y=[Y;A(2,j)];
        end
    end
       E=[transpose(X);transpose(Y)] ;
       for i=1:size(E,2)
           C(i)=sqrt((E(1,i)-g(1))^2+(E(2,i)-g(2))^2);
       end
       [M,I]=min(C(:));
    sx=[sx;E(1,I)];
    sy=[sy;E(2,I)];
%     figure (2);
       l2=line([p(1) E(1,I)],[p(2) E(2,I)], [0 0],'LineWidth',3,'color','g');
       pause(0.5);
 p=[E(1,I) E(2,I)];
 
end
global a;

s=[transpose(sx);transpose(sy)];
S=[transpose(f),s];

hold off
simrobo(S);

robo02();

% function simrobo (g)

