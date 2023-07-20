function dlgStruct=getDialogSchema(this,name)




    isLib=this.isLibrary;

    optPanel=this.dlgContainer([
    locWidget(this,'DisplayName','RowSpan',[1,1],'ColSpan',[1,3],'Enabled',~isLib)
    locWidget(this,'Description','RowSpan',[2,2],'ColSpan',[1,3],'Enabled',~isLib)
    {
    this.dlgText([get(findprop(this,'TransformType'),'Description'),':'],...
    'RowSpan',[3,3],'ColSpan',[1,1])
    this.dlgText(this.TransformType,...
    'RowSpan',[3,3],'ColSpan',[2,3])
    struct('Type','pushbutton',...
    'DialogRefresh',true,...
    'Name',getString(message('rptgen:RptgenML_StylesheetEditor:sendToFileConverterLabel')),...
    'RowSpan',[4,4],...
    'ColSpan',[1,2],...
    'ToolTip',getString(message('rptgen:RptgenML_StylesheetEditor:openFileConversionWithCurrentLabel')),...
    'Enabled',~isempty(this.ID)&&~strncmp(this.ID,'-',1)&&~isempty(this.Registry),...
    'MatlabMethod','rptconvert',...
    'MatlabArgs',{{this,}})
    }],getString(message('rptgen:RptgenML_StylesheetEditor:stylesheetOptions')),...
    'LayoutGrid',[5,3],...
    'ColStretch',[0,0,1]);

    if isLib
        if isempty(this.Registry)||...
            ~endsWith(java.lang.String(this.Registry),(com.mathworks.toolbox.rptgencore.tools.StylesheetMaker.FILE_EXT_SS))
            locText=['<',getString(message('rptgen:RptgenML_StylesheetEditor:builtinStylesheetLabel')),'>'];
            enableDelete=false;

        else
            locText=this.Registry;
            enableDelete=true;

        end


        dlgStruct=this.dlgMain(name,{
        this.dlgContainer({
        this.dlgText(locText,...
        'WordWrap',1,...
        'RowSpan',[1,1],...
        'ColSpan',[1,2])
        struct('Type','pushbutton',...
        'RowSpan',[2,2],...
        'ColSpan',[1,1],...
        'ObjectMethod','exploreAction',...
        'FilePath',fullfile(matlabroot,'toolbox','rptgen','resources','Stylesheet.png'))
        this.dlgText(getString(message('rptgen:RptgenML_StylesheetEditor:editStylesheetLabel')),...
        'RowSpan',[2,2],...
        'ColSpan',[2,2])
        struct('Type','pushbutton',...
        'DialogRefresh',true,...
        'FilePath',fullfile(matlabroot,'toolbox','rptgen','resources','delete.png'),...
        'Enabled',enableDelete,...
        'RowSpan',[3,3],...
        'ColSpan',[1,1],...
        'MatlabMethod','registryRemove',...
        'MatlabArgs',{{this,true}})
        this.dlgText(getString(message('rptgen:RptgenML_StylesheetEditor:deleteStylesheetLabel')),...
        'RowSpan',[3,3],...
        'ColSpan',[2,2])
        },getString(message('rptgen:RptgenML_StylesheetEditor:stylesheetFile')),...
        'LayoutGrid',[3,2],...
        'ColStretch',[0,1],...
        'RowSpan',[1,1],...
        'ColSpan',[1,1])
        this.dlgSet(optPanel,...
        'RowSpan',[2,2],...
        'ColSpan',[1,1])
        },'LayoutGrid',[3,1],...
        'RowStretch',[0,0,1],...
        'DialogTitle',getString(message('rptgen:RptgenML_StylesheetEditor:stylesheetLabel')));
    else
        dlgStruct=this.dlgMain(name,{
        this.dlgSet(optPanel,...
        'RowSpan',[1,1],...
        'ColSpan',[1,1])
        RptgenML.dlgChildContainer(this,getString(message('rptgen:RptgenML_StylesheetEditor:stylesheetCustomizationsLabel')),...
        'RowSpan',[2,2],...
        'ColSpan',[1,1])
        },'LayoutGrid',[2,1],...
        'RowStretch',[0,1],...
        'DialogTitle',getString(message('rptgen:RptgenML_StylesheetEditor:editStylesheetMainLabel')));

    end



    function w=locWidget(this,propName,varargin)

        wControl=this.dlgWidget(propName,varargin{:});
        firstCol=wControl.ColSpan(1);
        wControl.ColSpan(1)=firstCol+1;
        wPrompt=this.dlgText(wControl.Name,...
        'ColSpan',[firstCol,firstCol],...
        'RowSpan',wControl.RowSpan);
        wControl=rmfield(wControl,'Name');


        w={wPrompt;wControl};