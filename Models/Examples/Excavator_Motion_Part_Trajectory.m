% Code to take simulation results and add motion profiles to variable
% activeTestPos, for use in Excavator_Motion.slx

% Copyright 2022-2023 The MathWorks, Inc

% Extract bucket trajectory from motion test model
bucket_posOri = simOut.logsout_Excavator_Motion.get('FramePosOri').Values.Bucket;

% Format as timeseries
bucket_x  = timeseries(bucket_posOri.xyz.Data(:,1),bucket_posOri.xyz.Time);
bucket_y  = timeseries(bucket_posOri.xyz.Data(:,2),bucket_posOri.xyz.Time);
bucket_z  = timeseries(bucket_posOri.xyz.Data(:,3),bucket_posOri.xyz.Time);
bucket_qz  = timeseries(bucket_posOri.ypr.Data(1,:)',bucket_posOri.ypr.Time);
bucket_qy  = timeseries(bucket_posOri.ypr.Data(2,:)',bucket_posOri.ypr.Time);
bucket_qx  = timeseries(bucket_posOri.ypr.Data(3,:)',bucket_posOri.ypr.Time);

% Unwrap contained in model - code kept for reference
%bucket_qzu  = timeseries(unwrap(bucket_posOri.ypr.Data(1,:)'*pi/180)*180/pi,bucket_posOri.ypr.Time);
%bucket_qyu  = timeseries(unwrap(bucket_posOri.ypr.Data(2,:)'*pi/180)*180/pi,bucket_posOri.ypr.Time);
%bucket_qxu  = timeseries(unwrap(bucket_posOri.ypr.Data(3,:)'*pi/180)*180/pi,bucket_posOri.ypr.Time);


% Assemble as SimulationData Dataset for use as input in test model
bucketTestPos = Simulink.SimulationData.Dataset;
bucketTestPos = addElement(bucketTestPos,bucket_x,'bucket_x');
bucketTestPos = addElement(bucketTestPos,bucket_y,'bucket_y');
bucketTestPos = addElement(bucketTestPos,bucket_z,'bucket_z');
bucketTestPos = addElement(bucketTestPos,bucket_qx,'bucket_qx');
bucketTestPos = addElement(bucketTestPos,bucket_qy,'bucket_qy');
bucketTestPos = addElement(bucketTestPos,bucket_qz,'bucket_qz');

%bucketTestPos = addElement(bucketTestPos,bucket_qxu,'bucket_qx');
%bucketTestPos = addElement(bucketTestPos,bucket_qyu,'bucket_qy');
%bucketTestPos = addElement(bucketTestPos,bucket_qzu,'bucket_qz');