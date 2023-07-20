function newID=convertCheckID(oldID,varargin)








    matchTable={'Check model and local libraries for updates requiring compile time information','mathworks.design.UpdateRequireCompile';...
    'Check model and local libraries for updates','mathworks.design.Update';...
    'Identify questionable fixed-point operations','mathworks.codegen.QuestionableFxptOperations';...
    'Identify Sum, Min/Max, Compare blocks with questionable fixed-point operations','mathworks.codegen.BlockSpecificQuestionableFxptOperations';...
    'Identify unconnected lines, input ports, and output ports','mathworks.design.UnconnectedLinesPorts';...
    'Check root model Inport block specifications','mathworks.design.RootInportSpec';...
    'Identify blocks that generate expensive saturation and rounding code','mathworks.codegen.ExpensiveSaturationRoundingCode';...
    'Check solver for code generation','mathworks.codegen.SolverCodeGen';...
    'Identify questionable blocks within the specified system','mathworks.codegen.QuestionableBlks';...
    'Check for model reference configuration mismatch','mathworks.codegen.MdlrefConfigMismatch';...
    'Check the hardware implementation','mathworks.codegen.HWImplementation';...
    'Check optimization settings','mathworks.design.OptimizationSettings';...
    'Identify questionable software environment specifications','mathworks.codegen.SWEnvironmentSpec';...
    'Identify questionable code instrumentation (data I/O)','mathworks.codegen.CodeInstrumentation';...
    'Check sample times and tasking mode','mathworks.codegen.SampleTimesTaskingMode';...
    'Check for blocks that have constraints on tunable parameters','mathworks.codegen.ConstraintsTunableParam';...
    'Check simulation configuration settings for model reference','mathworks.design.ModelRefSIMConfigCompliance';...
    'Check code generation configuration settings for model reference','mathworks.codegen.ModelRefRTWConfigCompliance';...
    'Check for parameter tunability information ignored by Simulink','mathworks.design.ParamTunabilityIgnored';...
    'Check for implicit signal resolution','mathworks.design.ImplicitSignalResolution';...
    'Check for optimal bus virtuality','mathworks.design.OptBusVirtuality';...
    'Check Unit Delay and/or Zero-Order Hold blocks behaving as rate transition','mathworks.design.ReplaceZOHDelayByRTB';...
    'Check for bus signals treated as vectors','mathworks.design.BusTreatedAsVector';...
    'Check for calls to slDataTypeAndScale','mathworks.design.CallslDataTypeAndScale';...
    'Check for potentially delayed function-call subsystem return values','mathworks.design.DelayedFcnCallSubsys';...
    'Check for Discrete-Time Integrator blocks with initial condition uncertainty','mathworks.design.DiscreteTimeIntegratorInitCondition';...
    'Identify questionable subsystem settings','mathworks.codegen.QuestionableSubsysSetting';...
    'Identify block output signals with continuous sample time and non-floating point data type','mathworks.design.OutputSignalSampleTime';...
    'Disabled Library Links','mathworks.design.DisabledLibLinks';...
    'Parameterized Library Links','mathworks.design.ParameterizedLibLinks';...
    'Unresolved Library Links','mathworks.design.UnresolvedLibLinks';...
    'Check Merge block usage','mathworks.design.MergeBlkUsage';...
    'Check for proper Merge block usage','mathworks.design.MergeBlkUsage';...
    'Check consistency of initialization parameters for Outport and Merge blocks','mathworks.design.InitParamOutportMergeBlk';...
    'Check Requirement Documents','mathworks.req.Documents';...
    'Check Requirement Identifiers','mathworks.req.Identifiers';...
    'Check Requirement Labels','mathworks.req.Labels';...
    'Check Requirement Paths','mathworks.req.Paths';...
    'com.mathworks.FPCA.CheckModelSimulationConfiguration','mathworks.fpa.CheckModelSimulationConfiguration';...
    'com.mathworks.FPCA.CheckHardwareSelection','mathworks.fpa.CheckHardwareSelection';...
    'com.mathworks.FPCA.CheckDataValidityDiagnosticsForParameters','mathworks.fpa.CheckDataValidityDiagnosticsForParameters';...
    'com.mathworks.FPCA.CheckSimulationRangeChecking','mathworks.fpa.CheckSimulationRangeChecking';...
    'com.mathworks.FPCA.CheckImplicitSignalResolution','mathworks.fpa.CheckImplicitSignalResolution';...
    'com.mathworks.FPCA.CheckStrongDataTypingWithSimulinkIO','mathworks.fpa.CheckStrongDataTypingWithSimulinkIO';...
    'com.mathworks.FPCA.CheckUnsupportedBlocks','mathworks.fpa.CheckUnsupportedBlocks';...
    'com.mathworks.FPCA.CheckSpecifyDesignMinMaxValue','mathworks.fpa.CheckSpecifyDesignMinMaxValue';...
    'com.mathworks.FPCA.CheckSummarizeLockDownKnownScaling','mathworks.fpa.CheckSummarizeLockDownKnownScaling';...
    'com.mathworks.FPCA.CheckUpdateDiagramStatus','mathworks.fpa.CheckUpdateDiagramStatus';...
    'com.mathworks.FPCA.CheckSetupSignalLogging','mathworks.fpa.CheckSetupSignalLogging';...
    'com.mathworks.FPCA.CheckCreateReferenceData','mathworks.fpa.CheckCreateReferenceData';...
    'com.mathworks.FPCA.CheckImplementLogicSignalsAsBooleanData','mathworks.fpa.CheckImplementLogicSignalsAsBooleanData';...
    'com.mathworks.FPCA.CheckAssociateSDOWithBlocks','mathworks.fpa.CheckAssociateSDOWithBlocks';...
    'com.mathworks.FPCA.CheckRemoveOutputDataTypeInheritance','mathworks.fpa.CheckRemoveOutputDataTypeInheritance';...
    'com.mathworks.FPCA.CheckRelaxInputDatatypeSettings','mathworks.fpa.CheckRelaxInputDatatypeSettings';...
    'com.mathworks.FPCA.CheckCurrentDataTypes','mathworks.fpa.CheckCurrentDataTypes';...
    'com.mathworks.FPCA.CheckProposeDefaultScaling','mathworks.fpa.CheckProposeDefaultScaling';...
    'com.mathworks.FPCA.CheckCurrentNumericErrors','mathworks.fpa.CheckCurrentNumericErrors';...
    'com.mathworks.FPCA.CheckAnalyzeLoggedSignals','mathworks.fpa.CheckAnalyzeLoggedSignals';...
    'mathworks.misra.blocksupport','mathworks.misra.BlkSupport';...
    'mathworks.misra.codegensettings','mathworks.misra.CodeGenSettings';...
    'mathworks.misra.compliantcgirconstructions','mathworks.misra.CompliantCGIRConstructions';...
    'mathworks.misra.recursioncompliance','mathworks.misra.RecursionCompliance';...
    'com.mathworks.MA.codegensanity','mathworks.codegen.CodeGenSanity';...
    'mathworks.design.MAPartialBusParameters','mathworks.design.MismatchedBusParams';...
    'mathworks.design.PartialBusParams','mathworks.design.MismatchedBusParams';...
    'mathworks.design.MAMismatchedBusParameters','mathworks.design.MismatchedBusParams';...
    'ModelAdvisor:PerfAndAccuracy:SFunctionValidation','mathworks.design.DiagnosticSFcn';...
    'ModelAdvisor:DSMBlocks:DSMReadWriteOrderCheck','mathworks.design.DiagnosticDataStoreBlk';...
    'ModelAdvisor:PerfAndAccuracy:DSMReadWriteOrderCheck','mathworks.design.OrderingDataStoreAccess';...
    'com.mathworks.MA.CheckDataStoreProperUsage','mathworks.design.DataStoreMemoryBlkIssue';...
    'com.mathworks.sorting.datastoresimrtwcmp','mathworks.design.datastoresimrtwcmp';...
    'ModelAdvisor:PerfAndAccuracy:NonContSigDerivPort','mathworks.design.NonContSigDerivPort';...
    'ModelAdvisor:DSMBlocks:ContOrZOHDSM','mathworks.design.DataStoreBlkSampleTime';...
    'ModelAdvisor:PerfAndAccuracy:ContOrZOHDSM','mathworks.design.DataStoreBlkSampleTime';...
    'ModelAdvisor:DSMBlocks:ReadWriteStaticCheckUsage','mathworks.design.OrderingDataStoreAccess';...
    'DO178B:CodeSet','mathworks.do178.CodeSet';...
    'DO178B:CompatibilityDiagnosticsSet','mathworks.do178.CompatibilityDiagnosticsSet';...
    'DO178B:ConnectivityBussesDiagnosticsSet','mathworks.do178.ConnectivityBussesDiagnosticsSet';...
    'DO178B:ConnectivitySignalsDiagnosticsSet','mathworks.do178.ConnectivitySignalsDiagnosticsSet';...
    'DO178B:DataStoreMemoryDiagnosticsSet','mathworks.do178.DataStoreMemoryDiagnosticsSet';...
    'DO178B:DataValidityDebugDiagnosticsSet','mathworks.do178.DataValidityDebugDiagnosticsSet';...
    'DO178B:InitializationDiagnosticsSet','mathworks.do178.InitDiagnosticsSet';...
    'DO178B:DataValidityParametersDiagnosticsSet','mathworks.do178.DataValidityParamDiagnosticsSet';...
    'DO178B:DataValiditySignalsDiagnosticsSet','mathworks.do178.DataValiditySignalsDiagnosticsSet';...
    'DO178B:FunctionCallDiagnosticsSet','mathworks.do178.FcnCallDiagnosticsSet';...
    'DO178B:ModelReferenceDiagnosticsSet','mathworks.do178.MdlrefDiagnosticsSet';...
    'DO178B:ModelReferenceOptionsSet','mathworks.do178.MdlrefOptSet';...
    'DO178B:OptionSet','mathworks.do178.OptionSet';...
    'DO178B:RequirementInfo','mathworks.do178.RequirementInfo';...
    'DO178B:SampleTimeDiagnosticsSet','mathworks.do178.SampleTimeDiagnosticsSet';...
    'DO178B:SavingDiagnosticsSet','mathworks.do178.SavingDiagnosticsSet';...
    'DO178B:SolverDiagnosticsSet','mathworks.do178.SolverDiagnosticsSet';...
    'mathworks.do178b.hisf_0011','mathworks.do178.hisf_0011';...
    'mathworks.do178b.hisf_0001','mathworks.do178.hisf_0001';...
    'mathworks.do178b.hisf_0002','mathworks.do178.hisf_0002';...
    'DO178B:TypeConversionDiagnosticsSet','mathworks.do178.TypeConversionDiagnosticsSet';...
    'DO178B:mathBlocksUsage','mathworks.do178.MathBlksUsage';...
    'DO178B:forBlock','mathworks.do178.PortsSubsystemsUsage';...
    'mathworks.do178.ForBlk','mathworks.do178.PortsSubsystemsUsage';...
    'DO178B:whileBlock','mathworks.do178.PortsSubsystemsUsage';...
    'mathworks.do178.WhileBlk','mathworks.do178.PortsSubsystemsUsage';...
    'DO178B:ModelChecksum','mathworks.do178.MdlChecksum';...
    'DO178B:absBlock','mathworks.do178.MathOperationsBlocksUsage';...
    'mathworks.do178.AbsBlk','mathworks.do178.MathOperationsBlocksUsage';...
    'DO178B:relopBlock','mathworks.do178.LogicBlockUsage';...
    'mathworks.do178.RelopBlk','mathworks.do178.LogicBlockUsage';...
    'IEC61508:ModelMetricsInfo','mathworks.iec61508.MdlMetricsInfo';...
    'IEC61508:UnconnectedObjects','mathworks.iec61508.UnconnectedObjects';...
    'IEC61508:RootLevelInports','mathworks.iec61508.RootLevelInports';...
    'IEC61508:QuestionableBlocks','mathworks.iec61508.QuestionableBlks';...
    'IEC61508:StateflowProperUsage','mathworks.iec61508.StateflowProperUsage';...
    'IEC61508:RequirementInfo','mathworks.iec61508.RequirementInfo';...
    'IEC61508:ModelVersionInfo','mathworks.iec61508.MdlVersionInfo';...
    'IEC61508:ProperUsage','mathworks.iec61508.PortsSubsystemsUsage';...
    'mathworks.iec61508.ProperUsage','mathworks.iec61508.PortsSubsystemsUsage';...
    'StyleGuide: db_0043','mathworks.jmaab.db_0043';...
    'mathworks.maab.db_0043','mathworks.jmaab.db_0043';...
    'StyleGuide: db_0132','mathworks.jmaab.db_0132';...
    'mathworks.maab.db_0132','mathworks.jmaab.db_0132';...
    'StyleGuide: db_0140','mathworks.maab.db_0140';...
    'StyleGuide: jc_0141','mathworks.maab.jc_0141';...
    'StyleGuide: jc_0531','mathworks.jmaab.jc_0531';...
    'mathworks.maab.jc_0531','mathworks.jmaab.jc_0531';...
    'StyleGuide: na_0008','mathworks.maab.na_0008';...
    'StyleGuide: na_0009','mathworks.maab.na_0009';...
    'StyleGuide: na_0010','mathworks.jmaab.na_0010';...
    'mathworks.maab.na_0010','mathworks.jmaab.na_0010';...
    'StyleGuide: db_0112','mathworks.jmaab.db_0112';...
    'mathworks.maab.db_0112','mathworks.jmaab.db_0112';...
    'StyleGuide: ar_0001','mathworks.jmaab.ar_0001';...
    'mathworks.maab.ar_0001','mathworks.jmaab.ar_0001';...
    'StyleGuide: ar_0002','mathworks.jmaab.ar_0002';...
    'mathworks.maab.ar_0002','mathworks.jmaab.ar_0002';...
    'StyleGuide: jm_0001','mathworks.maab.jm_0001';...
    'StyleGuide: hd_0001','mathworks.maab.hd_0001';...
    'StyleGuide: db_0042','mathworks.jmaab.db_0042';...
    'mathworks.maab.db_0042','mathworks.jmaab.db_0042';...
    'StyleGuide: jm_0010','mathworks.maab.jm_0010';...
    'StyleGuide: db_0142','mathworks.maab.db_0142';...
    'StyleGuide: db_0143','mathworks.maab.db_0143';...
    'StyleGuide: db_0081','mathworks.maab.db_0081';...
    'StyleGuide: db_0146','mathworks.jmaab.db_0146';...
    'mathworks.maab.db_0146','mathworks.jmaab.db_0146';...
    'StyleGuide: jm_0013','mathworks.maab.jm_0013';...
    'StyleGuide: db_0110','mathworks.maab.db_0110';...
    'StyleGuide: db_0126','mathworks.maab.db_0126';...
    'StyleGuide: db_0125','mathworks.jmaab.db_0125';...
    'mathworks.maab.db_0125','mathworks.jmaab.db_0125';...
    'StyleGuide: db_0122','mathworks.jmaab.db_0122';...
    'mathworks.maab.db_0122','mathworks.jmaab.db_0122';...
    'StyleGuide: db_0137','mathworks.maab.db_0137';...
    'StyleGuide: jc_0011','mathworks.maab.jc_0011';...
    'StyleGuide: jc_0021','mathworks.maab.jc_0021';...
    'StyleGuide: jc_0061','mathworks.maab.jc_0061';...
    'StyleGuide: jc_0081','mathworks.maab.jc_0081';...
    'StyleGuide: jc_0201','mathworks.jmaab.jc_0201';...
    'mathworks.maab.jc_0201','mathworks.jmaab.jc_0201';...
    'StyleGuide: jc_0211','mathworks.jmaab.jc_0211';...
    'mathworks.maab.jc_0211','mathworks.jmaab.jc_0211';...
    'StyleGuide: jc_0221','mathworks.maab.jc_0221';...
    'StyleGuide: jc_0231','mathworks.jmaab.jc_0231';...
    'mathworks.maab.jc_0231','mathworks.jmaab.jc_0231';...
    'StyleGuide: jc_0281','mathworks.maab.jc_0281';...
    'mathworks.maab.jc_0281','mathworks.jmaab.jc_0281';...
    'StyleGuide: jc_0501','mathworks.jmaab.jc_0501';...
    'StyleGuide: jc_0511','mathworks.maab.jc_0511';...
    'StyleGuide: na_0004','mathworks.maab.na_0004';...
    'StyleGuide: na_0005','mathworks.maab.na_0005';...
    'StyleGuide: jc_0111','mathworks.maab.jc_0111';...
    'StyleGuide: jc_0131','mathworks.maab.jc_0131';...
    'StyleGuide: jc_0541','mathworks.maab.jc_0541';...
    'StyleGuide: db_0123','mathworks.maab.db_0123';...
    'StyleGuide: na_0011','mathworks.maab.na_0011';...
    'mathworks.maab.jm_0012','mathworks.jmaab.jm_0012';...


    'mathworks.iec61508.SimulationTimeOptions','mathworks.hism.hisl_0040';...
    'mathworks.iec61508.hisl_0041','mathworks.hism.hisl_0041';...
    'mathworks.do178.hisl_0042','mathworks.hism.hisl_0042';...
    'mathworks.iec61508.hisl_0042','mathworks.hism.hisl_0042';...
    'mathworks.do178.hisf_0013','mathworks.hism.hisf_0013';...
    'mathworks.iec61508.hisf_0013','mathworks.hism.hisf_0013';...
    'mathworks.do178.hisf_0015','mathworks.hism.hisf_0015';...
    'mathworks.iec61508.hisf_0015','mathworks.hism.hisf_0015';...
    'mathworks.do178.hisf_0064','mathworks.hism.hisf_0064';...
    'mathworks.iec61508.hisf_0064','mathworks.hism.hisf_0064';...
    'mathworks.do178.hisf_0065','mathworks.hism.hisf_0065';...
    'mathworks.iec61508.hisf_0065','mathworks.hism.hisf_0065';...
    'mathworks.do178.hisf_0211','mathworks.hism.hisf_0211';...
    'mathworks.iec61508.hisf_0211','mathworks.hism.hisf_0211';...
    'mathworks.do178.himl_0002','mathworks.hism.himl_0002';...
    'mathworks.iec61508.himl_0002','mathworks.hism.himl_0002';...
    'mathworks.do178.himl_0003','mathworks.hism.himl_0003';...
    'mathworks.iec61508.himl_0003','mathworks.hism.himl_0003';...
    'mathworks.do178.himl_0004','mathworks.hism.himl_0004';...
    'mathworks.iec61508.himl_0004','mathworks.hism.himl_0004';...
    'mathworks.do178.himl_0005','mathworks.hism.himl_0005';...
    'mathworks.iec61508.himl_0005','mathworks.hism.himl_0005';...
    'mathworks.do178.CompatibilityDiagnosticsSet','mathworks.hism.hisl_0301';...
    'mathworks.do178.DataValidityParamDiagnosticsSet','mathworks.hism.hisl_0302';...
    'mathworks.do178.hisl_0303','mathworks.hism.hisl_0303';...
    'mathworks.iec61508.hisl_0303','mathworks.hism.hisl_0303';...
    'mathworks.do178.InitDiagnosticsSet','mathworks.hism.hisl_0304';...
    'mathworks.do178.DataValidityDebugDiagnosticsSet','mathworks.hism.hisl_0305';...
    'mathworks.do178.ConnectivitySignalsDiagnosticsSet','mathworks.hism.hisl_0306';...
    'mathworks.do178.ConnectivityBussesDiagnosticsSet','mathworks.hism.hisl_0307';...
    'mathworks.do178.FcnCallDiagnosticsSet','mathworks.hism.hisl_0308';...
    'mathworks.do178.TypeConversionDiagnosticsSet','mathworks.hism.hisl_0309';...
    'mathworks.iec61508.hisl_0309','mathworks.hism.hisl_0309';...
    'mathworks.do178.MdlrefDiagnosticsSet','mathworks.hism.hisl_0310';...
    'mathworks.do178.hisl_0311','mathworks.hism.hisl_0311';...
    'mathworks.iec61508.hisl_0311','mathworks.hism.hisl_0311';...
    'mathworks.do178.DataStoreMemoryDiagnosticsSet','mathworks.hism.hisl_0013';...
    'mathworks.do178.hisl_0021','mathworks.hism.hisl_0021';...
    'mathworks.iec61508.hisl_0021','mathworks.hism.hisl_0021';...
    'mathworks.do178.VariantBlock','mathworks.hism.hisl_0023';...
    'mathworks.do178.LUTRangeCheckCode','mathworks.hism.hisl_0033';...
    'mathworks.do178.SignalRoutingBlockUsage','mathworks.hism.hisl_0034';...
    'mathworks.iec61508.SignalRoutingBlockUsage','mathworks.hism.hisl_0034';...
    'mathworks.do178.SavingDiagnosticsSet','mathworks.hism.hisl_0036';...
    'mathworks.do178.MdlrefOptSet','mathworks.hism.hisl_0037';...
    'mathworks.do178.SolverDiagnosticsSet','mathworks.hism.hisl_0043';...
    'mathworks.do178.SampleTimeDiagnosticsSet','mathworks.hism.hisl_0044';...
    'mathworks.do178.hisl_0061','mathworks.hism.hisl_0061';...
    'mathworks.iec61508.RootLevelInports','mathworks.hism.hisl_0024';...
    'mathworks.iec61508.InportRange','mathworks.hism.hisl_0025';...
    'mathworks.iec61508.OutportRange','mathworks.hism.hisl_0026';...
    'mathworks.do178.hisf_0001','mathworks.hism.hisf_0001';...
    'mathworks.iec61508.hisf_0001','mathworks.hism.hisf_0001';...
    'mathworks.do178.hisf_0002','mathworks.hism.hisf_0002';...
    'mathworks.do178.hisf_0011','mathworks.hism.hisf_0011';...
    'mathworks.iec61508.hisl_0051','mathworks.hism.hisl_0051';...
    'mathworks.do178.hisl_0032','mathworks.hism.hisl_0032';...
    'mathworks.iec61508.hisl_0032','mathworks.hism.hisl_0032';...
    'mathworks.do178.RequirementInfo','mathworks.hism.hisl_0070';...
    'mathworks.iec61508.RequirementInfo','mathworks.hism.hisl_0070';...
    'mathworks.do178.PCGSupport','mathworks.hism.hisl_0020';...
    'mathworks.iec61508.PCGSupport','mathworks.hism.hisl_0020';...
    'mathworks.do178.DataValiditySignalsDiagnosticsSet','mathworks.hism.hisl_0314';...
    'mathworks.maab.db_0127','mathworks.jmaab.db_0127';...
    'mathworks.maab.na_0001','mathworks.jmaab.na_0001';...
    };
    newID='';
    if nargin==0
        return;
    elseif nargin==1
        for i=1:length(matchTable)
            if strcmp(matchTable{i,1},oldID)
                newID=matchTable{i,2};
                break
            end
        end
    elseif strcmpi(varargin{1},'TaskID')
        for i=1:length(matchTable)
            if~isempty(strfind(oldID,matchTable{i,1}))
                newID=strrep(oldID,matchTable{i,1},matchTable{i,2});
                break
            end
        end
    elseif strcmpi(varargin{1},'GetTable')
        newID=matchTable;
    end