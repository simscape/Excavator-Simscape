% Code to plot simulation results from Excavator_Complete model
%% Plot Description:
%
% The plot below shows the extension of the actuator as the control system
% attempts to track a reference input.  The Piezo Stack can react much
% faster than the DC motor but has a limited range.  The control system
% uses them together to track the reference signal.

% Copyright 2016-2025 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var')) 
%    sim('Excavator_Complete')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end

simlog_t = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Stick.StickCylinder.hard_stop.x.series.time;
simlog_StickPos  = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Stick.StickCylinder.hard_stop.x.series.values('mm');
simlog_BoomPos   = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Boom.LeftBoomCylinder.hard_stop.x.series.values('mm');
simlog_BucketPos = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Bucket.BucketCylinder.hard_stop.x.series.values('mm');
simlog_SwingAng  = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Swing.Motion_Sensor.phi.series.values('deg');

% Reuse figure if it exists, else create new figure
if ~exist('h2_Excavator_Complete', 'var') || ...
        ~isgraphics(h2_Excavator_Complete, 'figure')
    h2_Excavator_Complete = figure('Name', 'Excavator_Actuator_Position');
end
figure(h2_Excavator_Complete)
clf(h2_Excavator_Complete)

yyaxis left
plot(simlog_t, simlog_StickPos, 'LineWidth', 1,'DisplayName','Stick')
hold on
plot(simlog_t, simlog_BoomPos, 'LineWidth', 1,'DisplayName','Boom')
plot(simlog_t, simlog_BucketPos,'-.', 'LineWidth', 1,'DisplayName','Bucket')
ylabel('Extension (mm)')
hold off
yyaxis right
plot(simlog_t, simlog_SwingAng, 'LineWidth', 1,'DisplayName','Swing')
ylim_vals = get(gca,'YLim');
set(gca,'YLim',[-1 1]*max(1,max(abs(ylim_vals))))
grid on
title('Actuator Positions')
ylabel('Angle (deg)')
legend('Location','Best');
xlabel('Time (s)')

text(0.4,0.05,sprintf('Steps, %s',...
    num2str(length(simlog_t))),'Units','Normalized','FontSize',9,...
    'Color',[0.6 0.6 0.6],...
    'HorizontalAlignment','right')

% Remove temporary variables
clear simlog_handles temp_colororder
