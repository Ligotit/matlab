function RTOSSections=createDefaultRTOSSections(h)




    RTOSSections=struct(...
    'name',...
    {'.args','.gblinit','.trcdata','.sysdata','.obj','.bios','.sysinit','.hwi','.hwi_vec'},...
    'contents',...
    {'Data','Data','Data','Data','Data','Code','Code','Code','Code'},...
    'description',...
    {'Argument buffer',...
    'DSP/BIOS initialization tables',...
    'TRC mask variable initial value',...
    'DSP/BIOS kernel state',...
    'DSP/BIOS configuration',...
    'DSP/BIOS code',...
    'DSP/BIOS startup initialization',...
    'DSP/BIOS dispatch code',...
    'DSP/BIOS ISR table'},...
    'placement','');