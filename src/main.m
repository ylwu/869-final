k = 4; % number of neighbors
m = 5; %window size
thresh = 6;
D_max = 10; %TODO: change D_max to actual value
d_inc = 0.1; %search increment for D

height = 480;
width  = 640;
nImages = 47;
all_depth_map = zeros(nImages,height,width);
for imageIndex = 1:nImages
   neighbor_indices = findNeighbors(imageIndex,k,31);
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
           CV_max = 0;
           size = 0;
           for d = 0: d_inc: D_max
                CV = [];
                for n = 1:neighbor_indices
                    [K1,R1,t1] = findLocation(n);
                    PK = projectionMatrix(K1,R1,t1);
                    pk = Pixel_location([rowIndex,colIndex],d,P0,PK);
                    im_k = readImage(n);
                    v1 = Find_window_vector(pk,n,m);
                    ncc = Ncc(v0,v1);
                    if ncc > thresh
                        CV = [CV ncc];
                    end
                end
                CV_valid = Corr(CV);
                if CV_valid > CV_max
                    CV_max = CV_valid;
                    d_max = d;
                    size = size(CV,2);
                end
           end
           conf = Conf(CV_max,thresh,size);
           all_depth_map(imageIndex,rowIndex,colIndex) = conf;
       end
   end
end
    