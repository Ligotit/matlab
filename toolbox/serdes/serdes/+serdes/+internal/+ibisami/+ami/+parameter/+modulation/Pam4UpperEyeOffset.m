classdef Pam4UpperEyeOffset<serdes.internal.ibisami.ami.parameter.modulation.Pam4EyeOffset

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
        function param=Pam4UpperEyeOffset()
            param.NodeName="PAM4_UpperEyeOffset";
            param.Description="The Upper eye sampling offset.";
            param.Format=serdes.internal.ibisami.ami.format.Value(2.5e-12);
        end
    end
end
