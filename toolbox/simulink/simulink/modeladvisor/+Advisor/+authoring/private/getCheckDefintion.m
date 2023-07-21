function mcode=getCheckDefintion(checkDef)
    tab=sprintf('\t');
    lb=sprintf('\n');
    autoGenStartComment='% THE FOLLOWING CODE IS AUTO GENERATED AND MAY NOT WORK IF MODIFIED';
    autoGenEndComment='% END OF AUTO GENERATED CODE';


    filteredID=regexprep(checkDef.ID,'\W','_');
    checkDefFctName=['define_',filteredID];

    if checkDef.SupportExclusion
        exclusionStr='rec.SupportExclusion = true;';
    else
        exclusionStr='rec.SupportExclusion = false;';
    end

    if checkDef.SupportLibrary
        libStr='rec.SupportLibrary = true;';
    else
        libStr='rec.SupportLibrary = false;';
    end

    mcode=[tab,'rec = ModelAdvisor.Check(''',checkDef.ID,''');',lb,...
    tab,'rec.Title = ''',checkDef.Title,''';',lb,...
    tab,'rec.setCallbackFcn(@callback_',filteredID,', ''',checkDef.CompileStatus,''', ''StyleOne'');',lb,...
    tab,'rec.TitleTips = ''',checkDef.ToolTip,''';',lb,...
    tab,'rec.Value = true;',lb,...
    tab,'rec.setLicense({''SL_Verification_Validation''});',lb,...
    tab,'rec.ErrorSeverity = 0;',lb,...
    tab,exclusionStr,lb,...
    tab,libStr,lb,lb,...
    tab,'% --- data file input parameters',lb,...
    tab,'rec.setInputParametersLayoutGrid([1 1]);',lb,...
    tab,'inputParam1 = ModelAdvisor.InputParameter;',lb,...
    tab,'inputParam1.Name = ''',DAStudio.message('Advisor:engine:CCDataFile'),''';',lb,...
    tab,'inputParam1.Value = ''',checkDef.InputParameters{1}.Value,''';',lb,...
    tab,'inputParam1.Visible = false;',lb,...
    tab,'inputParam1.Type = ''String'';',lb,...
    tab,'inputParam1.Description = ''',DAStudio.message('Advisor:engine:CCDataFileDescription'),''';',lb,...
    tab,'inputParam1.setRowSpan([1 1]);',lb,...
    tab,'inputParam1.setColSpan([1 1]);',lb,...
    tab,'rec.setInputParameters({inputParam1});',lb...
    ];

    if checkDef.HasAction
        mcode=[mcode,lb,...
        tab,'% -- set fix operation',lb,...
        tab,'act = ModelAdvisor.Action;',lb,...
        tab,'act.setCallbackFcn(@(task)(Advisor.authoring.CustomCheck.actionCallback(task)));',lb,...
        tab,'act.Name = ''',DAStudio.message('Advisor:engine:CCModifyButton'),''';',lb,...
        tab,'act.Description = ''',DAStudio.message('Advisor:engine:CCActionDescription'),''';',lb,...
        tab,'rec.setAction(act);',lb,...
        ];
    end


    mcode=[mcode,...
    tab,'mdladvRoot = ModelAdvisor.Root;',lb,...
    tab,'mdladvRoot.register(rec);',lb,...
    ];

    mcode=[lb,lb,...
    autoGenStartComment,lb,...
    '% registration of check ',checkDef.ID,lb,...
    'function ',checkDefFctName,'()',lb,...
    mcode,lb,...
    'end',lb,...
    autoGenEndComment,lb,lb,...
    ];
end