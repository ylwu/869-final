load('all_depth_map_23.mat');
load('weight_map_23.mat');

boundbox_min = [-0.023121; -0.038009 ;-0.091940];
boundbox_max = [0.078626; 0.121636; -0.017395];
row = 480;
col = 640;

output=zeros(3,row*col*12);
fileID = fopen('../data/templeRing/templeR_par.txt');
C=textscan(fileID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
count=1;

for i=[2:5:27,3:5:28]
    depth=all_depth_map(:,:,i);
    [K,R,t] = findLocation(i,C);
    P = projectionMatrix(K,R,t);
    invp=inv(P);

    for y=1:row
        for x=1:col
            z=depth(y,x,1);
            if z~=0 && weight_map(y,x,i) > 700
                v=invp*[x;y;1;z];
                v=v/v(4);
                loc = v(1:3);
                if (sum(loc < boundbox_min) + sum(loc > boundbox_max) == 0)
                    output(:,count)=loc ;
                    count=count+1;
                end
            end
        end
    end
end
fid = fopen('depth.ply', 'w');

% print a title, followed by a blank line
fprintf(fid, 'ply\n format ascii 1.0\n element vertex %d\n property float x\n property float y\n property float z\n end_header\n',count);

% print values in column order
% two values appear on each row of the file
fprintf(fid, '%f  %f %f \n', output(:,1:count));
fclose(fid);
