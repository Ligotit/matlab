function dlgStruct=dlgValueContainer(this,varargin)




    if isLibrary(this)
        globalEnable=0;
    else
        globalEnable=1;
    end

    pTest=struct(findprop(classhandle(this),'test'));
    pTest.DataType=this.listTestSpecial;



    isTestSpecial=any(strcmp(this.Test,pTest.DataType(:,1)));

    dlgStruct=this.dlgContainer({
    this.dlgText(getString(message('rptgen:RptgenML_StylesheetHeaderCell:useForHeaderFooterBooleanLabel')),...
    'WordWrap',true,...
    'ColSpan',[1,2],...
    'RowSpan',[1,1])
    this.dlgWidget(pTest,...
    'Enabled',globalEnable,...
    'Editable',true,...
    'ColSpan',[1,1],...
    'RowSpan',[2,2])
    struct('Type','pushbutton',...
    'Tag','dlgEditTest',...
    'Name',getString(message('rptgen:RptgenML_StylesheetHeaderCell:editLabel')),...
    'ToolTip',getString(message('rptgen:RptgenML_StylesheetHeaderCell:convertToXmlLabel')),...
    'Enabled',globalEnable&&isTestSpecial,...
    'MatlabMethod','dlgEditTest',...
    'MatlabArgs',{{'%source','%dialog'}},...
    'DialogRefresh',true,...
    'ColSpan',[2,2],...
    'RowSpan',[2,2])
    RptgenML.StylesheetHeaderCell.dlgValueSpecial(this,'Value',this.JavaHandle,...
    'ColSpan',[1,2],...
    'RowSpan',[3,3])
    },getString(message('rptgen:RptgenML_StylesheetHeaderCell:valueLabel')),...
    'LayoutGrid',[3,2],'RowStretch',[0,0,1],'ColStretch',[1,0],varargin{:});