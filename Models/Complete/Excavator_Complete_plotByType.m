%% Script to plot results for all blocks of a certain type

% Model to be searched
modelName = 'Excavator_Complete';

% Search parameters
f = Simulink.FindOptions('FollowLinks',true,'LookUnderMasks','All',...
    'MatchFilter', @Simulink.match.activeVariants);

% List of reference blocks and variable names
refBlks = {...
    'SimscapeFluids_lib/Isothermal Liquid/Valves & Orifices/Directional Control Valves/Check Valve (IL)','mdot_A';
    'SimscapeFluids_lib/Isothermal Liquid/Valves & Orifices/Pressure Control Valves/Pressure Relief Valve (IL)','mdot_A'};

% Load libraries where reference blocks live
load_system('SimscapeFluids_lib')

% Loop over list of reference blocks
for rb_i = 1:size(refBlks,1)

    % Create one figure per entry in refBlks
    figure(rb_i)
    ax_h = gca;
    refBlkName = get_param(refBlks{rb_i,1},'Name');
    crInds = findstr(refBlkName,char(10));
    refBlkName(crInds) = ' ';

    % Find all blocks in model that have Reference Block type
    bh = Simulink.findBlocks(modelName,'ReferenceBlock',refBlks{rb_i,1},f);

    % Loop over blocks that were found
    for i=1:length(bh)

        % Get path through simlog to plot variable
        blkName = get_param(bh(i),'Name');

        % Eliminate carriage returns
        crInds = findstr(blkName,char(10));
        blkName(crInds) = ' ';
        pth = getfullname(bh(i));
        repStr = modelName;
        pth = pth(length(repStr)+2:end);
        nodeData = get(simOut.simlog_Excavator_Complete,pth);
        varData = get(nodeData,refBlks{rb_i,2});

        % Plot results
        plot(ax_h,varData.series.time,varData.series.values,'DisplayName',blkName)
        hold(ax_h,'on');
    end
    hold(ax_h,'off');
    legend(ax_h,'Location','Best')
    title(ax_h,[refBlkName ', ' strrep(refBlks{rb_i,2},'_','\_')])
end
