clc;
clear all;
close all;

rl=100; %road length
rw=40;   % road width
road=zeros(rl,rw); % creation of empty road

%%%%%generating 10 vehicles randomly on the road%%%%
xpos= randi([1 100],1,10);  
ypos= randi([1 40],1,10);  

for i=1:10
  road(xpos(i),ypos(i))=1;  %%% indication of presence of vehicle
end

%%%%% Dividing segment into clusters %%%%%%

c1=road(1:25,1:40);   cn1=transpose(c1); %creation of first cluster
c2=road(26:50,1:40);  cn2=transpose(c2); %creation of second cluster
c3=road(51:75,1:40);  cn3=transpose(c3); %creation of third cluster
c4=road(76:100,1:40); cn4=transpose(c4); %creation of fourth  cluster

[col1,row1] = find(c1==1);    % finding the position of vehicle in first cluster
pos1 = horzcat(row1,col1);
MCID1=length(col1);          % Indicates No. of members in cluster 1

[col2,row2] = find(c2==1); % finding the position of vehicle in second cluster
col2=col2+25;
pos2 = horzcat(row2,col2);
MCID2=length(col2);          % Indicates No. of members in cluster 2

[col3,row3] = find(c3==1);  % finding the position of vehicle in third  cluster
col3=col3+50;
pos3 = horzcat(row3,col3);
MCID3=length(col3);          % Indicates No. of members in cluster 3

[col4,row4] = find(c4==1);  % finding the position of vehicle in fourth  cluster
col4=col4+75;
pos4 = horzcat(row4,col4);
MCID4=length(col4);          % Indicates No. of members in cluster 4

 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%Intialization of variables for code%%%%%%%%%%%%%%%%%%
row1=transpose(row1);row2=transpose(row2);row3=transpose(row3);row4=transpose(row4);
col1=transpose(col1);col2=transpose(col2);col3=transpose(col3);col4=transpose(col4);
columnn=[col1,col2,col3,col4];
roww=[row1,row2,row3,row4]
MCID=[MCID1 MCID2 MCID3 MCID4];
x1=MCID(1);x2=MCID(2);x3=MCID(3);x4=MCID(4);
v=1;p=1;k=0;
g2=0; g4=0; g6=0; g8=0;
coln1=col1;coln2=col2;coln3=col3;coln4=col4;
MCIDn(1)=MCID(1);MCIDn(2)=MCID(2);MCIDn(3)=MCID(3);MCIDn(4)=MCID(4);
ma=0;mb=0;mc=0;md=0;    
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%logic of code%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
         
         
for time=1:50
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%vehicles moving with different speeds%%%%%%%%%%%
    
           if (MCID(1)~=0)
                 for i=1:MCID(1)
         
                      g1=randi(3);
                      g(i)=g1;
                      coln1(i)=coln1(i)+g1;
                     % vehicle(i)=[row1(i),coln1(i)];
               
                      if g1>=g2
                        ma=g1;
                        g2=g1;
                      else
                        ma=g2;
                      end
                 end
           else
               ma=0;
               g=0;
           end
           
               
          if(MCID(2)~=0)
            for i=1:MCID(2)
               
                g3=randi(2);
                h(i)=g3;
                coln2(i)=coln2(i)+g3;
               % vehicle(i+MCID(1))=[row2(i),coln2(i)];
               
                if g3>=g4
                  mb=g3;
                  g4=g3;
                else
                  mb=g4;
                end
           
             end
          else
              mb=0;
              h=0;
          end
           
           
           if(MCID(3)~=0)
            for i=1:MCID(3)
               
                g5=randi(2);
                j(i)=g5;
                coln3(i)=coln3(i)+g5;
               % vehicle(i+MCID(1)+MCID(2))=[row3(i),coln3(i)]
               
                if g5>=g6
                  mc=g5;
                  g6=g5;
                else
                  mc=g6;
                end
            end
           else
               mc=0;
               j=0;
           end
           
            if (MCID(4)~=0)
            for i=1:MCID(4)
                 g7=randi(3);
                 q(i)=g7;
                coln4(i)=coln4(i)+g7;
               
                if g7>=g8
                  md=g7;
                  g8=g7;
                else
                  md=g8;
                end
            end
            else
            md=0;
            q=0;
            end
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 %%%%%%%%%%thresoldpoint and thresold distance calculation%%%%%
           
          dth1=25-ma;dth2=50-mb;dth3=75-mc;dth4=100-md;
          
           columnn=[coln1,coln2,coln3,coln4];
            column_new=[coln1,coln2,coln3,coln4]
            MCID
         
          th_point=[dth1 dth2 dth3 dth4];
          
          speed=[g h j q];
          speed(speed==0)=[];
           
          
   % th_distance=[]; 
   
   for n=1:4
            
            for VID=k+1:k+MCID(v)
                
                D(VID)=abs(th_point(p)-columnn(VID));
                LT(VID)=D(VID)/speed(VID);
                %th_distance=[th_distance,D];
            end
            k=k+MCID(v);
            p=p+1;
            v=v+1;
            
   end
   
   Lifetime=LT
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %%%%%life time calculation and cluster head election%%%%%%%%%%%%%%%%%%%%%%
  
  % for i=1:10
      % LT(i)=th_distance(i)/speed(i);
  % end
   
    LT1=0;LT2=0;LT3=0;LT4=0;
    
   for i=1:MCID(1)
      LT1=max(LT1,LT(i));
   end
   
  for i=MCID(1)+1:MCID(1)+MCID(2)
       LT2=max(LT2,LT(i));
   end
   
   for i=MCID(1)+MCID(2)+1:MCID(1)+MCID(2)+MCID(3)
       LT3=max(LT3,LT(i));
   end
   
   for i=MCID(1)+MCID(2)+MCID(3)+1:MCID(1)+MCID(2)+MCID(3)+MCID(4)
       LT4=max(LT4,LT(i));
   end
   
   CH_pos1=find(LT(1:MCID(1))==LT1);
   CH_pos2=find(LT(MCID(1)+1:MCID(1)+MCID(2))==LT2);
   CH_pos3=find(LT(MCID(1)+MCID(2)+1:MCID(1)+MCID(2)+MCID(3))==LT3);
   CH_pos4=find(LT(MCID(1)+MCID(2)+MCID(3)+1:MCID(1)+MCID(2)+MCID(3)+MCID(4))==LT4);
   
   CH_select1=column_new(CH_pos1);
   CH_select2=column_new(CH_pos2+MCID(1));
   CH_select3=column_new(CH_pos3+MCID(1)+MCID(2));
   CH_select4=column_new(CH_pos4+MCID(1)+MCID(2)+MCID(3));
   
   cluster_head1=[roww(CH_pos1),CH_select1]
   cluster_head2=[roww(CH_pos2+MCID(1)),CH_select2]
   cluster_head3=[roww(CH_pos3+MCID(1)+MCID(2)),CH_select3]
   cluster_head4=[roww(CH_pos4+MCID(1)+MCID(2)+MCID(3)),CH_select4]
   
   
Location = [transpose(row1),transpose(coln1)];
Life_time1= transpose(Lifetime(1:MCID(1)));
RT_1 = table(Location,Life_time1)
%RT_1([CH_pos1],:) = []
Location = [transpose(row2),transpose(coln2)];
Life_time2 = transpose(Lifetime(MCID(1)+1:MCID(1)+MCID(2)));
RT_2 = table(Location,Life_time2)
%RT_2([CH_pos2],:) = []
Location = [transpose(row3),transpose(coln3)];
Life_time3 = transpose(Lifetime(MCID(1)+MCID(2)+1:MCID(1)+MCID(2)+MCID(3)));
RT_3= table(Location,Life_time3)
%RT_3([CH_pos3],:) = []
Location = [transpose(row4),transpose(coln4)];
Life_time4 = transpose(Lifetime(MCID(1)+MCID(2)+MCID(3)+1:MCID(1)+MCID(2)+MCID(3)+MCID(4)));
RT_4= table(Location,Life_time4)
%RT_4([CH_pos4],:) = []
   
   
   
   
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% finding Cluster length and position of already moved vechicles%%%%
        
        for i=1:x1
              
         if (coln1(i)>25) & (coln1(i)<50) & (x1~=0)
             coln2(MCID(2)+1)=coln1(i);
             row2(MCID(2)+1)=row1(i);
             MCID(2)=MCID(2)+1;
             MCID(1)=MCID(1)-1;
              coln1(i)=0;row1(i)=0;
               MCIDn(2)=MCIDn(2)+1;
               MCIDn(1)=MCIDn(1)-1;
              
         
         %elseif(coln1(i)>50)&(x1~=0)
             %coln3(MCID(3)+1)=coln1(i);
             %MCID(3)=MCID(3)+1;
             %coln1(i)=0;
             %MCIDn(3)=MCIDn(3)+1;
             %MCIDn(1)=MCIDn(1)-1;
         
         end
             
        end
           coln1(coln1==0)=[];
           row1(row1==0)=[];
          
         
      
          for i=1:x2
              
            if (coln2(i)>50) & (coln2(i)<75)& (x2~=0)
               
                coln3(MCID(3)+1)=coln2(i);
                 row3(MCID(3)+1)=row2(i);
                coln2(i)=0;row2(i)=0;
                MCID(3)=MCID(3)+1;
                MCIDn(2)=MCIDn(2)-1;
                MCIDn(3)=MCIDn(3)+1;
           % elseif(coln2(i)>75)& (x2~=0)
            % coln4(MCID(4)+1)=coln2(i);
             %MCID(4)=MCID(4)+1;
             %coln2(i)=0;
             %MCIDn(4)=MCIDn(4)+1;
             %MCIDn(2)=MCIDn(2)-1;
         
               
                  
            end
          
          end
                
           coln2(coln2==0)=[];
           row2(row2==0)=[];
 
      
          for i=1:x3
             if (coln3(i)>75) & (coln3(i)<100)& (x3~=0)
                       
                      coln4(MCID(4)+1)=coln3(i);
                      row4(MCID(4)+1)=row3(i);
                      MCID(4)=MCID(4)+1;
                      coln3(i)=0;row3(i)=0;
                      MCIDn(3)=MCIDn(3)-1;
                      MCIDn(4)=MCIDn(4)+1;
                      
                   % elseif(coln3(i)>100)& (x3~=0)
                    % coln1(MCID(1)+1)=coln3(i)-100;
                     %MCID(1)=MCID(1)+1;
                     %coln3(i)=0;
                      %MCIDn(1)=MCIDn(1)+1;
                       %MCIDn(3)=MCIDn(3)-1;
                      
                     
             end
             
          end
                
               coln3(coln3==0)=[];
               row3(row3==0)=[];
             
                   
            
              for i=1:x4
         
               if ( coln4(i)>100) & (x4~=0)
                         
                    coln1(MCID(1)+1)=coln4(i)-100;
                    row1(MCID(1)+1)=row4(i);
                    MCID(1)=MCID(1)+1;
                    coln4(i)=0;row4(i)=0;
                     MCIDn(1)=MCIDn(1)+1;
                     MCIDn(4)=MCIDn(4)-1;  
                      
                     
                %elseif(coln4(i)>125)& (x4~=0)
                      %coln2(MCID(2)+1)=coln4(i)-100;
                      %MCID(2)=MCID(2)+1;
                      %coln4(i)=0;
                      % MCIDn(4)=MCIDn(4)-1;
                      %MCIDn(2)=MCIDn(2)+1;
               end
              
              end
              
               
               coln4(coln4==0)=[];
               row4(row4==0)=[];
             
              
       
        x1=MCIDn(1); x2=MCIDn(2); x3=MCIDn(3); x4=MCIDn(4);
        
       column2=[coln1,coln2,coln3,coln4];
       roww=[row1,row2,row3,row4];
       columnn=[coln1,coln2,coln3,coln4];
       MCID=MCIDn;
        
       
        v=1;p=1;k=0;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%vehicles are in motion%%%%%%%%%%%%%%%%%%%%%

        
         road=circshift(road,1);
         roadn=transpose(road);
   
   
    imagesc(roadn)
   
   
     
        t1=sprintf('time = %f sec',time);
        title(t1);
       
        pause(1);
        g=[];h=[];j=[];q=[];
        
        T1=D(CH_pos1)/speed(CH_pos1);
        T2=D(CH_pos2)/speed(CH_pos2);
        T3=D(CH_pos3)/speed(CH_pos3);
        T4=D(CH_pos4)/speed(CH_pos4);
        Tavg=(T1+T2+T3+T4)/4;
        nitk=Tavg/(Tavg+1);
        s1=1;
        
        average_throughput(time)=(s1)*((nitk)^10)
        
      
end

         t=1:3:50;
         time=1:3:50;
        
         
         stem(t,average_throughput(time));
         %title('CBLTR protocol without fitting')
         %xlabel('simulation time(seconds)')
         %ylabel('Average throughput')
         
load('spots_num.mat');
plot(t,average_throughput(time));
[pks,locs]=findpeaks(average_throughput(time));
plot(t(locs),pks,'or')
shg
hold on;plot(t,average_throughput(time));
shg

plot(t,average_throughput(time));
stem(t,average_throughput(time));
title('CBLTR protocol with fitting')
xlabel('simulation time(seconds)')
ylabel('Average throughput')
         
         
       
       
    %end



