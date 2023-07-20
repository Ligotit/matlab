function dlgStruct=dlgValueContainer(this,varargin)





    normValue=strtrim(this.Value);
    isXMLValueText=~this.Casted&&~isempty(normValue)&&strcmp(normValue(1),'<')&&strcmp(normValue(end),'>');

    if isLibrary(this)
        globalEnable=0;
    else
        globalEnable=1;
    end

    if isXMLValueText


        dlgStruct=this.dlgContainer({
        this.dlgText(normValue,...
        'WordWrap',1,...
        'ColSpan',[1,2],...
        'RowSpan',[1,1])
        this.dlgText(getString(message('rptgen:RptgenML_StylesheetElement:xmlValueLabel')),...
        'ColSpan',[1,1],...
        'RowSpan',[2,2]);
        rmfield(this.dlgWidget('Value',...
        'ColSpan',[1,2],...
        'RowSpan',[3,3],...
        'Type','editarea',...
        'Tag','ValueXML',...
        'DialogRefresh',1,...
        'Enabled',globalEnable),'Name')
        },getString(message('rptgen:RptgenML_StylesheetElement:valueLabel')),...
        'LayoutGrid',[3,2],'RowStretch',[0,0,1],'ColStretch',[1,0],...
        varargin{:});

    elseif(rptgen.use_java&&com.mathworks.toolbox.rptgen.xml.StylesheetEditor.isParameterNode(this.JavaHandle))...
        ||mlreportgen.re.internal.ui.StylesheetEditor.isParameterNode(this.JavaHandle)
        badValue=strncmp(this.Value,'[[',2);

        dlgStruct=this.dlgContainer({
        this.dlgText(getString(message('rptgen:RptgenML_StylesheetElement:xmlValueLabel')),...
        'ColSpan',[1,1],...
        'RowSpan',[2,2]);
        struct('Type','pushbutton',...
        'ColSpan',[2,2],...
        'RowSpan',[2,2],...
        'Tag','castValueAsString',...
        'DialogRefresh',1,...
        'Enabled',globalEnable,...
        'ToolTip',getString(message('rptgen:RptgenML_StylesheetElement:convertToStringLabel')),...
        'MatlabMethod','castValueAsString',...
        'MatlabArgs',{{'%source'}},...
        'Name',getString(message('rptgen:RptgenML_StylesheetElement:editAsStringLabel')))
        rmfield(this.dlgWidget('Value',...
        'ColSpan',[1,2],...
        'RowSpan',[3,3],...
        'Type','editarea',...
        'Tag','ValueXML',...
        'DialogRefresh',1,...
        'Enabled',globalEnable&&~badValue),'Name')
        },getString(message('rptgen:RptgenML_StylesheetElement:valueLabel')),...
        'LayoutGrid',[3,2],'RowStretch',[0,0,1],'ColStretch',[1,0]);
    else


        dlgStruct=this.dlgContainer({
        this.dlgWidget('Value',...
        'ColSpan',[1,1],...
        'RowSpan',[2,2],...
        'DialogRefresh',1,...
        'Enabled',globalEnable)
        struct('Type','pushbutton',...
        'ColSpan',[2,2],...
        'RowSpan',[2,2],...
        'Tag','castValueAsXML',...
        'ToolTip',getString(message('rptgen:RptgenML_StylesheetElement:convertToXmlLabel')),...
        'DialogRefresh',1,...
        'Enabled',globalEnable,...
        'MatlabMethod','castValueAsXML',...
        'MatlabArgs',{{'%source'}},...
        'Name',getString(message('rptgen:RptgenML_StylesheetElement:editAsXmlLabel')))
        },getString(message('rptgen:RptgenML_StylesheetElement:valueLabel')),...
        'LayoutGrid',[2,2],'RowStretch',[0,0],'ColStretch',[1,0]);
    end
