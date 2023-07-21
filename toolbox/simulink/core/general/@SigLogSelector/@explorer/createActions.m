function h=createActions(h)




    h.actions=Simulink.sdi.Map(' ',?handle);
    h.actionstate=Simulink.sdi.Map(' ',?handle);

    am=DAStudio.ActionManager;
    am.initializeClient(h);

    locCreateFileActions(h,am);
    locCreateViewActions(h,am);
    locCreateHelpActions(h,am);
    locCreateContextActions(h,am);
end


function locCreateFileActions(h,am)


    action=am.createDefaultAction(h,'FILE_CLOSE');
    action.StatusTip=...
    DAStudio.message('Simulink:Logging:SigLogDlgCloseStatusTip');
    h.actions.insert('FILE_CLOSE',action);

end


function locCreateViewActions(h,am)


    h.isLoadingActions=true;


    action=am.createAction(h,...
    'Callback','SigLogSelector.cb_toggleViewFilter(''VIEW_MASKS'')',...
    'toggleAction','on');
    action.icon=fullfile(...
    matlabroot,...
    'toolbox',...
    'shared',...
    'dastudio',...
    'resources',...
    'showmaskmask_comp.png');
    action.Text=...
    DAStudio.message('Simulink:Logging:SigLogDlgShowMasksText');
    action.StatusTip=...
    DAStudio.message('Simulink:Logging:SigLogDlgShowMasksStatusTip');


    val=h.getPreference('ShowMasks');
    if~isempty(val)
        action.on=val;
    end

    h.actions.insert('VIEW_MASKS',action);


    menu_action=am.createAction(h,...
    'Callback','SigLogSelector.cb_toggleViewFilter(''VIEW_MASKS_MENU'')',...
    'toggleAction','on');
    menu_action.Text=action.Text;
    menu_action.StatusTip=action.StatusTip;
    menu_action.on=action.on;
    h.actions.insert('VIEW_MASKS_MENU',menu_action);


    action=am.createAction(h,...
    'Callback','SigLogSelector.cb_toggleViewFilter(''VIEW_LINKS'')',...
    'toggleAction','on');
    action.icon=fullfile(...
    matlabroot,...
    'toolbox',...
    'shared',...
    'dastudio',...
    'resources',...
    'showlinkmask_comp.png');
    action.Text=...
    DAStudio.message('Simulink:Logging:SigLogDlgShowLinksText');
    action.StatusTip=...
    DAStudio.message('Simulink:Logging:SigLogDlgShowLinksStatusTip');


    val=h.getPreference('ShowLibraries');
    if~isempty(val)
        action.on=val;
    else
        action.on='on';
    end

    h.actions.insert('VIEW_LINKS',action);


    menu_action=am.createAction(h,...
    'Callback','SigLogSelector.cb_toggleViewFilter(''VIEW_LINKS_MENU'')',...
    'toggleAction','on');
    menu_action.Text=action.Text;
    menu_action.StatusTip=action.StatusTip;
    menu_action.on=action.on;
    h.actions.insert('VIEW_LINKS_MENU',menu_action);


    action=am.createAction(h,...
    'Callback','SigLogSelector.cb_toggleViewFilter(''VIEW_ALL_SUBSYS'')',...
    'toggleAction','on');
    action.icon=fullfile(...
    matlabroot,...
    'toolbox',...
    'shared',...
    'dastudio',...
    'resources',...
    'currentsystembelow.png');
    action.Text=...
    DAStudio.message('Simulink:Logging:SigLogDlgShowAllText');
    action.StatusTip=...
    DAStudio.message('Simulink:Logging:SigLogDlgShowAllStatusTip');


    val=h.getPreference('ShowAll');
    if~isempty(val)
        action.on=val;
    end

    h.actions.insert('VIEW_ALL_SUBSYS',action);


    menu_action=am.createAction(h,...
    'Callback','SigLogSelector.cb_toggleViewFilter(''VIEW_ALL_SUBSYS_MENU'')',...
    'toggleAction','on');
    menu_action.Text=action.Text;
    menu_action.StatusTip=action.StatusTip;
    menu_action.on=action.on;
    h.actions.insert('VIEW_ALL_SUBSYS_MENU',menu_action);

    h.isLoadingActions=false;


    action=am.createAction(h,...
    'Callback','SigLogSelector.cb_launchConfigParams');
    action.icon=fullfile(...
    matlabroot,...
    'toolbox',...
    'shared',...
    'dastudio',...
    'resources',...
    'Configuration.png');
    action.Text=...
    DAStudio.message('Simulink:Logging:SigLogDlgLaunchConfigParams');
    action.StatusTip=...
    DAStudio.message('Simulink:Logging:SigLogDlgLaunchConfigParamsStatusTip');

    h.actions.insert('VIEW_CONFIG_PARAMS',action);

end


function locCreateHelpActions(h,am)


    action=am.createAction(h,...
    'Callback',...
    'helpview([docroot, ''/toolbox/simulink/ug/simulink_ug.map''], ''logging_signal_intro'')');
    action.icon=fullfile(...
    matlabroot,...
    'toolbox',...
    'simulink',...
    'core',...
    'general',...
    '@SigLogSelector',...
    'resources',...
    'help.png');
    action.Text=...
    DAStudio.message('Simulink:Logging:SigLogDlgHelpText');
    action.StatusTip=...
    DAStudio.message('Simulink:Logging:SigLogDlgHelpStatusTip');
    h.actions.insert('HELP_LOGDLG',action);

end


function locCreateContextActions(h,am)


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextOpen',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuOpen'));
    h.actions.insert('CONTEXT_OPEN',action);


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextHighlight(true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuHighlight'));
    h.actions.insert('CONTEXT_HIGHLIGHT',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextHighlight(false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuUnhighlight'));
    h.actions.insert('CONTEXT_UNHIGHLIGHT',action);


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextProperties',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuProperties'));
    h.actions.insert('CONTEXT_PROPERTIES',action);


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''all'',false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleAllInSystem'));
    h.actions.insert('CONTEXT_ALL_IN',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''all'',true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleAllInAndBelow'));
    h.actions.insert('CONTEXT_ALL_IN_AND_BELOW',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''bounds'')',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleBoundaries'));
    h.actions.insert('CONTEXT_BOUNDARIES',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''named'',false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleNamedInSystem'));
    h.actions.insert('CONTEXT_ALL_NAMED_IN',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''named'',true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleNamedInAndBelow'));
    h.actions.insert('CONTEXT_ALL_NAMED_IN_AND_BELOW',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''unnamed'',false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleUnNamedInSystem'));
    h.actions.insert('CONTEXT_ALL_UNNAMED_IN',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(true,''unnamed'',true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleUnNamedInAndBelow'));
    h.actions.insert('CONTEXT_ALL_UNNAMED_IN_AND_BELOW',action);


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''all'',false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleAllInSystem'));
    h.actions.insert('CONTEXT_ALL_IN_OFF',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''all'',true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleAllInAndBelow'));
    h.actions.insert('CONTEXT_ALL_IN_AND_BELOW_OFF',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''bounds'')',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleBoundaries'));
    h.actions.insert('CONTEXT_BOUNDARIES_OFF',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''named'',false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleNamedInSystem'));
    h.actions.insert('CONTEXT_ALL_NAMED_IN_OFF',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''named'',true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleNamedInAndBelow'));
    h.actions.insert('CONTEXT_ALL_NAMED_IN_AND_BELOW_OFF',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''unnamed'',false)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleUnNamedInSystem'));
    h.actions.insert('CONTEXT_ALL_UNNAMED_IN_OFF',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextEnableLogging(false,''unnamed'',true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgToggleUnNamedInAndBelow'));
    h.actions.insert('CONTEXT_ALL_UNNAMED_IN_AND_BELOW_OFF',action);


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextHighlight(true, true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuHighlight'));
    h.actions.insert('CONTEXT_SIG_HIGHLIGHT',action);

    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextHighlight(false, true)',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuUnhighlight'));
    h.actions.insert('CONTEXT_SIG_UNHIGHLIGHT',action);


    action=am.createAction(h,...
    'Callback',...
    'SigLogSelector.cb_contextSignalProperties',...
    'Text',...
    DAStudio.message('Simulink:Logging:SigLogDlgContextMenuSigProperties'));
    h.actions.insert('CONTEXT_SIG_PROPERTIES',action);

end

