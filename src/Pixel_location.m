function pk = Pixel_location(p0,d,inv_P0,PK)
    x0 = [p0';1;d];
    x1 = PK * inv_P0 * x0;
    x1 = x1/x1(3);
    pk = x1(1:2);
end