function P = projectionMatrix(K,R,t)
    A = [[K;[0,0,0]],[0;0;0;1]];
    B = [[R,t];[0,0,0,1]];
    P = A * B;
end