function ncc = Ncc(v0,v1)
%assume these are already in n*3 vector format
n=size(v0,1);
%calculate ncc
v0_new=vertcat(v0(:,1)-mean(v0(:,1)),v0(:,2)-mean(v0(:,2)),v0(:,3)-mean(v0(:,3)));
v1_new=vertcat(v1(:,1)-mean(v1(:,1)),v1(:,2)-mean(v1(:,2)),v1(:,3)-mean(v1(:,3)));

numerator = sum(dot(v0_new,v1_new,2));
denom = sqrt(sum(sum(v0_new.*v0_new))+sum(sum(v1_new.*v1_new)));
ncc= numerator/denom;
end