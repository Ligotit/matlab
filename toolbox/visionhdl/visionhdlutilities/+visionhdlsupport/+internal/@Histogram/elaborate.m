function nComp=elaborate(this,hN,hC)





    blockInfo=getBlockInfo(this,hC);


    hCInSignal=hC.PirInputSignals;
    hCOutSignal=hC.PirOutputSignals;

...
...
...
...
...
...
...
...
...
...

    topNet=visionhdlsupport.internal.createNetworkWithComponent(hN,hC);
    topNet.addComment('Histogram');

...
...
...
...
...


    [inSig,outSig]=visionhdlsupport.internal.expandpixelcontrolbus(topNet);

    inportnames{1}='dataIn';
    inportnames{2}='hStartIn';
    inportnames{3}='hEndIn';
    inportnames{4}='vStartIn';
    inportnames{5}='vEndIn';
    inportnames{6}='validIn';
    inportnames{7}='binAddr';
    inportnames{8}='binReset';

    outportnames{1}='dataOut';
    outportnames{2}='readReady';
    outportnames{3}='validOut';

...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...


    for ii=1:numel(inportnames)
        inSig(ii).Name=inportnames{ii};
    end
    for ii=1:numel(outportnames)
        outSig(ii).Name=outportnames{ii};
    end


    this.elaborateHistogram(topNet,blockInfo,inSig,outSig);

    nComp=pirelab.instantiateNetwork(hN,topNet,hCInSignal,hCOutSignal,hC.Name);

end