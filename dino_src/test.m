clear
d=1
[K0,R0,t0] = findLocation(1);
P0 = projectionMatrix(K0,R0,t0)
   
[K1,R1,t1] = findLocation(31);
PK = projectionMatrix(K1,R1,t1)
pk = Pixel_location([20,100],d,P0,PK)