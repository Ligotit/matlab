function[widths,headings,height]=GetColInfo(this)
    maxPathLength=this.GetMaxPathLength;
    widths=[maxPathLength+3,12,11];
    headings={...
    'Full HDL Name',...
    sprintf('Active\nClock Edge'),...
'Period'...
    };
    height=4;
end