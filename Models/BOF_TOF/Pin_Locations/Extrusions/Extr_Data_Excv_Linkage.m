function [xy_linkage_stickLink, xy_linkage_bucketLink] = Extr_Data_Excv_Linkage(Linkage)
% Function to create extrusion for linkage from pin locations

% Copyright 2022-2024 The MathWorks, Inc

L = Linkage.LengthToStick;
W = 0.2;
r = 0.4*W;

[xy_linkage_stickLink] = Extr_Data_LinkHoles(L, W, r, 2);
xy_linkage_stickLink = xy_linkage_stickLink+[L/2 0];
%theta = 90;
theta = 0;
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_linkage_stickLink = xy_linkage_stickLink*R;

L = Linkage.LengthToBucket;
W = 0.2;
r = 0.4*W;

[xy_linkage_bucketLink] = Extr_Data_LinkHoles(L, W, r, 2);
xy_linkage_bucketLink = xy_linkage_bucketLink-[L/2 0];

theta = 90;
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
xy_linkage_bucketLink = xy_linkage_bucketLink*R;
