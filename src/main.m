clear;
clc;
k = 4; % number of neighbors
m = 5; %window size
thresh = .7;
D_min = 1;
D_max = 2; %TODO: change D_max to actual value
d_inc = 0.01; %search increment for D

height = 480;
width  = 640;
nImages = 31;
boundbox_min = [-0.023121; -0.038009 ;-0.091940];
boundbox_max = [0.078626; 0.121636; -0.017395];
all_images = zeros(height,width,3,nImages);
all_depth_map = zeros(height,width,nImages);
weight_map = zeros(height,width,nImages);

for i = 1:nImages
    all_images(:,:,:,i) = readImage(i);
end

fileID = fopen('../data/templeRing/templeR_par.txt');
C=textscan(fileID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');
fclose(fileID);
for imageIndex = 3:3
   tic
   neighbor_indices = findNeighbors(imageIndex,k,nImages)
   neighbor1 = loadImage(all_images,neighbor_indices(1));
   neighbor2 = loadImage(all_images,neighbor_indices(2));
   neighbor3 = loadImage(all_images,neighbor_indices(3));
   neighbor4 = loadImage(all_images,neighbor_indices(4));
   im = loadImage(all_images,imageIndex);
   im_h = size(im,1);
   im_w = size(im,2);
   [K0,R0,t0] = findLocation(imageIndex,C);
   P0 = projectionMatrix(K0,R0,t0);
   inv_P0 = inv(P0);
   PMatrix_neighbors = {};
   for i = 1:k
       [K,R,t] = findLocation(neighbor_indices(i),C);
       PMatrix_neighbors{i} = projectionMatrix(K,R,t);
   end
   
   %iterate through pixels in the image
   parfor rowIndex = 1: im_h
       %rowIndex
       for colIndex = 1: im_w
           if mean(im(rowIndex,colIndex,:)) <= 1
               continue;
           end
           %p is a length 3 vector contains RGB value of the pixel
           v0 = Find_window_vector([rowIndex,colIndex],im,m);
           d_max = 0;
           crr_max = 0;
           Cv_max = [];%vector of all valid nccs
           s = 0;
           
           inside_box = false;
           for d = D_min: d_inc: D_max
                CV = [];
                if (InsideBox(inv_P0,colIndex,rowIndex,d,boundbox_min,boundbox_max) == false)
                    if (inside_box)
                        inside_box = false;
                        break;
                    else
                        continue;
                    end
                else
                    inside_box = true;
                    for n = 1:k
                        PK = PMatrix_neighbors{n};
                        pk = Pixel_location([colIndex,rowIndex],d,inv_P0,PK);
                        if pk(1) <= 480 && pk(1) > 0 && pk(2) <= 640 && pk(2) > 0
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
           end
           conf = Conf(Cv_max,thresh,k);
           if ~isnan(conf)
                all_depth_map(rowIndex,colIndex,imageIndex) = d_max;
                weight_map(rowIndex,colIndex,imageIndex) = conf;
           end
  
       end
   end
   toc
end
save('all_depth_map_3.mat','all_depth_map');
save('weight_map_3.mat','weight_map');
    