function neighbors = findNeighbors(index,k,total)
    neighbors = mod([index - floor(k/2) : (index +ceil(k/2)-1)],total+1);
end