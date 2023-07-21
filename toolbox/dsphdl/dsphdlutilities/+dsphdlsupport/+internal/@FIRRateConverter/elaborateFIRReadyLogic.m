function firRdyLogic=elaborateFIRReadyLogic(this,net,dataRate,dataIn,validIn,countReached,syncReset,...
    ready,dIn,dInVld,...
    DIN_SIGNED,DIN_WORDLENGTH,DIN_FRACTIONLENGTH,SharingFactor,NUMCHANNEL)




    if isempty(syncReset)
        InportNames={dataIn.Name,validIn.Name,countReached.Name};
        InportTypes=[dataIn.Type,validIn.Type,countReached.Type];
        InportRates=[dataRate;dataRate;dataRate];
    else
        InportNames={dataIn.Name,validIn.Name,countReached.Name,syncReset.Name,};
        InportTypes=[dataIn.Type,validIn.Type,countReached.Type,syncReset.Type,];
        InportRates=[dataRate;dataRate;dataRate;dataRate];
    end

    OutportNames={ready.Name,dIn.Name,dInVld.Name};
    OutportTypes=[ready.Type,dIn.Type,dInVld.Type];

    firRdyLogic=pirelab.createNewNetwork(...
    'Network',net,...
    'Name','FirRdyLogic',...
    'InportNames',InportNames,...
    'InportTypes',InportTypes,...
    'InportRates',InportRates,...
    'OutportNames',OutportNames,...
    'OutportTypes',OutportTypes...
    );

    inputPort=firRdyLogic.PirInputSignals;
    outputPort=firRdyLogic.PirOutputSignals;

    dataIn=inputPort(1);
    validIn=inputPort(2);
    countReached=inputPort(3);







    ready=outputPort(1);
    dIn=outputPort(2);
    dInVld=outputPort(3);

    fid=fopen(fullfile(matlabroot,...
    'toolbox','dsphdl','dsphdlutilities','+dsphdlsupport','+internal',...
    '@FIRRateConverter','cgireml','firReadyLogic.m'));
    fcnBody=fread(fid,Inf,'char=>char');

    fclose(fid);

    if NUMCHANNEL==0
        NUMCHANNEL=1;
    end

    rdyLogic=firRdyLogic.addComponent2(...
    'kind','cgireml',...
    'Name','firRdy',...
    'InputSignals',[dataIn,validIn,countReached],...
    'OutputSignals',[ready,dIn,dInVld],...
    'EMLFileName','firReadyLogic',...
    'EMLFileBody',fcnBody,...
    'EMLParams',{DIN_SIGNED,DIN_WORDLENGTH,DIN_FRACTIONLENGTH,SharingFactor,NUMCHANNEL},...
    'ExternalSynchronousResetSignal',syncReset,...
    'EMLFlag_TreatInputIntsAsFixpt',true,...
    'EMLFlag_SaturateOnIntOverflow',false,...
    'EMLFlag_TreatInputBoolsAsUfix1',false,...
    'BlockComment','rdyLogic');

    rdyLogic.runConcurrencyMaximizer(0);

end