function this=DataTypeRow(type,row,controller,customStruct)


























































































    this=dspfixptddg.DataTypeRow;
    if nargin<4
        customStruct=[];
    end
    this.initDataTypeRow(type,row,controller,customStruct);