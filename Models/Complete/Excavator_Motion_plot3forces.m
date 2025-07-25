% Code to plot simulation results from Excavator_Motion
%% Plot Description:
%
% The plot below shows the force required of the actuators to complete the test.

% Copyright 2016-2025 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var')) 
%    sim('Excavator_Motion')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end


% Get simulation results
simlog_StickFrc = simOut.logsout_Excavator_Motion.get('ActuatorFrc').Values.StickFrc;
simlog_BoomFrc  = simOut.logsout_Excavator_Motion.get('ActuatorFrc').Values.BoomFrc;
simlog_BucketFrc = simOut.logsout_Excavator_Motion.get('ActuatorFrc').Values.BucketFrc;
simlog_SwingTrq = simOut.logsout_Excavator_Motion.get('ActuatorFrc').Values.SwingTrq;


% Reuse figure if it exists, else create new figure
if ~exist('h1_Excavator_Motion', 'var') || ...
        ~isgraphics(h1_Excavator_Motion, 'figure')
    h1_Excavator_Motion = figure('Name', 'Excavator_Actuator_Force');
end
figure(h1_Excavator_Motion)
clf(h1_Excavator_Motion)

temp_colororder = get(gca,'defaultAxesColorOrder');

% Plot results
simlog_handles(1) = subplot(2, 2, 1);
plot(simlog_StickFrc.Time, squeeze(simlog_StickFrc.Data), 'LineWidth', 1)
grid on
title('Stick Actuator Force')
ylabel('Pressure (N)')

simlog_handles(2) = subplot(2, 2, 2);
plot(simlog_BoomFrc.Time, squeeze(simlog_BoomFrc.Data), 'LineWidth', 1)
grid on
title('Boom Force')
ylabel('Force (N)')

simlog_handles(3) = subplot(2, 2, 3);
plot(simlog_BucketFrc.Time, squeeze(simlog_BucketFrc.Data), 'LineWidth', 1)
grid on
title('Bucket Force')
ylabel('Force (N)')
xlabel('Time(s)')

simlog_handles(4) = subplot(2, 2, 4);
plot(simlog_SwingTrq.Time, squeeze(simlog_SwingTrq.Data), 'LineWidth', 1)
grid on
title('Swing Motor Torque')
ylabel('Torque (N*m)')
xlabel('Time(s)')

linkaxes(simlog_handles(1:3),'xy')
linkaxes(simlog_handles(1:3),'off')
linkaxes(simlog_handles,'x')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
