function im = readImage(n)
    src_image_prefix = '../data/templeRing/templeR00';
    src_image_suffix = '.png';
    image_uri = '';
    if n < 10
        image_uri = strcat(src_image_prefix,'0',int2str(n),src_image_suffix);
    else
        image_uri = strcat(src_image_prefix,int2str(n),src_image_suffix);
    end
    im = imread(image_uri);
end