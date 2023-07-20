function hdlbody=verilogcheckerdelay(this,instance,check_enb,check_cnt,~,delay,rd_enb)




    hdlbody=[];

    counter=hdlsignalname(check_cnt);
    enable=hdlsignalname(check_enb);
    rdenb=hdlsignalname(rd_enb);

    if(this.ForceResetValue==0)
        resetedge='negedge';
    else
        resetedge='posedge';
    end

    processName=['checker_delay_',this.OutportSnk(instance).loggingPortName,'\n'];

    ClockName=this.OutportSnk(instance).ClockName;
    ResetName=getResetNameForPort(this,instance,'out');

    if hdlgetparameter('clockedge')==0
        clk_str=['  always @(posedge ',ClockName,' or ',resetedge,' ',ResetName,') // ',processName];
    else
        clk_str=['  always @(negedge ',ClockName,' or ',resetedge,' ',ResetName,') // ',processName];
    end

    if delay==1


        enableCondition=[rdenb,' == 1 '];
        hdlbody=[hdlbody,...
        clk_str,...
        '  begin\n',...
        sprintf('    if (%s == %d) begin\n',ResetName,this.ForceResetValue),...
        '      ',enable,' <= 0;\n'];


        hdlbody=[hdlbody,...
        '    end \n',...
        '    else begin \n',...
        '      if (',enableCondition,') begin \n',...
        '        ',enable,' <= 1;\n',...
        '       end\n',...
        '     end\n',...
        '  end //',processName,'\n'];
    else
        counterCondition=sprintf('%s == 1 & %s < %d',rdenb,counter,delay-1);
        enableCondition=sprintf('%s == 1 & %s == %d',rdenb,counter,delay-1);
        hdlbody=[hdlbody,...
        clk_str,...
        '  begin\n',...
        sprintf('    if (%s == %d) begin\n',ResetName,this.ForceResetValue),...
        '      ',enable,' <= 0;\n',...
        '      ',counter,' <= 0;\n'];


        hdlbody=[hdlbody,...
        '    end \n',...
        '    else begin \n',...
        '      if (',counterCondition,') begin \n',...
        '        ',counter,' <= ',counter,' + 1;\n',...
        '       end\n',...
        '      if (',enableCondition,') begin \n',...
        '        ',enable,' <= 1;\n',...
        '       end\n',...
        '     end\n',...
        '  end //',processName,'\n'];

    end