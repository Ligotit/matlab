function hC=getSlicer(s)







    hC=pirelab.getBitSliceComp(...
    s.Network,...
    s.Inputs,...
    s.Outputs,...
    s.MSB,...
    s.LSB,...
    s.Name);