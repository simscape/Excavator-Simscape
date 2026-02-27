% Code to plot simulation results from Excavator_Complete
%% Plot Description:
%
% The plot below shows the pressures in the actuators.

% Copyright 2016-2025 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var')) 
%    sim('Excavator_Complete')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end


% Get simulation results
simlog_t = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Stick.StickCylinder.A.p.series.time;

%simlog_StickHEPr = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.StickHEPr;
%simlog_StickREPr = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.StickREPr;
simlog_StickHEPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Stick.StickCylinder.A.p.series.values('bar');
simlog_StickREPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Stick.StickCylinder.B.p.series.values('bar');

%simlog_BoomHEPr  = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.BoomHEPr;
%simlog_BoomREPr  = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.BoomREPr;
simlog_BoomHEPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Boom.LeftBoomCylinder.A.p.series.values('bar');
simlog_BoomREPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Boom.LeftBoomCylinder.B.p.series.values('bar');


%simlog_BucketHEPr = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.BucketHEPr;
%simlog_BucketREPr = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.BucketREPr;
simlog_BucketHEPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Bucket.BucketCylinder.A.p.series.values('bar');
simlog_BucketREPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Bucket.BucketCylinder.B.p.series.values('bar');

%simlog_SwingAPr = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.SwingASidePr;
%simlog_SwingBPr = simOut.logsout_Excavator_Complete.get('PressureSensors').Values.SwingBSidePr;
simlog_SwingAPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Swing.SwingMotor.A.p.series.values('bar');
simlog_SwingBPr = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Swing.SwingMotor.B.p.series.values('bar');


% Reuse figure if it exists, else create new figure
if ~exist('h1_Excavator_Complete', 'var') || ...
        ~isgraphics(h1_Excavator_Complete, 'figure')
    h1_Excavator_Complete = figure('Name', 'Excavator_Actuator_Pressure');
end
figure(h1_Excavator_Complete)
clf(h1_Excavator_Complete)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 2, 1);
plot(simlog_t, simlog_StickHEPr, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_StickREPr, 'LineWidth', 1)
hold off
grid on
title('Stick Cylinder Pressures')
ylabel('Pressure (bar)')
legend({'Head','Rod'},'Location','Best');

simlog_handles(2) = subplot(2, 2, 2);
plot(simlog_t, simlog_BoomHEPr, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_BoomREPr, 'LineWidth', 1)
hold off
grid on
title('Boom Cylinder Pressures')
ylabel('Pressure (bar)')
legend({'Head','Rod'},'Location','Best');

simlog_handles(3) = subplot(2, 2, 3);
plot(simlog_t, simlog_BucketHEPr, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_BucketREPr, 'LineWidth', 1)
hold off
grid on
title('Bucket Cylinder Pressures')
ylabel('Pressure (bar)')
xlabel('Time(s)')
legend({'Head','Rod'},'Location','Best');

simlog_handles(4) = subplot(2, 2, 4);
plot(simlog_t, simlog_SwingAPr, 'LineWidth', 1)
hold on
plot(simlog_t, simlog_SwingBPr, 'LineWidth', 1)
hold off
grid on
title('Swing Motor Pressures')
ylabel('Pressure (bar)')
xlabel('Time(s)')

legend({'Side A','Side B'},'Location','Best');

linkaxes(simlog_handles,'xy')
linkaxes(simlog_handles,'off')
linkaxes(simlog_handles,'x')

% Remove temporary variables
clear simlog_handles temp_colororder
