function x = InsideBox(invP,x,y,z,boundbox_min,boundbox_max)
    v=invP*[x;y;1;z];
    v=v/v(4);
    loc = v(1:3);
    x =  (sum(loc < boundbox_min) + sum(loc > boundbox_max) == 0);
end