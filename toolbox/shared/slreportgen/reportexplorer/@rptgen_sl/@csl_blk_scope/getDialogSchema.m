function dlgStruct=getDialogSchema(this,name)




    if~builtin('license','checkout','SIMULINK_Report_Gen')
        dlgStruct=this.buildErrorMessage(name,true);
        return;

    end










    dlgStruct=this.dlgMain(name,{
    this.dlgContainer({
    this.dlgWidget('isForceOpen',...
    'RowSpan',[1,1],...
    'ColSpan',[1,1])
    this.dlgWidget('AutoscaleScope',...
    'RowSpan',[1,1],...
    'ColSpan',[2,2])
    },getString(message('RptgenSL:rsl_csl_blk_scope:scopeOptionsLabel')),...
    'RowSpan',[1,1],...
    'ColSpan',[1,1],...
    'LayoutGrid',[1,2])
    this.dlgContainerSimplePrint('RowSpan',[2,2],'ColSpan',[1,1])
    this.gr_dlgDisplayOptions(...
    struct('none',getString(message('RptgenSL:rsl_csl_blk_scope:noTitleLabel')),...
    'blkname','blockname',...
    'fullname',getString(message('RptgenSL:rsl_csl_blk_scope:slPathExampleLabel')),...
    'manual','-Title'),...
    struct('manual','-Caption',...
    'auto',getString(message('RptgenSL:rsl_csl_blk_scope:fromDescriptionLabel')),...
    'none',getString(message('RptgenSL:rsl_csl_blk_scope:noCaptionLabel'))),...
    'RowSpan',[3,3],...
    'ColSpan',[1,1])
    },'LayoutGrid',[3,1],'RowStretch',[0,0,1]);


