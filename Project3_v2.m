clear all; 
close all;
%parameters to edit-----
N=15;
MaxDist = 40;
rand('seed',69);
%rand(1,1337);
%-----------------------
INF = 10000;
x=randi([10,90],1,N);%Setups up random nodes
y=randi([10,90],1,N);
x(1)=0;
y(1)=0;
x(N)=100;
y(N)=100;
short=ones(2,N);
DistMat = [];
for i=1:N
    short(2,i) = INF; %sets the shortest length to this node %at the start all nodes are in respect to 1
    for j=1:N
        DistMat(i,j) = sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);
        if DistMat(i,j)>MaxDist
            DistMat(i,j)=INF;%infinite
        end
    end
end
short(2,1) = 0; %node 1 distance is 0
fig = figure
plot(x(2:N-1),y(2:N-1),'o','markersize',15,'markerfacecolor','k');%Circles
hold on;
plot([x(1) x(N)],[y(1) y(N)],'s','markersize',15,'markerfacecolor','b');%End square
grid on;
for i=1:N
    text(x(i),y(i)+5,strcat('N',num2str(i)));%node names
end
Aval=[1:N]%all avalible nodes
Done=[];%holds nodes already visited

for t=1:N
    shortest = INF+1;%resets the longest distance
    if(t==1)%start at node 1
        Cnode = 1;
    else
        for k=2:N  
            if(~ismember(k,Done) && shortest>short(2,k))%if not already finished
               Cnode = k;                               %select the shortest path
               shortest = short(2,k);
            end
        end
    end
    Done(1,t)=Cnode;
    
    Aval = setdiff(Aval,[Cnode]); %strip current node from avalable
    for j=1:length(Aval)
        if (DistMat(Cnode,Aval(j))<MaxDist)%checks if jump is resonable
            if(1==1)
                if(DistMat(Cnode,Aval(j))+short(2,Cnode)<short(2,Aval(j)))%checks and sees if new path is shorter
                    short(2,Aval(j)) = DistMat(Cnode,Aval(j))+short(2,Cnode);%new distance
                    short(1,Aval(j)) = Cnode;                                %new base node
                    if(short(2,Aval(j))<shortest)   %if its the shortest set it as the shortest
                       shortest = short(2,Aval(j));
                    end
                end
            end
        end
    end
    for i=2:N%prints out the current minimum distance to each node
        if(short(2,(i))<INF)%only print if distnace isn't infinite
            plots(i) = plot([x((i));x(short(1,(i)))],[y((i));y(short(1,(i)))],'linewidth',1.5)
            plotst(i) = text((x((i))+x(short(1,(i))))/2,(y((i))+y(short(1,(i))))/2-5,num2str(short(2,(i))));
        end
    end
    %saveas(fig,num2str(t),'png')
    pause(1);
    for i=2:N%clears previous nodes.
        if(short(2,(i))<INF)%only delete drawn ones
            delete(plots(i));
            delete(plotst(i));
        end
    end
end
pause(5);

i = N;%last node
while(i ~= 1)%first node
    if(short(2,i)<INF)%only print if distnace isn't infinite
        plots(i) = plot([x(i);x(short(1,i))],[y(i);y(short(1,i))],'linewidth',1.5)
        text((x(i)+x(short(1,i)))/2,(y(i)+y(short(1,i)))/2-5,num2str(short(2,i)));
        i = short(1,i);
    pause(1);
    end
end
pause(1);