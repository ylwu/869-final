clear;
clc;
k = 4; % number of neighbors
m = 5; %window size
thresh = .6;
D_min = 0;
D_max = 10; %TODO: change D_max to actual value
d_inc = 2; %search increment for D

height = 480;
width  = 640;
nImages = 31;
all_images = zeros(height,width,3,nImages);
all_depth_map = zeros(height,width,nImages);
weight_map = zeros(height,width,nImages);

for i = 1:nImages
    all_images(:,:,:,i) = readImage(i);
end

fileID = fopen('../data/templeRing/templeR_par.txt');
C=textscan(fileID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
for imageIndex = 4:4
   neighbor_indices = findNeighbors(imageIndex,k,nImages)
   neighbor1 = loadImage(all_images,neighbor_indices(1));
   neighbor2 = loadImage(all_images,neighbor_indices(2));
   neighbor3 = loadImage(all_images,neighbor_indices(3));
   neighbor4 = loadImage(all_images,neighbor_indices(4));
   im = loadImage(all_images,imageIndex);
   im_h = size(im,1);
   im_w = size(im,2);
   [K0,R0,t0] = findLocation(imageIndex,C);
   K_neighbors = zeros(3,3,k);
   R_neighbors = zeros(3,3,k);
   t_neighbors = zeros(3,1,k);
   for i = 1:k
       [K,R,t] = findLocation(neighbor_indices(i),C);
       K_neighbors(:,:,i) = K;
       R_neighbors(:,:,i) = R;
       t_neighbors(:,:,i) = t;
   end
   
   P0 = projectionMatrix(K0,R0,t0);
   %iterate through pixels in the image
   parfor rowIndex = 1: im_h
       for colIndex = 1: im_w
           %p is a length 3 vector contains RGB value of the pixel
           v0 = Find_window_vector([rowIndex,colIndex],im,m);
           d_max = 0;
           crr_max = 0;
           Cv_max = [];%vector of all valid nccs
           s = 0;
           for d = D_min: d_inc: D_max
                CV = [];
                for n = 1:k
                    K1 = K_neighbors(:,:,n);
                    R1 = R_neighbors(:,:,n);
                    t1 = t_neighbors(:,:,n);
                    PK = projectionMatrix(K1,R1,t1);
                    pk = Pixel_location([rowIndex,colIndex],d,P0,PK);
                    if pk(1) <= 640 && pk(1) > 0 && pk(2) <= 480 && pk(2) > 0
                        im_k = loadNeighborImage(neighbor1,neighbor2,neighbor3,neighbor4,n);
                        v1 = Find_window_vector(pk,im_k,m);
                        ncc = Ncc(v0,v1);
                        if ncc > thresh
                            CV = [CV ncc];
                        end
                    end
                end
                crr = Corr(CV);
                if crr > crr_max
                    crr_max = crr;
                    d_max = d;
                    Cv_max = CV;
                end
           end
           conf = Conf(Cv_max,thresh,k);
           if isnan(conf)
                all_depth_map(rowIndex,colIndex,imageIndex) = d;
                weight_map(rowIndex,colIndex,imageIndex) = conf;
           end
       end
   end
end
    