function nVarVecPiBy2BPSK=elabPiBy2BPSKnVarVecNet(~,topNet,~,rate,inpWL,inpFL)





    pirTyp2=pir_boolean_t;
    pirTyp3=pir_ufixpt_t(1,0);
    pirTyp1=pir_ufixpt_t(inpWL,inpFL);
    pirTyp4=pir_ufixpt_t(3,0);

    fiMath1=fimath('RoundingMethod','Nearest','OverflowAction','Saturate','ProductMode','FullPrecision','SumMode','FullPrecision');

    nt1=numerictype(0,1,0);
    nt3=numerictype(0,inpWL,-inpFL);
    nt2=numerictype(0,3,0);


    inportNameNvarPiBy2BPSK={'nVarIn','nVarvalidIn','nVarresetIn','nVarendIn'};
    controlType=pir_ufixpt_t(1,0);
    inType=pir_ufixpt_t(inpWL,inpFL);
    inTypeNvarPiBy2BPSK=[inType,controlType,controlType,controlType];
    inDataRateNvarPiBy2BPSK=[rate,rate,rate,rate];

    outportNameNvarPiBy2BPSK={'dataOut'};
    outTypeNvarPiBy2BPSK=[pirelab.createPirArrayType(inType,[8,0])];

    nVarVecPiBy2BPSK=pirelab.createNewNetwork(...
    'Network',topNet,...
    'Name','symDemodNvarPiBy2BPSK',...
    'InportNames',inportNameNvarPiBy2BPSK,...
    'InportTypes',inTypeNvarPiBy2BPSK,...
    'InportRates',inDataRateNvarPiBy2BPSK,...
    'OutportNames',outportNameNvarPiBy2BPSK,...
    'OutportTypes',outTypeNvarPiBy2BPSK...
    );



    nVarIn_s0=nVarVecPiBy2BPSK.PirInputSignals(1);
    validIn_s1=nVarVecPiBy2BPSK.PirInputSignals(2);
    rstIn_s2=nVarVecPiBy2BPSK.PirInputSignals(3);
    endIn_s3=nVarVecPiBy2BPSK.PirInputSignals(4);

    nvarVecOut=nVarVecPiBy2BPSK.PirOutputSignals(1);

    slRate1=rate;

    Switch1_out1_s70=addSignal(nVarVecPiBy2BPSK,'Switch1_out1',pirelab.createPirArrayType(pirTyp1,[8,0]),slRate1);

    AND_out1_s4=addSignal(nVarVecPiBy2BPSK,'AND_out1',pirTyp2,slRate1);
    AND1_out1_s5=addSignal(nVarVecPiBy2BPSK,'AND1_out1',pirTyp2,slRate1);
    AND11_out1_s6=addSignal(nVarVecPiBy2BPSK,'AND11_out1',pirTyp2,slRate1);
    AND12_out1_s7=addSignal(nVarVecPiBy2BPSK,'AND12_out1',pirTyp2,slRate1);
    AND2_out1_s8=addSignal(nVarVecPiBy2BPSK,'AND2_out1',pirTyp2,slRate1);
    AND3_out1_s9=addSignal(nVarVecPiBy2BPSK,'AND3_out1',pirTyp2,slRate1);
    AND4_out1_s10=addSignal(nVarVecPiBy2BPSK,'AND4_out1',pirTyp2,slRate1);
    AND5_out1_s11=addSignal(nVarVecPiBy2BPSK,'AND5_out1',pirTyp2,slRate1);
    AND6_out1_s12=addSignal(nVarVecPiBy2BPSK,'AND6_out1',pirTyp2,slRate1);
    AND7_out1_s13=addSignal(nVarVecPiBy2BPSK,'AND7_out1',pirTyp2,slRate1);
    AND8_out1_s14=addSignal(nVarVecPiBy2BPSK,'AND8_out1',pirTyp2,slRate1);
    AND9_out1_s15=addSignal(nVarVecPiBy2BPSK,'AND9_out1',pirTyp2,slRate1);
    CompareToConstant_out1_s16=addSignal(nVarVecPiBy2BPSK,'Compare To Constant_out1',pirTyp2,slRate1);
    CompareToConstant1_out1_s17=addSignal(nVarVecPiBy2BPSK,'Compare To Constant1_out1',pirTyp2,slRate1);
    CompareToConstant10_out1_s18=addSignal(nVarVecPiBy2BPSK,'Compare To Constant10_out1',pirTyp2,slRate1);
    CompareToConstant2_out1_s19=addSignal(nVarVecPiBy2BPSK,'Compare To Constant2_out1',pirTyp2,slRate1);
    CompareToConstant3_out1_s20=addSignal(nVarVecPiBy2BPSK,'Compare To Constant3_out1',pirTyp2,slRate1);
    CompareToConstant4_out1_s21=addSignal(nVarVecPiBy2BPSK,'Compare To Constant4_out1',pirTyp2,slRate1);
    CompareToConstant5_out1_s22=addSignal(nVarVecPiBy2BPSK,'Compare To Constant5_out1',pirTyp2,slRate1);
    CompareToConstant6_out1_s23=addSignal(nVarVecPiBy2BPSK,'Compare To Constant6_out1',pirTyp2,slRate1);
    CompareToConstant7_out1_s24=addSignal(nVarVecPiBy2BPSK,'Compare To Constant7_out1',pirTyp2,slRate1);
    CompareToConstant8_out1_s25=addSignal(nVarVecPiBy2BPSK,'Compare To Constant8_out1',pirTyp2,slRate1);
    CompareToConstant9_out1_s26=addSignal(nVarVecPiBy2BPSK,'Compare To Constant9_out1',pirTyp2,slRate1);
    Constant_out1_s27=addSignal(nVarVecPiBy2BPSK,'Constant_out1',pirTyp3,slRate1);
    Delay_out1_s28=addSignal(nVarVecPiBy2BPSK,'Delay_out1',pirTyp4,slRate1);
    Delay12_out1_s29=addSignal(nVarVecPiBy2BPSK,'Delay12_out1',pirTyp2,slRate1);
    Delay1_bypass_out1_s30=addSignal(nVarVecPiBy2BPSK,'Delay1_bypass_out1',pirTyp1,slRate1);
    Delay1_lowered_out1_s31=addSignal(nVarVecPiBy2BPSK,'Delay1_lowered_out1',pirTyp1,slRate1);
    Delay2_bypass_out1_s32=addSignal(nVarVecPiBy2BPSK,'Delay2_bypass_out1',pirTyp1,slRate1);
    Delay2_lowered_out1_s33=addSignal(nVarVecPiBy2BPSK,'Delay2_lowered_out1',pirTyp1,slRate1);
    Delay3_bypass_out1_s34=addSignal(nVarVecPiBy2BPSK,'Delay3_bypass_out1',pirTyp1,slRate1);
    Delay3_lowered_out1_s35=addSignal(nVarVecPiBy2BPSK,'Delay3_lowered_out1',pirTyp1,slRate1);
    Delay4_bypass_out1_s36=addSignal(nVarVecPiBy2BPSK,'Delay4_bypass_out1',pirTyp1,slRate1);
    Delay4_lowered_out1_s37=addSignal(nVarVecPiBy2BPSK,'Delay4_lowered_out1',pirTyp1,slRate1);
    Delay5_bypass_out1_s38=addSignal(nVarVecPiBy2BPSK,'Delay5_bypass_out1',pirTyp1,slRate1);
    Delay5_lowered_out1_s39=addSignal(nVarVecPiBy2BPSK,'Delay5_lowered_out1',pirTyp1,slRate1);
    Delay6_bypass_out1_s40=addSignal(nVarVecPiBy2BPSK,'Delay6_bypass_out1',pirTyp1,slRate1);
    Delay6_lowered_out1_s41=addSignal(nVarVecPiBy2BPSK,'Delay6_lowered_out1',pirTyp1,slRate1);
    Delay7_bypass_out1_s42=addSignal(nVarVecPiBy2BPSK,'Delay7_bypass_out1',pirTyp1,slRate1);
    Delay7_lowered_out1_s43=addSignal(nVarVecPiBy2BPSK,'Delay7_lowered_out1',pirTyp1,slRate1);
    Delay8_bypass_out1_s44=addSignal(nVarVecPiBy2BPSK,'Delay8_bypass_out1',pirTyp1,slRate1);
    Delay8_lowered_out1_s45=addSignal(nVarVecPiBy2BPSK,'Delay8_lowered_out1',pirTyp1,slRate1);
    Delay9_out1_s46=addSignal(nVarVecPiBy2BPSK,'Delay9_out1',pirTyp2,slRate1);
    Delay_Switch_out1_s47=addSignal(nVarVecPiBy2BPSK,'Delay_Switch_out1',pirTyp1,slRate1);
    Delay_Switch1_out1_s48=addSignal(nVarVecPiBy2BPSK,'Delay_Switch1_out1',pirTyp1,slRate1);
    Delay_Switch2_out1_s49=addSignal(nVarVecPiBy2BPSK,'Delay_Switch2_out1',pirTyp1,slRate1);
    Delay_Switch3_out1_s50=addSignal(nVarVecPiBy2BPSK,'Delay_Switch3_out1',pirTyp1,slRate1);
    Delay_Switch4_out1_s51=addSignal(nVarVecPiBy2BPSK,'Delay_Switch4_out1',pirTyp1,slRate1);
    Delay_Switch5_out1_s52=addSignal(nVarVecPiBy2BPSK,'Delay_Switch5_out1',pirTyp1,slRate1);
    Delay_Switch6_out1_s53=addSignal(nVarVecPiBy2BPSK,'Delay_Switch6_out1',pirTyp1,slRate1);
    Delay_Switch7_out1_s54=addSignal(nVarVecPiBy2BPSK,'Delay_Switch7_out1',pirTyp1,slRate1);
    HDLCounter_out1_s55=addSignal(nVarVecPiBy2BPSK,'HDL Counter_out1',pirTyp4,slRate1);
    HDLCounter_out1_out1_s56=addSignal(nVarVecPiBy2BPSK,'HDL Counter_out1_out1',pirTyp4,slRate1);
    LogicalOperator_out1_s57=addSignal(nVarVecPiBy2BPSK,'Logical Operator_out1',pirTyp2,slRate1);
    LogicalOperator1_out1_s58=addSignal(nVarVecPiBy2BPSK,'Logical Operator1_out1',pirTyp2,slRate1);
    LogicalOperator4_out1_s59=addSignal(nVarVecPiBy2BPSK,'Logical Operator4_out1',pirTyp2,slRate1);
    OR_out1_s60=addSignal(nVarVecPiBy2BPSK,'OR_out1',pirTyp2,slRate1);
    OR1_out1_s61=addSignal(nVarVecPiBy2BPSK,'OR1_out1',pirTyp2,slRate1);
    OR2_out1_s62=addSignal(nVarVecPiBy2BPSK,'OR2_out1',pirTyp2,slRate1);
    OR3_out1_s63=addSignal(nVarVecPiBy2BPSK,'OR3_out1',pirTyp2,slRate1);
    OR4_out1_s64=addSignal(nVarVecPiBy2BPSK,'OR4_out1',pirTyp2,slRate1);
    OR5_out1_s65=addSignal(nVarVecPiBy2BPSK,'OR5_out1',pirTyp2,slRate1);
    OR6_out1_s66=addSignal(nVarVecPiBy2BPSK,'OR6_out1',pirTyp2,slRate1);
    OR7_out1_s67=addSignal(nVarVecPiBy2BPSK,'OR7_out1',pirTyp2,slRate1);
    PipelineRegister_out1_s68=addSignal(nVarVecPiBy2BPSK,'PipelineRegister_out1',pirTyp1,slRate1);
    Product_out1_s69=addSignal(nVarVecPiBy2BPSK,'Product_out1',pirTyp1,slRate1);
    adder_out1_s71=addSignal(nVarVecPiBy2BPSK,'adder_out1',pirTyp4,slRate1);
    bypass_out_out1_s72=addSignal(nVarVecPiBy2BPSK,'bypass_out_out1',pirTyp1,slRate1);
    bypass_out1_out1_s73=addSignal(nVarVecPiBy2BPSK,'bypass_out1_out1',pirTyp1,slRate1);
    bypass_out2_out1_s74=addSignal(nVarVecPiBy2BPSK,'bypass_out2_out1',pirTyp1,slRate1);
    bypass_out3_out1_s75=addSignal(nVarVecPiBy2BPSK,'bypass_out3_out1',pirTyp1,slRate1);
    bypass_out4_out1_s76=addSignal(nVarVecPiBy2BPSK,'bypass_out4_out1',pirTyp1,slRate1);
    bypass_out5_out1_s77=addSignal(nVarVecPiBy2BPSK,'bypass_out5_out1',pirTyp1,slRate1);
    bypass_out6_out1_s78=addSignal(nVarVecPiBy2BPSK,'bypass_out6_out1',pirTyp1,slRate1);
    bypass_out7_out1_s79=addSignal(nVarVecPiBy2BPSK,'bypass_out7_out1',pirTyp1,slRate1);
    compare_out1_s80=addSignal(nVarVecPiBy2BPSK,'compare_out1',pirTyp2,slRate1);
    const_out1_s81=addSignal(nVarVecPiBy2BPSK,'const_out1',pirTyp4,slRate1);
    countFrom_out1_s82=addSignal(nVarVecPiBy2BPSK,'countFrom_out1',pirTyp4,slRate1);
    delayMatch_out1_s83=addSignal(nVarVecPiBy2BPSK,'delayMatch_out1',pirTyp2,slRate1);
    delayMatch1_out1_s84=addSignal(nVarVecPiBy2BPSK,'delayMatch1_out1',pirTyp2,slRate1);
    delayMatch10_out1_s85=addSignal(nVarVecPiBy2BPSK,'delayMatch10_out1',pirTyp2,slRate1);
    delayMatch11_out1_s86=addSignal(nVarVecPiBy2BPSK,'delayMatch11_out1',pirTyp2,slRate1);
    delayMatch12_out1_s87=addSignal(nVarVecPiBy2BPSK,'delayMatch12_out1',pirTyp2,slRate1);
    delayMatch13_out1_s88=addSignal(nVarVecPiBy2BPSK,'delayMatch13_out1',pirTyp2,slRate1);
    delayMatch14_out1_s89=addSignal(nVarVecPiBy2BPSK,'delayMatch14_out1',pirTyp2,slRate1);
    delayMatch15_out1_s90=addSignal(nVarVecPiBy2BPSK,'delayMatch15_out1',pirTyp2,slRate1);
    delayMatch16_out1_s91=addSignal(nVarVecPiBy2BPSK,'delayMatch16_out1',pirTyp2,slRate1);
    delayMatch17_out1_s92=addSignal(nVarVecPiBy2BPSK,'delayMatch17_out1',pirelab.createPirArrayType(pirTyp1,[8,0]),slRate1);
    delayMatch2_out1_s93=addSignal(nVarVecPiBy2BPSK,'delayMatch2_out1',pirTyp2,slRate1);
    delayMatch3_out1_s94=addSignal(nVarVecPiBy2BPSK,'delayMatch3_out1',pirTyp2,slRate1);
    delayMatch4_out1_s95=addSignal(nVarVecPiBy2BPSK,'delayMatch4_out1',pirTyp2,slRate1);
    delayMatch5_out1_s96=addSignal(nVarVecPiBy2BPSK,'delayMatch5_out1',pirTyp2,slRate1);
    delayMatch6_out1_s97=addSignal(nVarVecPiBy2BPSK,'delayMatch6_out1',pirTyp2,slRate1);
    delayMatch7_out1_s98=addSignal(nVarVecPiBy2BPSK,'delayMatch7_out1',pirTyp2,slRate1);
    delayMatch8_out1_s99=addSignal(nVarVecPiBy2BPSK,'delayMatch8_out1',pirTyp2,slRate1);
    delayMatch9_out1_s100=addSignal(nVarVecPiBy2BPSK,'delayMatch9_out1',pirTyp2,slRate1);
    mux_out1_s101=addSignal(nVarVecPiBy2BPSK,'mux_out1',pirelab.createPirArrayType(pirTyp1,[8,0]),slRate1);
    mux1_out1_s102=addSignal(nVarVecPiBy2BPSK,'mux1_out1',pirelab.createPirArrayType(pirTyp1,[8,0]),slRate1);
    step_value_out1_s103=addSignal(nVarVecPiBy2BPSK,'step_value_out1',pirTyp4,slRate1);
    switch_out1_s104=addSignal(nVarVecPiBy2BPSK,'switch_out1',pirTyp4,slRate1);
    switchEnable_out1_s105=addSignal(nVarVecPiBy2BPSK,'switchEnable_out1',pirTyp4,slRate1);
    switchReset_out1_s106=addSignal(nVarVecPiBy2BPSK,'switchReset_out1',pirTyp4,slRate1);
    t_out1_s107=addSignal(nVarVecPiBy2BPSK,'t_out1',pirelab.createPirArrayType(pirTyp1,[8,0]),slRate1);
    t_out1_s110=addSignal(nVarVecPiBy2BPSK,'t_out1',pirTyp1,slRate1);


    pirelab.getConstComp(nVarVecPiBy2BPSK,...
    Constant_out1_s27,...
    fi(0,nt1,fiMath1,'hex','1'),...
    'Constant','on',0,'','','');

    pirelab.getAnnotationComp(nVarVecPiBy2BPSK,...
    'Data Type Duplicate');


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    Delay_out1_s28,...
    1,'Delay',...
    fi(0,nt2,fiMath1,'hex','0'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    LogicalOperator_out1_s57,...
    Delay12_out1_s29,...
    1,'Delay12',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out_out1_s72,...
    Delay1_bypass_out1_s30,...
    1,'Delay1_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch_out1_s47,...
    Delay1_lowered_out1_s31,...
    1,'Delay1_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out1_out1_s73,...
    Delay2_bypass_out1_s32,...
    1,'Delay2_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch1_out1_s48,...
    Delay2_lowered_out1_s33,...
    1,'Delay2_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out2_out1_s74,...
    Delay3_bypass_out1_s34,...
    1,'Delay3_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch2_out1_s49,...
    Delay3_lowered_out1_s35,...
    1,'Delay3_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out3_out1_s75,...
    Delay4_bypass_out1_s36,...
    1,'Delay4_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch3_out1_s50,...
    Delay4_lowered_out1_s37,...
    1,'Delay4_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out4_out1_s76,...
    Delay5_bypass_out1_s38,...
    1,'Delay5_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch4_out1_s51,...
    Delay5_lowered_out1_s39,...
    1,'Delay5_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out5_out1_s77,...
    Delay6_bypass_out1_s40,...
    1,'Delay6_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch5_out1_s52,...
    Delay6_lowered_out1_s41,...
    1,'Delay6_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out6_out1_s78,...
    Delay7_bypass_out1_s42,...
    1,'Delay7_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch6_out1_s53,...
    Delay7_lowered_out1_s43,...
    1,'Delay7_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    bypass_out7_out1_s79,...
    Delay8_bypass_out1_s44,...
    1,'Delay8_bypass',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Delay_Switch7_out1_s54,...
    Delay8_lowered_out1_s45,...
    1,'Delay8_lowered',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    validIn_s1,...
    Delay9_out1_s46,...
    1,'Delay9',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    switchReset_out1_s106,...
    HDLCounter_out1_s55,...
    1,'HDL Counter',...
    fi(0,nt2,fiMath1,'hex','0'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    Product_out1_s69,...
    PipelineRegister_out1_s68,...
    1,'PipelineRegister',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getConstComp(nVarVecPiBy2BPSK,...
    const_out1_s81,...
    fi(0,nt2,fiMath1,'hex','0'),...
    'const','off',1,'','','');


    pirelab.getConstComp(nVarVecPiBy2BPSK,...
    countFrom_out1_s82,...
    fi(0,nt2,fiMath1,'hex','0'),...
    'countFrom','off',1,'','','');


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR_out1_s60,...
    delayMatch_out1_s83,...
    1,'delayMatch',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR_out1_s60,...
    delayMatch1_out1_s84,...
    1,'delayMatch1',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR5_out1_s65,...
    delayMatch10_out1_s85,...
    1,'delayMatch10',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR5_out1_s65,...
    delayMatch11_out1_s86,...
    1,'delayMatch11',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR6_out1_s66,...
    delayMatch12_out1_s87,...
    1,'delayMatch12',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR6_out1_s66,...
    delayMatch13_out1_s88,...
    1,'delayMatch13',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR7_out1_s67,...
    delayMatch14_out1_s89,...
    1,'delayMatch14',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR7_out1_s67,...
    delayMatch15_out1_s90,...
    1,'delayMatch15',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    AND8_out1_s14,...
    delayMatch16_out1_s91,...
    1,'delayMatch16',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    mux1_out1_s102,...
    delayMatch17_out1_s92,...
    1,'delayMatch17',...
    fi(0,nt3,fiMath1,'hex','000'),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR1_out1_s61,...
    delayMatch2_out1_s93,...
    1,'delayMatch2',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR1_out1_s61,...
    delayMatch3_out1_s94,...
    1,'delayMatch3',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR2_out1_s62,...
    delayMatch4_out1_s95,...
    1,'delayMatch4',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR2_out1_s62,...
    delayMatch5_out1_s96,...
    1,'delayMatch5',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR3_out1_s63,...
    delayMatch6_out1_s97,...
    1,'delayMatch6',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR3_out1_s63,...
    delayMatch7_out1_s98,...
    1,'delayMatch7',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR4_out1_s64,...
    delayMatch8_out1_s99,...
    1,'delayMatch8',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(nVarVecPiBy2BPSK,...
    OR4_out1_s64,...
    delayMatch9_out1_s100,...
    1,'delayMatch9',...
    false,...
    0,0,[],0,0);


    pirelab.getConstComp(nVarVecPiBy2BPSK,...
    step_value_out1_s103,...
    fi(0,nt2,fiMath1,'hex','1'),...
    'step_value','off',0,'','','');

    pirelab.getWireComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_s55,...
    HDLCounter_out1_out1_s56,...
    'HDL Counter_out1_out1');

    pirelab.getMuxComp(nVarVecPiBy2BPSK,...
    [t_out1_s110,t_out1_s110,t_out1_s110,t_out1_s110,t_out1_s110,t_out1_s110,...
    t_out1_s110,t_out1_s110],...
    t_out1_s107,...
    '');

    pirelab.getConstComp(nVarVecPiBy2BPSK,...
    t_out1_s110,...
    double(0),...
    '','on',1,'','','');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [validIn_s1,CompareToConstant6_out1_s23],...
    AND_out1_s4,...
    'and','AND');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant5_out1_s22,validIn_s1],...
    AND1_out1_s5,...
    'and','AND1');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [endIn_s3,AND12_out1_s7],...
    AND11_out1_s6,...
    'and','AND11');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [validIn_s1,CompareToConstant10_out1_s18],...
    AND12_out1_s7,...
    'and','AND12');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant_out1_s16,validIn_s1],...
    AND2_out1_s8,...
    'and','AND2');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant1_out1_s17,validIn_s1],...
    AND3_out1_s9,...
    'and','AND3');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant2_out1_s19,validIn_s1],...
    AND4_out1_s10,...
    'and','AND4');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant3_out1_s20,validIn_s1],...
    AND5_out1_s11,...
    'and','AND5');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant4_out1_s21,validIn_s1],...
    AND6_out1_s12,...
    'and','AND6');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant7_out1_s24,validIn_s1],...
    AND7_out1_s13,...
    'and','AND7');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [CompareToConstant8_out1_s25,AND9_out1_s15],...
    AND8_out1_s14,...
    'and','AND8');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [Delay9_out1_s46,Delay12_out1_s29],...
    AND9_out1_s15,...
    'and','AND9');


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant_out1_s16,...
    '==',fi(0,nt2,fiMath1,'hex','2'),...
    'Compare To Constant',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant1_out1_s17,...
    '==',fi(0,nt2,fiMath1,'hex','3'),...
    'Compare To Constant1',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant10_out1_s18,...
    '~=',fi(0,nt2,fiMath1,'hex','7'),...
    'Compare To Constant10',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant2_out1_s19,...
    '==',fi(0,nt2,fiMath1,'hex','4'),...
    'Compare To Constant2',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant3_out1_s20,...
    '==',fi(0,nt2,fiMath1,'hex','5'),...
    'Compare To Constant3',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant4_out1_s21,...
    '==',fi(0,nt2,fiMath1,'hex','6'),...
    'Compare To Constant4',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant5_out1_s22,...
    '==',fi(0,nt2,fiMath1,'hex','1'),...
    'Compare To Constant5',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant6_out1_s23,...
    '==',fi(0,nt2,fiMath1,'hex','0'),...
    'Compare To Constant6',1);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant7_out1_s24,...
    '==',fi(0,nt2,fiMath1,'hex','7'),...
    'Compare To Constant7',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    Delay_out1_s28,...
    CompareToConstant8_out1_s25,...
    '==',fi(0,nt2,fiMath1,'hex','7'),...
    'Compare To Constant8',0);


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_out1_s56,...
    CompareToConstant9_out1_s26,...
    '==',fi(0,nt2,fiMath1,'hex','7'),...
    'Compare To Constant9',0);


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay1_lowered_out1_s31],...
    Delay_Switch_out1_s47,...
    delayMatch_out1_s83,'Delay_Switch',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay2_lowered_out1_s33],...
    Delay_Switch1_out1_s48,...
    delayMatch2_out1_s93,'Delay_Switch1',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay3_lowered_out1_s35],...
    Delay_Switch2_out1_s49,...
    delayMatch4_out1_s95,'Delay_Switch2',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay4_lowered_out1_s37],...
    Delay_Switch3_out1_s50,...
    delayMatch6_out1_s97,'Delay_Switch3',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay5_lowered_out1_s39],...
    Delay_Switch4_out1_s51,...
    delayMatch8_out1_s99,'Delay_Switch4',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay6_lowered_out1_s41],...
    Delay_Switch5_out1_s52,...
    delayMatch10_out1_s85,'Delay_Switch5',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay7_lowered_out1_s43],...
    Delay_Switch6_out1_s53,...
    delayMatch12_out1_s87,'Delay_Switch6',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [PipelineRegister_out1_s68,Delay8_lowered_out1_s45],...
    Delay_Switch7_out1_s54,...
    delayMatch14_out1_s89,'Delay_Switch7',...
    '~=',0,'Floor','Wrap');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    rstIn_s2,...
    LogicalOperator_out1_s57,...
    'not','Logical Operator');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [validIn_s1,CompareToConstant9_out1_s26],...
    LogicalOperator1_out1_s58,...
    'and','Logical Operator1');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [rstIn_s2,AND11_out1_s6,LogicalOperator1_out1_s58],...
    LogicalOperator4_out1_s59,...
    'or','Logical Operator4');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND_out1_s4],...
    OR_out1_s60,...
    'or','OR');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND1_out1_s5],...
    OR1_out1_s61,...
    'or','OR1');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND2_out1_s8],...
    OR2_out1_s62,...
    'or','OR2');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND3_out1_s9],...
    OR3_out1_s63,...
    'or','OR3');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND4_out1_s10],...
    OR4_out1_s64,...
    'or','OR4');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND5_out1_s11],...
    OR5_out1_s65,...
    'or','OR5');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND6_out1_s12],...
    OR6_out1_s66,...
    'or','OR6');


    pirelab.getLogicComp(nVarVecPiBy2BPSK,...
    [AND8_out1_s14,AND7_out1_s13],...
    OR7_out1_s67,...
    'or','OR7');


    pirelab.getMulComp(nVarVecPiBy2BPSK,...
    [Constant_out1_s27,nVarIn_s0],...
    Product_out1_s69,...
    'Floor','Wrap','Product','**','',-1,0);


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [mux_out1_s101,delayMatch17_out1_s92],...
    Switch1_out1_s70,...
    delayMatch16_out1_s91,'Switch1',...
    '>',0,'Floor','Wrap');


    pirelab.getAddComp(nVarVecPiBy2BPSK,...
    [HDLCounter_out1_s55,step_value_out1_s103],...
    adder_out1_s71,...
    'Floor','Wrap','adder',pirTyp4,'++');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay1_lowered_out1_s31,Delay1_bypass_out1_s30],...
    bypass_out_out1_s72,...
    delayMatch1_out1_s84,'bypass_out',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay2_lowered_out1_s33,Delay2_bypass_out1_s32],...
    bypass_out1_out1_s73,...
    delayMatch3_out1_s94,'bypass_out1',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay3_lowered_out1_s35,Delay3_bypass_out1_s34],...
    bypass_out2_out1_s74,...
    delayMatch5_out1_s96,'bypass_out2',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay4_lowered_out1_s37,Delay4_bypass_out1_s36],...
    bypass_out3_out1_s75,...
    delayMatch7_out1_s98,'bypass_out3',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay5_lowered_out1_s39,Delay5_bypass_out1_s38],...
    bypass_out4_out1_s76,...
    delayMatch9_out1_s100,'bypass_out4',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay6_lowered_out1_s41,Delay6_bypass_out1_s40],...
    bypass_out5_out1_s77,...
    delayMatch11_out1_s86,'bypass_out5',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay7_lowered_out1_s43,Delay7_bypass_out1_s42],...
    bypass_out6_out1_s78,...
    delayMatch13_out1_s88,'bypass_out6',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [Delay8_lowered_out1_s45,Delay8_bypass_out1_s44],...
    bypass_out7_out1_s79,...
    delayMatch15_out1_s90,'bypass_out7',...
    '~=',0,'Floor','Wrap');


    pirelab.getCompareToValueComp(nVarVecPiBy2BPSK,...
    HDLCounter_out1_s55,...
    compare_out1_s80,...
    '==',fi(0,nt2,fiMath1,'hex','7'),...
    'compare',0);


    pirelab.getMuxComp(nVarVecPiBy2BPSK,...
    [bypass_out_out1_s72,bypass_out1_out1_s73,bypass_out2_out1_s74,bypass_out3_out1_s75,bypass_out4_out1_s76,bypass_out5_out1_s77,...
    bypass_out6_out1_s78,bypass_out7_out1_s79],...
    mux_out1_s101,...
    'mux');


    pirelab.getMuxComp(nVarVecPiBy2BPSK,...
    [nVarIn_s0,nVarIn_s0,nVarIn_s0,nVarIn_s0,nVarIn_s0,nVarIn_s0,...
    nVarIn_s0,nVarIn_s0],...
    mux1_out1_s102,...
    'mux');


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [countFrom_out1_s82,adder_out1_s71],...
    switch_out1_s104,...
    compare_out1_s80,'switch',...
    '~=',0,'Floor','Wrap');


    pirelab.getMultiPortSwitchComp(nVarVecPiBy2BPSK,...
    [validIn_s1,HDLCounter_out1_s55,switch_out1_s104],...
    switchEnable_out1_s105,...
    1,'Zero-based contiguous','Floor','Wrap','switchEnable',[]);


    pirelab.getSwitchComp(nVarVecPiBy2BPSK,...
    [const_out1_s81,switchEnable_out1_s105],...
    switchReset_out1_s106,...
    LogicalOperator4_out1_s59,'switchReset',...
    '~=',0,'Floor','Wrap');




    pirelab.getWireComp(nVarVecPiBy2BPSK,Switch1_out1_s70,nvarVecOut);
end




function hS=addSignal(nVarVecPiBy2BPSK,sigName,pirTyp,simulinkRate)
    hS=nVarVecPiBy2BPSK.addSignal;
    hS.Name=sigName;
    hS.Type=pirTyp;
    hS.SimulinkHandle=0;
    hS.SimulinkRate=simulinkRate;
end