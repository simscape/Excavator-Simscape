% Script to run (instead of edit) Excavator Design app
% and ensure only one copy of the UI is opened.

% Copyright 2022-2024 The MathWorks, Inc.

if(exist('Excavator_Design_app_uifigure','var'))
    if(~isempty(Excavator_Design_app_uifigure))
        if(length(Excavator_Design_app_uifigure.findprop('Excavator_Design'))==1)
            % Figure is already open, bring it to the front
            figure(Excavator_Design_app_uifigure.Excavator_Design);
        else
            % Open UI again and store figure handle
            Excavator_Design_app_uifigure = Excavator_Design_app;
        end
    else
        % Open UI again and store figure handle
        Excavator_Design_app_uifigure = Excavator_Design_app;
    end
else
    % Open UI again and store figure handle
    Excavator_Design_app_uifigure = Excavator_Design_app;
end
