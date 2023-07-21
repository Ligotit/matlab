function filterTap=elabFilterTap(this,topNet,blockInfo,dataRate,...
    din,coef,addin,syncReset,...
    tapout,...
    DATA_WORDLENGTH,DATA_FRACTIONLENGTH,...
    COEF_WORDLENGTH,COEF_FRACTIONLENGTH,...
    OUTPUT_WORDLENGTH,OUTPUT_FRACTIONLENGTH)








    InportNames={din.Name,coef.Name,addin.Name,syncReset.Name};
    InportTypes=[din.Type,coef.Type,addin.Type,syncReset.Type];
    InportRates=[dataRate;dataRate;dataRate;dataRate];

    OutportNames={tapout.Name};
    OutportTypes=[tapout.Type];

    filterTap=pirelab.createNewNetwork(...
    'Network',topNet,...
    'Name','FilterTap',...
    'InportNames',InportNames,...
    'InportTypes',InportTypes,...
    'InportRates',InportRates,...
    'OutportNames',OutportNames,...
    'OutportTypes',OutportTypes...
    );

    inputPort=filterTap.PirInputSignals;
    outputPort=filterTap.PirOutputSignals;
    din=inputPort(1);
    coef=inputPort(2);
    addin=inputPort(3);

    if blockInfo.inMode(2)
        syncReset=inputPort(4);
    else
        syncReset='';
    end

    tapout=outputPort(1);



    fid=fopen(fullfile(matlabroot,'toolbox','dsphdl','dsphdlutilities',...
    '+dsphdlsupport','+internal','@AbstractFilterBank','cgireml','FilterTap.m'),'r');
    fcnBody=fread(fid,Inf,'char=>char')';
    fclose(fid);

    desc='FilterTap';

    tap=filterTap.addComponent2(...
    'kind','cgireml',...
    'Name','fTap',...
    'InputSignals',[din,coef,addin],...
    'OutputSignals',tapout,...
    'EMLFileName','FilterTap',...
    'EMLFileBody',fcnBody,...
    'EMLParams',{DATA_WORDLENGTH,DATA_FRACTIONLENGTH...
    ,COEF_WORDLENGTH,COEF_FRACTIONLENGTH,...
    OUTPUT_WORDLENGTH,OUTPUT_FRACTIONLENGTH},...
    'ExternalSynchronousResetSignal',syncReset,...
    'EMLFlag_TreatInputIntsAsFixpt',true,...
    'EMLFlag_SaturateOnIntOverflow',false,...
    'EMLFlag_TreatInputBoolsAsUfix1',false,...
    'BlockComment',desc);

    tap.runConcurrencyMaximizer(0);

    if blockInfo.HDLGlobalReset
        tap.resetNone(false);
    else
        tap.resetNone(true);
    end


end

