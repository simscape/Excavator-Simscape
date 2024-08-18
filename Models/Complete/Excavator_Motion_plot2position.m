% Code to plot simulation results from Excavator_Motion model
%% Plot Description:
%
% The plot below shows the extension of the actuator as the control system
% attempts to track a reference input.  The Piezo Stack can react much
% faster than the DC motor but has a limited range.  The control system
% uses them together to track the reference signal.

% Copyright 2016-2024 The MathWorks, Inc.

% Generate new simulation results if they don't exist or if they need to be updated
%if ~exist('simlog', 'var')) 
%    sim('Excavator_Motion')
%    % Model StopFcn callback adds a timestamp to the Simscape simulation data log
%end

simlog_StickPos  = simOut.logsout_Excavator_Motion.get('PosSensors').Values.StickPos;
simlog_BoomPos   = simOut.logsout_Excavator_Motion.get('PosSensors').Values.BoomPos;
simlog_BucketPos = simOut.logsout_Excavator_Motion.get('PosSensors').Values.BucketPos;
simlog_SwingAng  = simOut.logsout_Excavator_Motion.get('PosSensors').Values.SwingAng;

% Reuse figure if it exists, else create new figure
if ~exist('h2_Excavator_Motion', 'var') || ...
        ~isgraphics(h2_Excavator_Motion, 'figure')
    h2_Excavator_Motion = figure('Name', 'Excavator_Actuator_Position');
end
figure(h2_Excavator_Motion)
clf(h2_Excavator_Motion)

lhndl=[];
yyaxis left
lhndl(1) = plot(activeTestPos.getElement('stickPos').Time,activeTestPos.getElement('stickPos').Data,'k-','LineWidth',1);
hold on
lhndl(2) = plot(activeTestPos.getElement('boomPos').Time,activeTestPos.getElement('boomPos').Data,'k-','LineWidth',1);
lhndl(3) = plot(activeTestPos.getElement('bucketPos').Time,activeTestPos.getElement('bucketPos').Data,'k-','LineWidth',1,'DisplayName','Command');
lhndl(4) = plot(simlog_StickPos.Time, squeeze(simlog_StickPos.Data)*1000, 'LineStyle','-', 'LineWidth', 2,'DisplayName','Stick');
lhndl(5) = plot(simlog_BoomPos.Time, squeeze(simlog_BoomPos.Data)*1000, '--', 'LineWidth', 2,'DisplayName','Boom');
lhndl(6) = plot(simlog_BucketPos.Time, squeeze(simlog_BucketPos.Data)*1000,'-.', 'LineWidth', 2,'DisplayName','Bucket');
hold off
ylabel('Extension (mm)')
yyaxis right
lhndl(7) = plot(activeTestPos.getElement('swingAng').Time,activeTestPos.getElement('swingAng').Data,'k-','LineWidth',1,'DisplayName','Command');
hold on
lhndl(8) = plot(simlog_SwingAng.Time, squeeze(simlog_SwingAng.Data)*180/pi, 'LineWidth', 2,'DisplayName','Swing');
hold off
ylim_vals = get(gca,'YLim');
set(gca,'YLim',[-1 1]*max(1,max(abs(ylim_vals))))
grid on
title('Actuator Positions')
ylabel('Angle (deg)')
legend(lhndl([3:6,8]),'Location','Best');
xlabel('Time (s)')

% Remove temporary variables
clear simlog_t simlog_handles temp_colororder
clear simlog_xLeadscrew simlog_xMeas simlog_xRef simlog_xStack