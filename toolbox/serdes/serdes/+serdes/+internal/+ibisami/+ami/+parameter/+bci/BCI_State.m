classdef BCI_State<serdes.internal.ibisami.ami.parameter.BCIReservedParameter

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



    methods
        function param=BCI_State()
            param.NodeName="BCI_State";
            param.Usage=serdes.internal.ibisami.ami.usage.InOut;
            param.Type=serdes.internal.ibisami.ami.type.String;
            param.Format=serdes.internal.ibisami.ami.format.List("Off","Training","Converged","Failed","Error");
            param.Description=...
            "State of the BCI subsystem. Initialized to Off or Traning by the EDA tool";
            param.AllowedUsages=["InOut"];%#ok<*NBRAK>
            param.AllowedTypes=["String"];
            param.AllowedFormats=["List"];
            param.EarliestRequiredVersion=7.0;
        end
    end
end
