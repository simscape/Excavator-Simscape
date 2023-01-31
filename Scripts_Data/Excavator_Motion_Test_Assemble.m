% Code to take simulation results and add motion profiles to variable
% activeTestPos, for use in Excavator_Motion.slx

% Copyright 2022-2023 The MathWorks, Inc

stickPos  = timeseries(simlog_StickPos.Data,simlog_StickPos.Time);
boomPos   = timeseries(simlog_BoomPos.Data,simlog_BoomPos.Time);
bucketPos = timeseries(simlog_BucketPos.Data,simlog_BucketPos.Time);
swingAng  = timeseries(simlog_SwingAng.Data,simlog_SwingAng.Time);

activeTestPos = Simulink.SimulationData.Dataset;
activeTestPos = addElement(activeTestPos,swingAng,'swingAng');
activeTestPos = addElement(activeTestPos,boomPos,'boomPos');
activeTestPos = addElement(activeTestPos,stickPos,'stickPos');
activeTestPos = addElement(activeTestPos,bucketPos,'bucketPos');
