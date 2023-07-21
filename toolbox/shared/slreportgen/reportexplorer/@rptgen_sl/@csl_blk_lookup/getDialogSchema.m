function dlgStruct=getDialogSchema(this,name)




    if~builtin('license','checkout','SIMULINK_Report_Gen')
        dlgStruct=this.buildErrorMessage(name,true);
        return;

    end




    dlgStruct=this.dlgMain(name,{
    this.dlgContainer({
    this.dlgWidget('isSinglePlot',...
    'DialogRefresh',true,...
    'RowSpan',[1,1],...
    'ColSpan',[1,1])
    this.dlgWidget('SinglePlotType',...
    'Enabled',this.isSinglePlot,...
    'RowSpan',[1,1],...
    'ColSpan',[2,2])
    this.dlgWidget('isSingleTable',...
    'RowSpan',[2,2],...
    'ColSpan',[1,2])
    this.dlgWidget('isDoublePlot',...
    'DialogRefresh',true,...
    'RowSpan',[3,3],...
    'ColSpan',[1,1])
    this.dlgWidget('DoublePlotType',...
    'Enabled',this.isDoublePlot,...
    'RowSpan',[3,3],...
    'ColSpan',[2,2])
    this.dlgWidget('isDoubleTable',...
    'RowSpan',[4,4],...
    'ColSpan',[1,2])
    this.dlgWidget('isMultiTable',...
    'RowSpan',[5,5],...
    'ColSpan',[1,2])
    },getString(message('RptgenSL:rsl_csl_blk_lookup:lookupTableOptionsLabel')),...
    'LayoutGrid',[5,2],...
    'RowSpan',[1,1],...
    'ColSpan',[1,1],...
    'ColStretch',[0,1])
    this.dlgContainerSimplePrint('RowSpan',[2,2],'ColSpan',[1,1])
    this.gr_dlgDisplayOptions(...
    struct('none',getString(message('RptgenSL:rsl_csl_blk_lookup:noTitleLabel')),...
    'auto','blockname',...
    'manual','-Title'),...
    struct('manual','-Caption',...
    'auto',getString(message('RptgenSL:rsl_csl_blk_lookup:fromDescriptionPropertyLabel')),...
    'none',getString(message('RptgenSL:rsl_csl_blk_lookup:noCaptionLabel'))),...
    'RowSpan',[3,3],...
    'ColSpan',[1,1])
    },'LayoutGrid',[3,1],...
    'RowStretch',[0,0,1]);
