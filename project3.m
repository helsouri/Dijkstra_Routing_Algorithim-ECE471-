%routing algorithm
clear all; close all;
N=7; % DEFINES N
rand('seed',123456); % generates fixed random seed
x=randi([10, 90],1,N); % chooses N numberes between 10 and 90
y=randi([10, 90],1,N); % chooses N numberes between 10 and 90
x(1)=0; % sets first element in x to 0
y(1)=0; % sets first element in y to 0
x(N)=100; % sets last element in x to 100
y(N)=100; % sets first element in y to 100
figure % initializes a figure
plot(x(2:N-1),y(2:N-1),'o','markersize',15,'markerfacecolor','k'); % plots all points (except first and last) according to x y coordinates
hold on;
plot([x(1) x(N)],[y(1) y(N)],'s','markersize',15,'markerfacecolor','b'); % plots first and last
grid on;
for i=1:N % names all the points
text(x(i),y(i)+5,strcat('N',num2str(i)));
end
source=[1]; % going from first point
dest=[2:N]; % to all points after
w=ones(1,N)*inf; % makes an array of N elements where each elemrnt is set to inf (at first distance for all is inf)
w(1)=0; % sets first element in w to 0
for loop=1:N-1
    d=[];
    for i=1:length(dest)
        j=dest(i); % set j equal i'th element of dest array
        for k=1:length(source)
            l=source(k);
            dd=sqrt((x(j)-x(l))^2+(y(j)-y(l))^2); % dist formula
         if dd>60
            dd=inf;
          end
         d(i,k)=dd+w(l);
        end
    end
    dim=size(d);
    if dim(2)~=1
     d=min(d);
    end
    [md,idx]=min(d);
    j=dest(idx);
    pause(1);
    plot(x(j),y(j),'rs','markersize',20,'linewidth',1.5);
    text(x(j),y(j)-5,num2str(md));
    source=[source j];
    dest(idx)=[];
    w(j)=md;
    plot([x(idx), x(j)] , [y(idx), y(j)]);
    text(((x(idx)+x(j))/2),((y(idx)+y(j))/2),num2str(loop));
    pause(1);
end