function bSection=elabBuffer(~,hTopN,blockInfo,slRate,integOutreg_re,integOutreg_im,ireg_vout,ireg_rstout,integOut_re,integOut_im,i_vout)




    in1=integOutreg_re;
    in2=integOutreg_im;
    in3=ireg_vout;
    in4=ireg_rstout;

    out1=integOut_re;
    out2=integOut_im;
    out3=i_vout;


    bSection=pirelab.createNewNetwork(...
    'Network',hTopN,...
    'Name','bSection',...
    'InportNames',{'integOutreg_re','integOutreg_im','ireg_vout','ireg_rstout'},...
    'InportTypes',[in1.Type,in2.Type,in3.Type,in4.Type],...
    'Inportrates',[slRate,slRate,slRate,slRate],...
    'OutportNames',{'integOut_re','integOut_im','i_vout'},...
    'OutportTypes',[out1.Type,out2.Type,out3.Type]...
    );


    integOutreg_re=bSection.PirInputSignals(1);
    integOutreg_im=bSection.PirInputSignals(2);
    ireg_vout=bSection.PirInputSignals(3);
    ireg_rstout=bSection.PirInputSignals(4);

    integOut_re=bSection.PirOutputSignals(1);
    integOut_im=bSection.PirOutputSignals(2);
    i_vout=bSection.PirOutputSignals(3);

    maxInterpFact=blockInfo.InterpolationFactor;
    outvecsize=blockInfo.R1;
    stagevecsize=blockInfo.R2;


    fid=fopen(fullfile(matlabroot,'toolbox','dsphdl','dsphdlutilities','+dsphdlsupport','+internal',...
    '@CICInterpolator','cgireml','bufferSection.m'),'r');
    bufferSection=fread(fid,Inf,'char=>char');
    fclose(fid);
    bSection.addComponent2(...
    'kind','cgireml',...
    'Name','bufferSection',...
    'InputSignals',[integOutreg_re,integOutreg_im,ireg_vout,ireg_rstout],...
    'OutputSignals',[integOut_re,integOut_im,i_vout],...
    'EMLFileName','bufferSection',...
    'EMLFileBody',bufferSection,...
    'EmlParams',{maxInterpFact,outvecsize,stagevecsize},...
    'EMLFlag_TreatInputIntsAsFixpt',true);
end