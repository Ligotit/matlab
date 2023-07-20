
function gaussJordanColumnCounter(~,hN,LTColumnCounterInSigs,LTColumnCounterOutSigs,...
    hBoolT,hCounterT,slRate,blockInfo)





    hLTColumnCounterN=pirelab.createNewNetwork(...
    'Name','gaussJordanColumnCounter',...
    'InportNames',{'rowCount','readEnable','rowFinish','swapDone','invFinish','isDiagZero','swapReadEnable'},...
    'InportTypes',[hCounterT,hBoolT,hBoolT,hBoolT,hBoolT,hBoolT,hBoolT],...
    'InportRates',slRate*ones(1,7),...
    'OutportNames',{'colCount'},...
    'OutportTypes',hCounterT);

    hLTColumnCounterN.setTargetCompReplacementCandidate(true);

    for ii=1:numel(hLTColumnCounterN.PirOutputSignals)
        hLTColumnCounterN.PirOutputSignals(ii).SimulinkRate=slRate;
    end

    hLTColumnCounterNinSigs=hLTColumnCounterN.PirInputSignals;
    hLTColumnCounterNoutSigs=hLTColumnCounterN.PirOutputSignals;

    rowCount=hLTColumnCounterNinSigs(1);
    readEnable=hLTColumnCounterNinSigs(2);
    rowFinish=hLTColumnCounterNinSigs(3);
    swapDone=hLTColumnCounterNinSigs(4);
    invFinish=hLTColumnCounterNinSigs(5);
    isDiagZero=hLTColumnCounterNinSigs(6);
    swapReadEnable=hLTColumnCounterNinSigs(7);

    colCount=hLTColumnCounterNoutSigs(1);


    pirTyp2=pir_boolean_t;
    pirTyp4=pir_sfixpt_t(ceil(log2(blockInfo.MatrixSize))+2,0);
    pirTyp1=pir_ufixpt_t(ceil(log2(blockInfo.MatrixSize))+1,0);
    pirTyp3=pir_ufixpt_t(ceil(log2(blockInfo.MatrixSize))+2,0);


    Add_out1_s7=l_addSignal(hLTColumnCounterN,'Add_out1',pirTyp1,slRate);
    Add1_out1_s8=l_addSignal(hLTColumnCounterN,'Add1_out1',pirTyp1,slRate);
    Add2_out1_s9=l_addSignal(hLTColumnCounterN,'Add2_out1',pirTyp1,slRate);
    Add3_out1_s10=l_addSignal(hLTColumnCounterN,'Add3_out1',pirTyp1,slRate);
    CompareToConstant_out1_s11=l_addSignal(hLTColumnCounterN,sprintf('Compare\nTo Constant_out1'),pirTyp2,slRate);
    CompareToConstant1_out1_s12=l_addSignal(hLTColumnCounterN,sprintf('Compare\nTo Constant1_out1'),pirTyp2,slRate);
    CompareToConstant2_out1_s13=l_addSignal(hLTColumnCounterN,sprintf('Compare\nTo Constant2_out1'),pirTyp2,slRate);
    CompareToConstant3_out1_s14=l_addSignal(hLTColumnCounterN,sprintf('Compare\nTo Constant3_out1'),pirTyp2,slRate);
    CompareToConstant4_out1_s15=l_addSignal(hLTColumnCounterN,sprintf('Compare\nTo Constant4_out1'),pirTyp2,slRate);
    Constant_out1_s16=l_addSignal(hLTColumnCounterN,'Constant_out1',pirTyp1,slRate);
    Constant1_out1_s17=l_addSignal(hLTColumnCounterN,'Constant1_out1',pirTyp1,slRate);
    Constant2_out1_s18=l_addSignal(hLTColumnCounterN,'Constant2_out1',pirTyp1,slRate);
    Constant3_out1_s19=l_addSignal(hLTColumnCounterN,'Constant3_out1',pirTyp1,slRate);
    Constant4_out1_s20=l_addSignal(hLTColumnCounterN,'Constant4_out1',pirTyp1,slRate);
    LogicalOperator_out1_s22=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator_out1'),pirTyp2,slRate);
    LogicalOperator1_out1_s23=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator1_out1'),pirTyp2,slRate);
    LogicalOperator11_out1_s24=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator11_out1'),pirTyp2,slRate);
    LogicalOperator12_out1_s25=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator12_out1'),pirTyp2,slRate);
    LogicalOperator2_out1_s26=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator2_out1'),pirTyp2,slRate);
    LogicalOperator3_out1_s27=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator3_out1'),pirTyp2,slRate);
    LogicalOperator4_out1_s28=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator4_out1'),pirTyp2,slRate);
    LogicalOperator5_out1_s29=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator5_out1'),pirTyp2,slRate);
    LogicalOperator6_out1_s30=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator6_out1'),pirTyp2,slRate);
    LogicalOperator8_out1_s31=l_addSignal(hLTColumnCounterN,sprintf('Logical\nOperator8_out1'),pirTyp2,slRate);
    RelationalOperator_out1_s32=l_addSignal(hLTColumnCounterN,sprintf('Relational\nOperator_out1'),pirTyp2,slRate);
    RelationalOperator1_out1_s33=l_addSignal(hLTColumnCounterN,sprintf('Relational\nOperator1_out1'),pirTyp2,slRate);
    Switch_out1_s34=l_addSignal(hLTColumnCounterN,'Switch_out1',pirTyp1,slRate);
    Switch1_out1_s35=l_addSignal(hLTColumnCounterN,'Switch1_out1',pirTyp1,slRate);
    Switch2_out1_s36=l_addSignal(hLTColumnCounterN,'Switch2_out1',pirTyp1,slRate);
    Switch3_out1_s37=l_addSignal(hLTColumnCounterN,'Switch3_out1',pirTyp1,slRate);
    Switch4_out1_s38=l_addSignal(hLTColumnCounterN,'Switch4_out1',pirTyp1,slRate);
    Delay_out_s39=l_addSignal(hLTColumnCounterN,'Delay_out',pirTyp1,slRate);
    Delay_Initial_Val_out_s40=l_addSignal(hLTColumnCounterN,'Delay_Initial_Val_out',pirTyp1,slRate);
    Delay_ctrl_const_out_s41=l_addSignal(hLTColumnCounterN,'Delay_ctrl_const_out',pirTyp2,slRate);
    Delay_ctrl_delay_out_s42=l_addSignal(hLTColumnCounterN,'Delay_ctrl_delay_out',pirTyp2,slRate);

    pirelab.getConstComp(hLTColumnCounterN,...
    Constant_out1_s16,...
    1,...
    'Constant','on',0,'','','');


    pirelab.getConstComp(hLTColumnCounterN,...
    Constant1_out1_s17,...
    1,...
    'Constant1','on',0,'','','');


    pirelab.getConstComp(hLTColumnCounterN,...
    Constant2_out1_s18,...
    1,...
    'Constant2','on',0,'','','');


    pirelab.getConstComp(hLTColumnCounterN,...
    Constant3_out1_s19,...
    2,...
    'Constant3','on',0,'','','');


    pirelab.getConstComp(hLTColumnCounterN,...
    Constant4_out1_s20,...
    1,...
    'Constant4','on',0,'','','');


    pirelab.getIntDelayComp(hLTColumnCounterN,...
    Switch4_out1_s38,...
    Delay_out_s39,...
    1,'Delay',...
    double(0),...
    0,0,[],0,0);


    pirelab.getConstComp(hLTColumnCounterN,...
    Delay_Initial_Val_out_s40,...
    1,...
    'Delay_Initial_Val','on',0,'','','');

    pirelab.getConstComp(hLTColumnCounterN,...
    Delay_ctrl_const_out_s41,...
    1,...
    'Delay_ctrl_const');

    pirelab.getIntDelayComp(hLTColumnCounterN,...
    Delay_ctrl_const_out_s41,...
    Delay_ctrl_delay_out_s42,...
    1,'Delay_ctrl_delay',...
    double(0),...
    0,0,[],0,0);

    pirelab.getSwitchComp(hLTColumnCounterN,...
    [Delay_out_s39,Delay_Initial_Val_out_s40],...
    colCount,...
    Delay_ctrl_delay_out_s42,'Delay_switch',...
    '~=',0,'Floor','Wrap');


    pirelab.getAddComp(hLTColumnCounterN,...
    [rowCount,Constant1_out1_s17],...
    Add_out1_s7,...
    'Floor','Wrap','Add',pirTyp3,'++');



    pirelab.getAddComp(hLTColumnCounterN,...
    [rowCount,Constant2_out1_s18],...
    Add1_out1_s8,...
    'Floor','Wrap','Add1',pirTyp4,'+-');



    pirelab.getAddComp(hLTColumnCounterN,...
    [colCount,Constant3_out1_s19],...
    Add2_out1_s9,...
    'Floor','Wrap','Add2',pirTyp3,'++');



    pirelab.getAddComp(hLTColumnCounterN,...
    [colCount,Constant4_out1_s20],...
    Add3_out1_s10,...
    'Floor','Wrap','Add3',pirTyp3,'++');



    pirelab.getCompareToValueComp(hLTColumnCounterN,...
    colCount,...
    CompareToConstant_out1_s11,...
    '==',blockInfo.MatrixSize-1,...
    sprintf('Compare\nTo Constant'),0);



    pirelab.getCompareToValueComp(hLTColumnCounterN,...
    rowCount,...
    CompareToConstant1_out1_s12,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant1'),0);



    pirelab.getCompareToValueComp(hLTColumnCounterN,...
    rowCount,...
    CompareToConstant2_out1_s13,...
    '~=',1,...
    sprintf('Compare\nTo Constant2'),0);


    pirelab.getCompareToValueComp(hLTColumnCounterN,...
    colCount,...
    CompareToConstant3_out1_s14,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant3'),0);



    pirelab.getCompareToValueComp(hLTColumnCounterN,...
    colCount,...
    CompareToConstant4_out1_s15,...
    '<',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant4'),0);



    pirelab.getLogicComp(hLTColumnCounterN,...
    [CompareToConstant_out1_s11,CompareToConstant1_out1_s12,readEnable],...
    LogicalOperator_out1_s22,...
    'and',sprintf('Logical\nOperator'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [RelationalOperator_out1_s32,CompareToConstant2_out1_s13,readEnable],...
    LogicalOperator1_out1_s23,...
    'and',sprintf('Logical\nOperator1'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [LogicalOperator6_out1_s30,swapReadEnable],...
    LogicalOperator11_out1_s24,...
    'or',sprintf('Logical\nOperator11'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [isDiagZero,LogicalOperator4_out1_s28],...
    LogicalOperator12_out1_s25,...
    'or',sprintf('Logical\nOperator12'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [LogicalOperator_out1_s22,LogicalOperator1_out1_s23],...
    LogicalOperator2_out1_s26,...
    'or',sprintf('Logical\nOperator2'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [LogicalOperator2_out1_s26,readEnable],...
    LogicalOperator3_out1_s27,...
    'and',sprintf('Logical\nOperator3'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [rowFinish,CompareToConstant3_out1_s14],...
    LogicalOperator4_out1_s28,...
    'and',sprintf('Logical\nOperator4'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [readEnable,RelationalOperator1_out1_s33],...
    LogicalOperator5_out1_s29,...
    'and',sprintf('Logical\nOperator5'));



    pirelab.getLogicComp(hLTColumnCounterN,...
    [CompareToConstant4_out1_s15,readEnable],...
    LogicalOperator6_out1_s30,...
    'and',sprintf('Logical\nOperator6'));




    pirelab.getLogicComp(hLTColumnCounterN,...
    [invFinish,LogicalOperator3_out1_s27],...
    LogicalOperator8_out1_s31,...
    'or',sprintf('Logical\nOperator8'));



    pirelab.getRelOpComp(hLTColumnCounterN,...
    [colCount,rowCount],...
    RelationalOperator_out1_s32,...
    '==',0,sprintf('Relational\nOperator'));


    pirelab.getRelOpComp(hLTColumnCounterN,...
    [colCount,Add1_out1_s8],...
    RelationalOperator1_out1_s33,...
    '==',0,sprintf('Relational\nOperator1'));



    pirelab.getSwitchComp(hLTColumnCounterN,...
    [Constant_out1_s16,Switch1_out1_s35],...
    Switch_out1_s34,...
    LogicalOperator8_out1_s31,'Switch',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTColumnCounterN,...
    [Add_out1_s7,Switch2_out1_s36],...
    Switch1_out1_s35,...
    LogicalOperator12_out1_s25,'Switch1',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTColumnCounterN,...
    [Add2_out1_s9,Switch3_out1_s37],...
    Switch2_out1_s36,...
    LogicalOperator5_out1_s29,'Switch2',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTColumnCounterN,...
    [Add3_out1_s10,colCount],...
    Switch3_out1_s37,...
    LogicalOperator11_out1_s24,'Switch3',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTColumnCounterN,...
    [rowCount,Switch_out1_s34],...
    Switch4_out1_s38,...
    swapDone,'Switch4',...
    '~=',0,'Floor','Wrap');



    pirelab.instantiateNetwork(hN,hLTColumnCounterN,LTColumnCounterInSigs,LTColumnCounterOutSigs,...
    [hLTColumnCounterN.Name,'_inst']);

end


function hS=l_addSignal(hN,sigName,pirTyp,simulinkRate)
    hS=hN.addSignal;
    hS.Name=sigName;
    hS.Type=pirTyp;
    hS.SimulinkHandle=-1;
    hS.SimulinkRate=simulinkRate;
end