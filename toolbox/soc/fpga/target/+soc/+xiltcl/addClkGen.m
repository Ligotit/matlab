function addClkGen(fid,hbuild)










    clk_type='single';
    if~isempty(hbuild.PS7)
        source_clk.source=hbuild.PS7.ClockOutputPort;
        source_clk.freq=num2str(hbuild.PS7.ClockOutputFrequency,'%6.10f');
    elseif~isempty(hbuild.MemPL)
        source_clk=hbuild.MemPLClk;
    else
        source_clk=hbuild.InputClk;
        clk_type=hbuild.InputClk.type;
    end


    ip_name='clkgen';
    soc.xiltcl.addInstance(fid,ip_name,'xilinx.com:ip:clk_wiz:6.0');
    if strcmpi(clk_type,'diff')
        soc.xiltcl.setInstance(fid,ip_name,{...
        'PRIM_SOURCE','Differential_clock_capable_pin',...
        });
        soc.xiltcl.addConnections(fid,{source_clk.source,[ip_name,'/clk_in1_d']});
    else
        soc.xiltcl.addConnections(fid,{source_clk.source,[ip_name,'/clk_in1']});
    end

    gen_ipcore_clk=startsWith(hbuild.IPCoreClk.source,'clkgen');

    gen_memps_clk=startsWith(hbuild.MemPSClk.source,'clkgen');

    if gen_ipcore_clk&&gen_memps_clk
        soc.xiltcl.setInstance(fid,ip_name,{...
        'CLKOUT2_USED','true',...
        'CLKOUT3_USED','true',...
        'USE_LOCKED','false',...
        'USE_RESET','false',...
        'PRIM_IN_FREQ',source_clk.freq,...
        'CLKOUT1_REQUESTED_OUT_FREQ',hbuild.SystemClk.freq,...
        'CLKOUT2_REQUESTED_OUT_FREQ',hbuild.IPCoreClk.freq,...
        'CLKOUT3_REQUESTED_OUT_FREQ',hbuild.MemPSClk.freq,...
        });
    elseif gen_ipcore_clk&&~gen_memps_clk
        soc.xiltcl.setInstance(fid,ip_name,{...
        'CLKOUT2_USED','true',...
        'USE_LOCKED','false',...
        'USE_RESET','false',...
        'PRIM_IN_FREQ',source_clk.freq,...
        'CLKOUT1_REQUESTED_OUT_FREQ',hbuild.SystemClk.freq,...
        'CLKOUT2_REQUESTED_OUT_FREQ',hbuild.IPCoreClk.freq,...
        });
    elseif~gen_ipcore_clk&&gen_memps_clk
        soc.xiltcl.setInstance(fid,ip_name,{...
        'CLKOUT2_USED','true',...
        'USE_LOCKED','false',...
        'USE_RESET','false',...
        'PRIM_IN_FREQ',source_clk.freq,...
        'CLKOUT1_REQUESTED_OUT_FREQ',hbuild.SystemClk.freq,...
        'CLKOUT2_REQUESTED_OUT_FREQ',hbuild.MemPSClk.freq,...
        });
    else
        soc.xiltcl.setInstance(fid,ip_name,{...
        'USE_LOCKED','false',...
        'USE_RESET','false',...
        'PRIM_IN_FREQ',source_clk.freq,...
        'CLKOUT1_REQUESTED_OUT_FREQ',hbuild.SystemClk.freq,...
        });
    end