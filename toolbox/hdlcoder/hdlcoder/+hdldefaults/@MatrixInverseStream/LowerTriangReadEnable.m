
function LowerTriangReadEnable(~,hN,LTRdEnableInSigs,LTRdEnableOutSigs,...
    slRate,blockInfo)


    hLTRdEnableN=pirelab.createNewNetwork(...
    'Name','LowerTriangReadEnable',...
    'InportNames',{'storeDone','rowDone','rowCount','nonDiagValidIn'},...
    'InportTypes',[LTRdEnableInSigs(1).Type,LTRdEnableInSigs(2).Type,...
    LTRdEnableInSigs(3).Type,LTRdEnableInSigs(4).Type],...
    'InportRates',slRate*ones(1,4),...
    'OutportNames',{'readEnable'},...
    'OutportTypes',LTRdEnableOutSigs(1).Type);

    hLTRdEnableN.setTargetCompReplacementCandidate(true);


    for ii=1:numel(hLTRdEnableN.PirOutputSignals)
        hLTRdEnableN.PirOutputSignals(ii).SimulinkRate=slRate;
    end

    hLTRdEnableNinSigs=hLTRdEnableN.PirInputSignals;
    hLTRdEnableNoutSigs=hLTRdEnableN.PirOutputSignals;


    storeDone=hLTRdEnableNinSigs(1);
    rowDone=hLTRdEnableNinSigs(2);
    rowCount=hLTRdEnableNinSigs(3);
    nonDiagValidIn=hLTRdEnableNinSigs(4);

    readEnable=hLTRdEnableNoutSigs(1);


    hBoolT=pir_boolean_t;



    CompareToConstant_out1_s4=l_addSignal(hLTRdEnableN,...
    sprintf('Compare\nTo Constant_out1'),hBoolT,slRate);
    Constant_out1_s5=l_addSignal(hLTRdEnableN,'Constant_out1',hBoolT,slRate);
    Constant1_out1_s6=l_addSignal(hLTRdEnableN,'Constant1_out1',hBoolT,slRate);
    Delay_out1_s7=l_addSignal(hLTRdEnableN,'Delay_out1',hBoolT,slRate);
    Delay1_out1_s8=l_addSignal(hLTRdEnableN,'Delay1_out1',hBoolT,slRate);
    LogicalOperator_out1_s9=l_addSignal(hLTRdEnableN,...
    sprintf('Logical\nOperator_out1'),hBoolT,slRate);
    Switch_out1_s10=l_addSignal(hLTRdEnableN,'Switch_out1',hBoolT,slRate);
    Switch1_out1_s11=l_addSignal(hLTRdEnableN,'Switch1_out1',hBoolT,slRate);
    Switch2_out1_s12=l_addSignal(hLTRdEnableN,'Switch2_out1',hBoolT,slRate);

    pirelab.getConstComp(hLTRdEnableN,...
    Constant_out1_s5,...
    1,...
    'Constant','on',0,'','','');

    pirelab.getConstComp(hLTRdEnableN,...
    Constant1_out1_s6,...
    0,...
    'Constant1','on',1,'','','');


    hC=pirelab.getIntDelayComp(hLTRdEnableN,...
    nonDiagValidIn,...
    Delay_out1_s7,...
    2,'Delay',...
    false,...
    0,0,[],0,0);

    pirelab.getIntDelayComp(hLTRdEnableN,...
    Delay_out1_s7,...
    Delay1_out1_s8,...
    2*(resolveLatencyForIPType(hC,'ADDSUB')+resolveLatencyForIPType(hC,'MUL')),'Delay1',...
    false,...
    0,0,[],0,0);

    pirelab.getIntDelayComp(hLTRdEnableN,...
    Switch_out1_s10,...
    readEnable,...
    1,'readEnableReg',...
    false,...
    0,0,[],0,0);

    pirelab.getCompareToValueComp(hLTRdEnableN,...
    rowCount,...
    CompareToConstant_out1_s4,...
    '<',blockInfo.RowSize,...
    sprintf('Compare\nTo Constant'),0);

    pirelab.getLogicComp(hLTRdEnableN,...
    [rowDone,CompareToConstant_out1_s4],...
    LogicalOperator_out1_s9,...
    'and',sprintf('Logical\nOperator'));

    pirelab.getSwitchComp(hLTRdEnableN,...
    [Constant_out1_s5,Switch1_out1_s11],...
    Switch_out1_s10,...
    storeDone,'Switch',...
    '~=',0,'Floor','Wrap');

    pirelab.getSwitchComp(hLTRdEnableN,...
    [Constant_out1_s5,Switch2_out1_s12],...
    Switch1_out1_s11,...
    LogicalOperator_out1_s9,'Switch1',...
    '~=',0,'Floor','Wrap');

    pirelab.getSwitchComp(hLTRdEnableN,...
    [Constant_out1_s5,Constant1_out1_s6],...
    Switch2_out1_s12,...
    Delay1_out1_s8,'Switch2',...
    '~=',0,'Floor','Wrap');


    pirelab.instantiateNetwork(hN,hLTRdEnableN,LTRdEnableInSigs,LTRdEnableOutSigs,...
    [hLTRdEnableN.Name,'_inst']);
end


function hS=l_addSignal(hN,sigName,pirTyp,simulinkRate)
    hS=hN.addSignal;
    hS.Name=sigName;
    hS.Type=pirTyp;
    hS.SimulinkHandle=-1;
    hS.SimulinkRate=simulinkRate;
end

function latency=resolveLatencyForIPType(hC,targetIPType)

    hDriver=hdlcurrentdriver;

    p=pir(hC.Owner.getCtxName);
    targetCompDataType='SINGLE';
    targetDriver=hDriver.getTargetCodeGenDriver(p);
    if isempty(targetDriver)||~strcmpi(class(targetDriver),'targetcodegen.nfpdriver')
        latency=-1;
        return;
    end

    latency=targetDriver.getDefaultLatency(targetIPType,targetCompDataType,[]);
end