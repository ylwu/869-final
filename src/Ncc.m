function ncc = Ncc(v0,v1)
%NOT tested!
%assume these are already in n*3 vector format
n=size(v0,2);
%normalize for each color channel first
%v0=v0./repmat(sum(v0,1),n,1);
%v1=v1./repmat(sum(v1,1),n,1);

%calculate ncc
v0_mean = sum(sum(v0))/(n*3);
v1_mean = sum(sum(v1))/(n*3);
v0_new = v0-v0_mean;
v1_new = v1-v1_mean;

numerator = sum(dot(v0_new,v1_new,2));
denom = sqrt(sum(sum(v0_new.*v0_new))+sum(sum(v1_new.*v1_new)));
ncc= numerator/denom;
end