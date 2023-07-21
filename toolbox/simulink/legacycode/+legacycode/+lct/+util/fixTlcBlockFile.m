function[status,msg,needFix]=fixTlcBlockFile(fpath,checkOnly)





    narginchk(1,2);
    validateattributes(fpath,...
    {'char','string'},{'scalartext'},'legacycode.lct.util.fixTlcBlockFile','',1);
    fpath=convertStringsToChars(fpath);

    if nargin<2
        checkOnly=false;
    else
        validateattributes(checkOnly,{'logical','numeric'},{'scalar','binary'});
        checkOnly=logical(checkOnly);
    end

    status=0;
    msg=[];
    needFix=false;

    [fid,errMsg]=fopen(fpath,'rt');
    if~isnumeric(fid)||fid<0
        [fpath,fname,fext]=fileparts(fpath);
        msg=message('Simulink:tools:LCTErrorCannotOpenFile',...
        fullfile(fpath,fname),fext(2:end),['(',errMsg,')']);
        status=2;
        return
    end
    txt=fread(fid,'*char')';
    fclose(fid);


    if isempty(regexp(txt,'%%%-MATLAB_Construction_Commands_Start','once'))||...
        isempty(regexp(txt,'%%%-MATLAB_Construction_Commands_End','once'))
        msg=message('Simulink:tools:LCTFileNotGeneratedByLCT',fpath);
        status=1;
        return
    end


    errMsg=[...
    'S-Functions generated by the Legacy Code Tool (that use Simulink Object) ',...
'may not be used in a model for which an ERT S-Function wrapper is being generated'...
    ];
    pat=[...
    '%if GenerateErtSFunction==1 && slVer < 6.21',newline,...
    ['%<LibReportFatalError("',errMsg,'")>'],newline,...
    '%endif',newline,...
    ];
    [txt,found]=removeText(txt,pat);
    needFix=needFix||found;

    errMsg=[...
    'S-Functions generated by the Legacy Code Tool (that use Simulink BusObject) ',...
    'may not be used in a model uses External Mode',...
    ];
    pat=[...
    '%if ExtMode==1 && slVer < 6.3',newline,...
    ['%<LibReportFatalError("',errMsg,'")>'],newline,...
    '%endif',newline,...
    ];
    [txt,found]=removeText(txt,pat);
    needFix=needFix||found;

    errMsg=[...
    'S-Functions generated by the Legacy Code Tool (that use Simulink.StructType) ',...
'may not be used with this version of Simulink.'...
    ];
    pat=[...
    '%if slVer < 7.2',newline,...
    ['%<LibReportFatalError("',errMsg,'")>'],newline,...
    '%endif',newline,...
    ];
    [txt,found]=removeText(txt,pat);
    needFix=needFix||found;

    errMsg=[...
    'S-Functions generated by the Legacy Code Tool (that use Simulink BusObject) ',...
    'may not be used in a referenced model',...
    ];
    pat=[...
    '%if slVer < 6.21',newline,...
    ['%<LibReportFatalError("',errMsg,'")>'],newline,...
    '%endif',newline...
    ];
    [txt,found]=removeText(txt,pat);
    needFix=needFix||found;


    if checkOnly||~needFix
        return
    end


    [fid,errMsg]=fopen(fpath,'wt');
    if~isnumeric(fid)||fid<0
        [fpath,fname,fext]=fileparts(fpath);
        msg=message('Simulink:tools:LCTErrorCannotOpenFile',...
        fullfile(fpath,fname),fext(2:end),['(',errMsg,')']);
        status=2;
        return
    end
    fwrite(fid,txt,'*char');
    fclose(fid);


    function[txt,found]=removeText(txt,pat)

        origNumEl=numel(txt);
        pat=regexptranslate('escape',pat);
        pat=regexprep(pat,'\s+','\\s+');
        txt=regexprep(txt,pat,'');
        found=numel(txt)~=origNumEl;