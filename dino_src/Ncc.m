function ncc = Ncc(v0,v1)
%assume these are already in n*3 vector format
n=size(v0,1);
new_v0=vertcat(v0(:,1),v0(:,2),v0(:,3));
new_v1=vertcat(v1(:,1),v1(:,2),v1(:,3));
%calculate ncc
v0_mean = sum(new_v0)/(n*3);
v1_mean = sum(new_v1)/(n*3);
v0_new = v0-v0_mean;
v1_new = v1-v1_mean;


numerator = sum(dot(v0_new,v1_new,2));
denom = sqrt(sum(sum(v0_new.*v0_new))+sum(sum(v1_new.*v1_new)));
ncc= numerator/denom;
end