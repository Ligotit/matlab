function hNewC=lowerConcatenate(hN,hC)


    hNewC=pireml.getConcatenateComp(...
    hN,...
    hC.PirInputSignals,...
    hC.PirOutputSignals,...
    hC.Name);
end