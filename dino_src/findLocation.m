function [K,R,t] = findLocation(i,C)
%may want to optimize this by reading everything at the beginning
% fileID = fopen('../data/templeRing/templeR_par.txt');
% C=textscan(fileID,'%s %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f');

K=[C{2}(i),C{3}(i),C{4}(i);C{5}(i),C{6}(i),C{7}(i);C{8}(i),C{9}(i),C{10}(i)];
R=[C{11}(i),C{12}(i),C{13}(i);C{14}(i),C{15}(i),C{16}(i);C{17}(i),C{18}(i),C{19}(i)];
t=[C{20}(i);C{21}(i);C{22}(i)];
%fclose(fileID);
end