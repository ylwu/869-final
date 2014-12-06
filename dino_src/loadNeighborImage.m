function image = loadNeighborImage(neighbor1,neighbor2,neighbor3,neighbor4,n)
    if n == 1
        image = neighbor1;
    elseif n == 2
        image = neighbor2;
    elseif n == 3
        image = neighbor3;
    else
        image = neighbor4;
    end
end