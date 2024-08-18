%% Excavator Energy Calculations
%
% This code extracts the energy input and energy output of the excavator.
% The mechanical power of the pump shafts and the mechanical power of the
% output actuators are summed over the period of the test.  This simple
% calculation does not include potential energy stored in the system due to
% gravity.  This calculation will give misleading results if the system
% does not return to its original height.

% Copyright 2022-2024 The MathWorks, Inc

% Time
if(~exist('simOut'))
    error('Please run the excavator simulation to generate results for the energy calculation.')
else

    simlogTime = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.RightPump.RightPump.mechanical_power.series.time;  % [s]

    % Pump input energy
    leftPumpMechPower = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.RightPump.RightPump.mechanical_power.series.values('kW'); % [kW]
    rightPumpMechPower = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.LeftPump.LeftPump.mechanical_power.series.values('kW'); % [kW]
    pumpMechPowerSum = leftPumpMechPower + rightPumpMechPower; % [kW]
    pumpEnergy = cumsum(pumpMechPowerSum(2:end) .* diff(simlogTime)); % [kJ]

    % Boom Cylinder Energy
    boomVelocity = simOut.simlog_Excavator_Complete.Excavator.Machine.Boom_Cyl_R.RightBoomCylToRightBoomPiston.Translational_Multibody_Interface.v.series.values('m/s'); % [m/s]
    boomForce = (simOut.simlog_Excavator_Complete.Excavator.Machine.Boom_Cyl_R.RightBoomCylToRightBoomPiston.Translational_Multibody_Interface.f.series.values('kN')).*2; % [kN]
    boomPower = boomVelocity .* boomForce; % [kW]
    boomEnergy = cumsum(boomPower(2:end) .* diff(simlogTime)); % [kJ]

    % Stick Cylinder Energy
    stickVelocity = simOut.simlog_Excavator_Complete.Excavator.Machine.Stick_Cyl.StickCylToStickPiston.Translational_Multibody_Interface.v.series.values('m/s'); % [m/s]
    stickForce = simOut.simlog_Excavator_Complete.Excavator.Machine.Stick_Cyl.StickCylToStickPiston.Translational_Multibody_Interface.f.series.values('kN'); % [kN]
    stickPower = stickVelocity .* stickForce; % [kW]
    stickEnergy = cumsum(stickPower(2:end) .* diff(simlogTime)); % [kJ]

    % Bucket Cylinder Energy
    bucketVelocity = simOut.simlog_Excavator_Complete.Excavator.Machine.Bucket_Cyl.BucketCylToBucketPiston.Translational_Multibody_Interface.v.series.values('m/s'); % [m/s]
    bucketForce = simOut.simlog_Excavator_Complete.Excavator.Machine.Bucket_Cyl.BucketCylToBucketPiston.Translational_Multibody_Interface.f.series.values('kN'); % [kN]
    bucketPower = abs(bucketVelocity .* bucketForce); % [kW]
    bucketEnergy = cumsum(bucketPower(2:end) .* diff(simlogTime)); % [kJ]

    % Swing Energy
    swingGBOutSpeed = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Swing.SwingGearBox.O.w.series.values('rad/s'); % [rad/s]
    swingGBOutTorque = simOut.simlog_Excavator_Complete.Excavator.Hydraulics.Functions.Swing.SwingGearBox.t_out.series.values('kN*m'); % [kNm]
    swingPower = abs(swingGBOutSpeed .* swingGBOutTorque); % [kW]
    swingEnergy = cumsum(swingPower(2:end) .* diff(simlogTime)); % [kJ]

    % Cumulative Function Energy
    functionEnergy = boomEnergy + stickEnergy + bucketEnergy + swingEnergy; % [kJ]

    % Total pump energy in
    totalPumpEnergyIn = pumpEnergy(end); % [kJ]

    % Total energy out
    totalEnergyOut = functionEnergy(end); % [kJ]

    % Energy Efficiency
    energyEfficiency = 100*(totalEnergyOut/totalPumpEnergyIn);

    %% Figures
    titleHeader = 'Dig Cycle Energy';

    % Energy In vs Energy Out - Simple

    if ~exist('h4_Excavator_Energy', 'var') || ...
            ~isgraphics(h4_Excavator_Energy, 'figure')
        h4_Excavator_Energy = figure('Name', 'Excavator_Energy');
    end
    figure(h4_Excavator_Energy)
    clf(h4_Excavator_Energy)

    set(h4_Excavator_Energy,'numbertitle','off','name','Energy In vs Energy Out Simple');
    hold on;
    title({['Excavator Model: ' activeScenario ];'Energy In vs Energy Out'});

    energyInColor  = '#D3790A';
    energyOutColor = '#135788';
    

    plot(simlogTime(2:end), pumpEnergy,'linewidth',3,'color',energyInColor);
    plot(simlogTime(2:end), functionEnergy,'linewidth',3,'color',energyOutColor);
    text(0.95,0.35,['Pump Shaft Energy In: ' num2str(totalPumpEnergyIn,4) ' kJ'],...
        'Units','Normalized','FontSize',12,'HorizontalAlign','right');
    text(0.95,0.275,['Energy Out: ' num2str(totalEnergyOut,4) ' kJ'],...
        'Units','Normalized','FontSize',12,'HorizontalAlign','right');
    text(0.95,0.2,['Efficiency: ' num2str(energyEfficiency,3) '%'],...
        'Units','Normalized','FontSize',12,'HorizontalAlign','right');
    grid on;
    box on
    %xlim([0 ceil(simlogTime(end))]);
    %xticks(1:1:ceil(simlogTime(end)));
    xlabel('Time (s)');
    ylabel('Energy (kJ)');
    legend('Pump Shaft Energy In','Function Energy Out','Location','northwest');
    hold off;


    % Energy In vs Energy Out - Detailed
    if ~exist('h5_Excavator_Energy', 'var') || ...
            ~isgraphics(h5_Excavator_Energy, 'figure')
        h5_Excavator_Energy = figure('Name', 'Excavator_Energy');
    end
    figure(h5_Excavator_Energy)
    clf(h5_Excavator_Energy)

    set(h5_Excavator_Energy,'numbertitle','off','name','Energy In vs Energy Out Detailed');
    temp_colororder = get(gca,'defaultAxesColorOrder');
    hold on;
    title({['Excavator Model: ' activeScenario ];'Energy In vs Energy Out Detailed'});
    plot(simlogTime(2:end), pumpEnergy,'linewidth',3,'color',energyInColor);
    plot(simlogTime(2:end), functionEnergy,'linewidth',3,'color',energyOutColor);
    plot(simlogTime(2:end), boomEnergy,':','linewidth',2,'color',temp_colororder(3,:));
    plot(simlogTime(2:end), stickEnergy,'-.','linewidth',2,'color',temp_colororder(2,:));
    plot(simlogTime(2:end), bucketEnergy,'-.','linewidth',1,'color',temp_colororder(1,:));
    plot(simlogTime(2:end), swingEnergy,'--','linewidth',1,'color',temp_colororder(4,:));
    text(9,4500,['Pump Shaft Energy In: ' num2str(totalPumpEnergyIn,4) ' kJ'],'FontSize',14,'HorizontalAlign','right');
    text(9,4150,['Hydraulic Energy Out: ' num2str(totalEnergyOut,4) ' kJ'],'FontSize',14,'HorizontalAlign','right');
    grid on;
    box on
    %xlim([0 ceil(simlogTime(end))]);
    %xticks(1:1:ceil(simlogTime(end)));
    xlabel('Time (s)');
    ylabel('Energy (kJ)');
    legend('Pump Shaft Energy In','Hydraulic Energy Out','Boom Energy',...
        'Stick Energy','Bucket Energy','Swing Energy','Location','northwest','NumColumns',2);
    hold off;
end