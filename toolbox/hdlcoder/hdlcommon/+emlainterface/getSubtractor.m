function hC=getSubtractor(s)







    hC=pirelab.getSubComp(...
    s.Network,...
    s.Inputs,...
    s.Outputs,...
    s.RoundingMethod,...
    s.OverflowAction,...
    s.Name);