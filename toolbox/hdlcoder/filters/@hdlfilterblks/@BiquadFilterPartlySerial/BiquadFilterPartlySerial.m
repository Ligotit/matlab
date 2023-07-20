function this=BiquadFilterPartlySerial(block)





    this=hdlfilterblks.BiquadFilterPartlySerial;

    supportedBlocks={...
    'dsparch4/Biquad Filter',...
    };

    if nargin==0
        block='';
    end


    desc=struct(...
    'ShortListing','Biquad Filter Partly Serial',...
    'HelpText','Biquad Filter code generation via direct HDL instantiation');

    this.init('SupportedBlocks',supportedBlocks,...
    'Block',block,...
    'ArchitectureNames',{'Partly Serial'},...
    'CodeGenMode','instantiation',...
    'Description',desc);