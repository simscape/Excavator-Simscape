% Additional parameters for Excavator project
% Mostly appearance, some default values

% Copyright 2022-2025 The MathWorks, Inc


excv_data.arm.clr = [1 1 0]';
excv_data.arm.opc = 1;
excv_data.arm.thk = 0.2;
excv_data.link.clr  = 0.6*[1 1 1]';
excv_data.link.thk  = 0.22;
excv_data.link.opc  = 1;

excv_data.chassis.thk  = 1;
excv_data.chassis.clr  =[0.5 0.5 0.5];

excv_data.bucket.thk  = excv_data.arm.thk*1.05;
excv_data.bucket.clr  = [1 1 0]';

excv_data.pin.clr    = [1 0 0];
excv_data.pin.rad    = 0.1;
excv_data.pin.len    = 0.3;
excv_data.pin.opc    = 1;

excv_data.cyl.clr    = [0.4 0.4 0.4];
excv_data.cyl.rad    = 0.1*2;
excv_data.cyl.opc    = 0.2;

excv_data.boomcyl.len     = 2.5;
excv_data.stickcyl.len    = 3.0;
excv_data.bucketcyl.len   = 1.4;

excv_data.boompist.len    = 2.5;
excv_data.stickpist.len   = 3.0;
excv_data.bucketpist.len  = 1.4;


excv_data.pist.clr    = [0.8 0.8 0.8];
excv_data.pist.rad    = 0.075*2;
excv_data.pist.opc    = 0.2;

excv_data.cyl_force.clr = [0.0 0.4 0.8];
excv_data.cyl_force.opc = 0.5;
excv_data.cyl_force.depth = 0.5;
excv_data.cyl_force.line_width = 0.15;
excv_data.cyl_force.tip_length = 0.75;
excv_data.cyl_force.max_length = 3;
excv_data.cyl_force.max_force  = 2e6;

% For Load Chart Tests onl
load ExcavatorAssemblyDataStruct.mat

BOFTOF_boomAngle = 90;
BOFTOF_stickAngle = 90;
BOFTOF_bucketAngle = 90;

forceTestMaxActiveCylPr = 350;
forceTestMaxReactiveCylPr = 400;

BOFTOF_BoomCylArea   = pi * (220/2)^2 - pi*(150/2)^2; % mm^2
BOFTOF_StickCylArea  = pi * (250/2)^2; % mm^2
BOFTOF_BucketCylArea = pi * (220/2)^2; % mm^2

LoadChart_BoomMass   = 7.22651e+03;
LoadChart_StickMass  = 3.32788e+03;
LoadChart_BucketMass = 5.11951e+03;

