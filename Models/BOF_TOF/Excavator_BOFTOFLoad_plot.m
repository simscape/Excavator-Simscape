function Excavator_BOFTOFLoad_plot(ExcvGlobal, fLoad, test_type, pBoom, pStick, pBucket, pinForces, varargin)
    % Code to plot load chart
    % Copyright 2022-2024 The MathWorks, Inc

    % Define constants for colors and padding
    clrPress = '#A9461F';
    clrPin = 'blue';
    fszPin = 10;
    yLimPaddingFactor = 0.05;

    % Validate optional argument and set up axis handle
    createFigure = true;
    if nargin > 7 && isa(varargin{1}, 'matlab.ui.control.UIAxes') && strcmp(get(varargin{1}, 'type'), 'axes')
        ax_h = varargin{1};
        createFigure = false;
    end

    % Create figure if necessary
    if createFigure
        figString = ['h1_' mfilename];
        persistent fig_h; % Use persistent variable instead of evalin

        if isempty(fig_h) || ~isvalid(fig_h)
            fig_h = figure('Name', figString);
        end
        figure(fig_h);
        clf(fig_h);
        ax_h = gca;
    end

    % Clear axis
    cla(ax_h, 'reset');

    % Add excavator stick figure to plot
    Excavator_Pin_Locations_plotGlobal(ExcvGlobal, ax_h);
    hold(ax_h, 'on');
    axis(ax_h, 'equal');

    % Helper function for adding labels
    function addLabel(xyLabel, textValue, color, alignment, fontSize)
        text(xyLabel(1), xyLabel(2), textValue, ...
            'Color', color, 'HorizontalAlignment', alignment, ...
            'VerticalAlignment', 'middle', 'FontSize', fontSize);
    end

    % Label pressures
    addLabel((ExcvGlobal.Boom.ToBoomCyl + ExcvGlobal.Chassis.ToBoomCyl) / 2, ...
             sprintf('%3.1f bar', pBoom), clrPress, 'left', fszPin);

    addLabel((ExcvGlobal.Boom.ToStickCyl + ExcvGlobal.Stick.ToStickCyl) / 2, ...
             sprintf('%3.1f bar', pStick), clrPress, 'left', fszPin);

    addLabel((ExcvGlobal.Stick.ToBucketCyl + ExcvGlobal.Linkage.ToBucketCyl) / 2, ...
             sprintf('%3.1f bar', pBucket), clrPress, 'left', fszPin);

    % Determine load angle based on test type
    switch test_type
        case 'TOF'
            load_angle = atan2d(ExcvGlobal.Boom.ToStick(2) - ExcvGlobal.Bucket.ToCuttingEdge(2), ...
                                ExcvGlobal.Boom.ToStick(1) - ExcvGlobal.Bucket.ToCuttingEdge(1));
        case 'BOF'
            load_angle = atan2d(ExcvGlobal.Stick.ToBucket(2) - ExcvGlobal.Bucket.ToCuttingEdge(2), ...
                                ExcvGlobal.Stick.ToBucket(1) - ExcvGlobal.Bucket.ToCuttingEdge(1));
        case 'Load'
            load_angle = 180;
        otherwise
            error('Invalid test_type');
    end

    % Plot load vectors
    xyfLoad = [ExcvGlobal.Bucket.ToCuttingEdge; ...
               ExcvGlobal.Bucket.ToCuttingEdge + [cosd(load_angle + 90), sind(load_angle + 90)] * fLoad / 200];
    plot(ax_h, xyfLoad(:, 1), xyfLoad(:, 2), 'r');
    plot(ax_h, xyfLoad(2, 1), xyfLoad(2, 2), 's', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
    addLabel(xyfLoad(2, :), sprintf('%3.1f kN', fLoad), 'r', 'right', fszPin);

    % Label pin loads using a loop for efficiency
    pinLabels = {
        ExcvGlobal.Chassis.ToBoomCyl, pinForces.Boom_Cylinder_To_Chassis;
        ExcvGlobal.Boom.ToBoomCyl, pinForces.Boom_Cylinder_To_Boom;
        ExcvGlobal.Chassis.ToBoom, pinForces.Boom_To_Chassis;
        ExcvGlobal.Boom.ToStickCyl, pinForces.Stick_Cylinder_To_Boom;
        ExcvGlobal.Stick.ToStickCyl, pinForces.Stick_Cylinder_To_Stick;
        ExcvGlobal.Boom.ToStick, pinForces.Boom_To_Stick;
        ExcvGlobal.Stick.ToBucketLinkage, pinForces.Stick_To_Linkage;
        ExcvGlobal.Stick.ToBucket, pinForces.Stick_To_Bucket;
        ExcvGlobal.Bucket.ToBucketLinkage, pinForces.Bucket_To_Linkage;
        ExcvGlobal.Linkage.ToBucketCyl, pinForces.Bucket_Cylinder_To_Linkage
    };

    for i = 1:size(pinLabels, 1)
        addLabel(pinLabels{i, 1}, sprintf('%3.1f kN', pinLabels{i, 2}), clrPin, 'left', fszPin);
    end

    % Adjust axis limits
    ylimits = get(ax_h, 'yLim');
    yLimPad = (ylimits(2) - ylimits(1)) * yLimPaddingFactor;
    set(ax_h, 'YLim', [ylimits(1) - yLimPad, ylimits(2) + yLimPad]);

    % Add legend
    text(0.05, 0.15, 'Cylinder Pressure', 'Color', clrPress, 'Units', 'Normalized', 'FontSize', fszPin);
    text(0.05, 0.1, 'Bucket Force', 'Color', 'r', 'Units', 'Normalized', 'FontSize', fszPin);
    text(0.05, 0.05, 'Pin Load', 'Color', clrPin, 'Units', 'Normalized', 'FontSize', fszPin);
    hold off;
end
