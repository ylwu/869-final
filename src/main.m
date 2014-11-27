clear;
k = 4; % number of neighbors
m = 5; %window size
thresh = .6;
D_min = 0;
D_max = 10; %TODO: change D_max to actual value
d_inc = 0.3; %search increment for D

height = 480;
width  = 640;
nImages = 47;
all_depth_map = zeros(height,width,nImages);
weight_map = zeros(height,width,nImages);
for imageIndex = 1:1
    disp('imageIndex');
    disp(imageIndex);
   neighbor_indices = findNeighbors(imageIndex,k,nImages);
   im = readImage(imageIndex);
   im_h = size(im,1);
   im_w = size(im,2);
   [K0,R0,t0] = findLocation(imageIndex);
   P0 = projectionMatrix(K0,R0,t0);
   %iterate through pixels in the image
   for rowIndex = 1: im_h
       for colIndex = 1: im_w
           %p is a length 3 vector contains RGB value of the pixel
           v0 = Find_window_vector([rowIndex,colIndex],im,m);
           d_max = 0;
           crr_max = 0;
           Cv_max = [];%vector of all valid nccs
           s = 0;
           for d = D_min: d_inc: D_max
                CV = [];
                for n = neighbor_indices
                    [K1,R1,t1] = findLocation(n);
                    PK = projectionMatrix(K1,R1,t1);
                    pk = Pixel_location([rowIndex,colIndex],d,P0,PK);
                    if pk(1) <= 640 && pk(1) > 0 && pk(2) <= 480 && pk(2) > 0
                        im_k = readImage(n);
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
    