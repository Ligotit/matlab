function val=getDisplayIcon(h)






    if isempty(h.hBdNode)||~h.hBdNode.isLoaded
        val=fullfile(...
        'toolbox',...
        'shared',...
        'dastudio',...
        'resources',...
        'simulink_model_reference_not_loaded.png');
    else
        val=fullfile(...
        'toolbox',...
        'shared',...
        'dastudio',...
        'resources',...
        'simulink_model_reference.png');
    end

end