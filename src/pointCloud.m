a=load('depth_map8_9.mat');
depth8=a.all_depth_map(:,:,8);

fileID = fopen('../data/templeRing/templeR_par.txt');
C=textscan(fileID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
[K,R,t] = findLocation(8,C);
P = projectionMatrix(K,R,t);
invp=inv(P);

[row,col]=size(depth8);
output=zeros(row*col,3);
count=1;
for x=1:row,
    for y=1:col,
        z=depth8(x,y,:);
        v=invp*[x;y;1;z];
       % v=v/v(4);
        output(count,:)=v(1:3);
        count=count+1;
    end
end

fid = fopen('depth8.txt', 'w');

% print a title, followed by a blank line
fprintf(fid, 'ply\n format ascii 1.0\n element vertex 307200\n property float x\n property float y\n property float z\n end_header\n');

% print values in column order
% two values appear on each row of the file
fprintf(fid, '%f  %f %f\n', output);
fclose(fid);
