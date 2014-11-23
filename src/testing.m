%testing script
thres=0.6;
%only values greater than tresh should be here
a=0.6:0.1:1;
csize=16;
%c = Corr(a)
v0=[1,2,3];
%Ncc(v0,v0)
image=imread('templeR0001.png');
m=10
p=[100,130]
result=Find_window_vector(p, image, m);