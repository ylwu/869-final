

fileID = fopen('../data/dino/dino_par.txt');
C=textscan(fileID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
[K6,R6,t6] = findLocation(13,C);
P6 = projectionMatrix(K6,R6,t6);
[K3,R3,t3] = findLocation(45,C); 
P3 = projectionMatrix(K3,R3,t3);

p=[511,240];

im6=readImage(45);
imshow(im6);
hold on

for d=1:0.01:2
   
    pk = Pixel_location([p(1),p(2)],d,P3,P6);
    plot(pk(1),pk(2),'r.','MarkerSize',20)
end