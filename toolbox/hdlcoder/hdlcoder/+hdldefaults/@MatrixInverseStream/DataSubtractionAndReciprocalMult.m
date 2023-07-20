

function DataSubtractionAndReciprocalMult(~,hN,LTSubMultInSigs,LTSubMultOutSigs,...
    hBoolT,hInputDataT,slRate)


    hLTSubMultN=pirelab.createNewNetwork(...
    'Name','DataSubtractionAndReciprocalMult',...
    'InportNames',{'nonDiagDataIn','accumOutData','nonDiagValidIn','readDataReciprocal'},...
    'InportTypes',[hInputDataT,hInputDataT,hBoolT,hInputDataT],...
    'InportRates',slRate*ones(1,4),...
    'OutportNames',{'nonDiagValidOut','nonDiagDataOut','nonDiagCountValid'},...
    'OutportTypes',[hBoolT,hInputDataT,hBoolT]);

    hLTSubMultN.setTargetCompReplacementCandidate(true);


    for ii=1:numel(hLTSubMultN.PirOutputSignals)
        hLTSubMultN.PirOutputSignals(ii).SimulinkRate=slRate;
    end

    hLTSubMultNinSigs=hLTSubMultN.PirInputSignals;
    hLTSubMultNoutSigs=hLTSubMultN.PirOutputSignals;


    Constant8_out1_s4=l_addSignal(hLTSubMultN,'Constant8_out1',hInputDataT,slRate);
    Delay_out1_s5=l_addSignal(hLTSubMultN,'Delay_out1',hInputDataT,slRate);
    Delay1_out1_s6=l_addSignal(hLTSubMultN,'Delay1_out1',hInputDataT,slRate);
    Delay11_out1_s7=l_addSignal(hLTSubMultN,'Delay11_out1',hInputDataT,slRate);
    Delay2_out1_s8=l_addSignal(hLTSubMultN,'Delay2_out1',hInputDataT,slRate);
    Delay3_out1_s9=l_addSignal(hLTSubMultN,'Delay3_out1',hInputDataT,slRate);
    Delay5_out1_s11=l_addSignal(hLTSubMultN,'Delay5_out1',hInputDataT,slRate);
    Delay6_out1_s12=l_addSignal(hLTSubMultN,'Delay6_out1',hBoolT,slRate);
    Delay7_out1_s13=l_addSignal(hLTSubMultN,'Delay7_out1',hInputDataT,slRate);
    Delay8_out1_s14=l_addSignal(hLTSubMultN,'Delay8_out1',hBoolT,slRate);
    Delay9_out1_s15=l_addSignal(hLTSubMultN,'Delay9_out1',hInputDataT,slRate);
    Product_out1_s16=l_addSignal(hLTSubMultN,'Product_out1',hInputDataT,slRate);
    Subtract_out1_s17=l_addSignal(hLTSubMultN,'Subtract_out1',hInputDataT,slRate);
    Switch_out1_s18=l_addSignal(hLTSubMultN,'Switch_out1',hInputDataT,slRate);
    Switch1_out1_s19=l_addSignal(hLTSubMultN,'Switch1_out1',hInputDataT,slRate);
    multReciprocalVld_out1_s20=l_addSignal(hLTSubMultN,'multReciprocalVld_out1',hBoolT,slRate);
    multReciprocalVld1_out1_s21=l_addSignal(hLTSubMultN,'multReciprocalVld1_out1',hBoolT,slRate);



    pirelab.getConstComp(hLTSubMultN,...
    Constant8_out1_s4,...
    single(0),...
    'Constant8','on',1,'','','');


    pirelab.getIntDelayComp(hLTSubMultN,...
    hLTSubMultNinSigs(1),...
    Delay_out1_s5,...
    2,'Delay',...
    single(0),...
    0,0,[],0,0);

    hMultC=pirelab.getMulComp(hLTSubMultN,...
    [Delay3_out1_s9,Delay5_out1_s11],...
    Product_out1_s16,...
    'Floor','Wrap','Product','**','',-1,0);



    hAddC=pirelab.getAddComp(hLTSubMultN,...
    [Delay9_out1_s15,hLTSubMultNinSigs(2)],...
    Subtract_out1_s17,...
    'Floor','Wrap','Subtract',hInputDataT,'+-');


    pirelab.getIntDelayComp(hLTSubMultN,...
    Subtract_out1_s17,...
    Delay1_out1_s6,...
    resolveLatencyForIPType(hAddC,'ADDSUB'),'Delay1',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Delay2_out1_s8,...
    Delay11_out1_s7,...
    resolveLatencyForIPType(hAddC,'ADDSUB')+resolveLatencyForIPType(hMultC,'MUL'),...
    'Delay11',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    hLTSubMultNinSigs(4),...
    Delay2_out1_s8,...
    3,'Delay2',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Switch_out1_s18,...
    Delay3_out1_s9,...
    1,'Delay3',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Delay8_out1_s14,...
    hLTSubMultNoutSigs(3),...
    resolveLatencyForIPType(hAddC,'ADDSUB'),'Delay4',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Delay11_out1_s7,...
    Delay5_out1_s11,...
    resolveLatencyForIPType(hAddC,'ADDSUB'),'Delay5',...
    single(0),...
    0,0,[],0,0);

    pirelab.getIntDelayComp(hLTSubMultN,...
    multReciprocalVld1_out1_s21,...
    Delay6_out1_s12,...
    resolveLatencyForIPType(hMultC,'MUL'),'Delay6',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Product_out1_s16,...
    Delay7_out1_s13,...
    resolveLatencyForIPType(hMultC,'MUL'),'Delay7',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    multReciprocalVld_out1_s20,...
    Delay8_out1_s14,...
    resolveLatencyForIPType(hMultC,'MUL')+resolveLatencyForIPType(hAddC,'ADDSUB'),'Delay8',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Delay_out1_s5,...
    Delay9_out1_s15,...
    resolveLatencyForIPType(hMultC,'MUL')+resolveLatencyForIPType(hAddC,'ADDSUB'),'Delay9',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    hLTSubMultNinSigs(3),...
    multReciprocalVld_out1_s20,...
    2,'multReciprocalVld',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    hLTSubMultNoutSigs(3),...
    multReciprocalVld1_out1_s21,...
    1,'multReciprocalVld1',...
    false,...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Switch1_out1_s19,...
    hLTSubMultNoutSigs(2),...
    1,'nonDiagDataOutReg',...
    single(0),...
    0,0,[],0,0);


    pirelab.getIntDelayComp(hLTSubMultN,...
    Delay6_out1_s12,...
    hLTSubMultNoutSigs(1),...
    1,'nonDiagOutVldReg',...
    false,...
    0,0,[],0,0);







    pirelab.getSwitchComp(hLTSubMultN,...
    [Delay1_out1_s6,Constant8_out1_s4],...
    Switch_out1_s18,...
    hLTSubMultNoutSigs(3),'Switch',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(hLTSubMultN,...
    [Delay7_out1_s13,Constant8_out1_s4],...
    Switch1_out1_s19,...
    Delay6_out1_s12,'Switch1',...
    '~=',0,'Floor','Wrap');



    pirelab.instantiateNetwork(hN,hLTSubMultN,LTSubMultInSigs,...
    LTSubMultOutSigs,[hLTSubMultN.Name,'_inst']);

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
    latency=targetDriver.getDefaultLatency(targetIPType,targetCompDataType,hC);
end

