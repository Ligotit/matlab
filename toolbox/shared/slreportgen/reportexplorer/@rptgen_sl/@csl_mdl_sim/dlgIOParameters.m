function dlgStruct=dlgIOParameters(this,varargin)




    dlgStruct=this.dlgContainer({
    this.dlgWidget('UseMdlIOParam',...
    'DialogRefresh',1)
    this.dlgWidget('TimeOut',...
    'Enabled',~this.UseMdlIOParam)
    this.dlgWidget('StatesOut',...
    'Enabled',~this.UseMdlIOParam)
    this.dlgWidget('MatrixOut',...
    'Enabled',~this.UseMdlIOParam)
    },getString(message('RptgenSL:rsl_csl_mdl_sim:ioParamsLabel')),...
    varargin{:});