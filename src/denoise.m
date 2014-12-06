clear

fileID = fopen('depth.txt');
C=textscan(fileID,'%f %f %f');
fclose(fileID);
%find number of neighbor of each point

x=C{1};
y=C{2};
z=C{3};
data=[x,y,z];

row=size(data,1);
result=zeros(row,1);
%0.7 is too big
range=0.001; %to the left and right
for i=1:row,
    %i=randi(row);
    loc=data(i,:);
    low_loc=loc-range;
    high_loc=loc+range;
    
    lowx=low_loc(1);
    highx=high_loc(1);
    lowy=low_loc(2);
    highy=high_loc(2);
    lowz=low_loc(3);
    highz=high_loc(3);
    
    neighbor=data(:,1)>lowx & data(:,2)>lowy & data(:,3)>lowz & data(:,1)<highx & data(:,2)<highy & data(:,3)<highz;
    result(i)=sum(neighbor);
end
hist(result);

