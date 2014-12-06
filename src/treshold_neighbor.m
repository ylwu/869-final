neighbor=load('neighbor_count.mat');
noisy=load('noisy_data');
thresh=2;
row = size(neighbor.result,1);
output=zeros(3,row);
count=1;
for i=1:row
    if neighbor.result(i)>thresh
        output(:,count)=noisy.data(i,:)';
        count=count+1;
    end
end

fid = fopen('clean_depth_001_tr2.txt', 'w');

% print a title, followed by a blank line
fprintf(fid, 'ply\n format ascii 1.0\nelement vertex %d\nproperty float x\nproperty float y\nproperty float z\nend_header\n',count);

% print values in column order
% two values appear on each row of the file
fprintf(fid, '%f  %f %f\n', output(:,1:count));
fclose(fid);