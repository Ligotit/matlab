function productSum=elabProductSum(~,topNet,blockInfo,dataRate,...
    din,coef,addin,syncReset,...
    dinDly,tapout,...
    DATA_WORDLENGTH,DATA_FRACTIONLENGTH,...
    COEF_WORDLENGTH,COEF_FRACTIONLENGTH,...
    OUTPUT_WORDLENGTH,OUTPUT_FRACTIONLENGTH)







    InportNames={din.Name,coef.Name,addin.Name,syncReset.Name};
    InportTypes=[din.Type,coef.Type,addin.Type,syncReset.Type];
    InportRates=[dataRate;dataRate;dataRate;dataRate];

    OutportNames={dinDly.Name,tapout.Name};
    OutportTypes=[dinDly.Type,tapout.Type];

    productSum=pirelab.createNewNetwork(...
    'Network',topNet,...
    'Name','ProductSum',...
    'InportNames',InportNames,...
    'InportTypes',InportTypes,...
    'InportRates',InportRates,...
    'OutportNames',OutportNames,...
    'OutportTypes',OutportTypes...
    );

    inputPort=productSum.PirInputSignals;
    outputPort=productSum.PirOutputSignals;
    din=inputPort(1);
    coef=inputPort(2);
    addin=inputPort(3);
    if blockInfo.ResetInputPort
        syncReset=inputPort(4);
    else
        syncReset='';
    end
    dinDly=outputPort(1);
    tapout=outputPort(2);



    fid=fopen(fullfile(matlabroot,'toolbox','dsphdl','dsphdlutilities','+dsphdlsupport','+internal',...
    '@AbstractFarrowFilter','cgireml','ProductSum.m'),'r');
    fcnBody=fread(fid,Inf,'char=>char')';
    fclose(fid);

    desc='ProductSum';

    blockInfo.synthesisTool='Xilinx Vivado';

    tap=productSum.addComponent2(...
    'kind','cgireml',...
    'Name','ProdSum',...
    'InputSignals',[din,coef,addin],...
    'OutputSignals',[dinDly,tapout],...
    'EMLFileName','ProductSum',...
    'EMLFileBody',fcnBody,...
    'EMLParams',{DATA_WORDLENGTH,DATA_FRACTIONLENGTH...
    ,COEF_WORDLENGTH,COEF_FRACTIONLENGTH,...
    OUTPUT_WORDLENGTH,OUTPUT_FRACTIONLENGTH,blockInfo.synthesisTool},...
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

