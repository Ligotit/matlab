classdef Virtex6<eda.fpga.Xilinx





    methods
        function this=Virtex6(varargin)
            this.FPGAVendor='Xilinx';
            this.FPGAFamily='Virtex6';
            this.minDCMFreq=0.5;
            this.maxDCMFreq=666.667;
            this.SynthesisFrequency='100MHz';
            if~isempty(varargin)
                arg=this.componentArg(varargin);
                this.FPGADevice=arg.Device;
                this.FPGASpeed=arg.Speed;
                this.FPGAPackage=arg.Package;
                if isfield(arg,'Frequency')
                    this.SynthesisFrequency=arg.Frequency;
                end
            end
        end

        function hC=ClkMgr_GMII(this,SYSCLK,SynthFreq,varargin)
            if nargin<=3
                hC=eda.internal.component.WhiteBox(...
                {'CLK_IN','INPUT','ClockPort',...
                'RESET_IN','INPUT','boolean',...
                'RXCLK_IN','INPUT','boolean',...
                'DUTCLK','OUTPUT','boolean',...
                'MACRXCLK','OUTPUT','boolean',...
                'MACTXCLK','OUTPUT','boolean',...
                'TXCLK','OUTPUT','boolean',...
                'RESET_OUT','OUTPUT','boolean'});
            else
                hC=eda.internal.component.WhiteBox(...
                {'CLK_IN','INPUT','ClockPort',...
                'CLK_OUT','OUTPUT','boolean',...
                'RESET_IN','INPUT','boolean',...
                'RXCLK_IN','INPUT','boolean',...
                'DUTCLK','OUTPUT','boolean',...
                'MACRXCLK','OUTPUT','boolean',...
                'MACTXCLK','OUTPUT','boolean',...
                'TXCLK','OUTPUT','boolean',...
                'RESET_OUT','OUTPUT','boolean'});
            end

            hC.Partition.Device.PartInfo.FPGAVendor='Xilinx';
            hC.UniqueName='MWClkMgr';
            hC.addprop('enableCodeGen');
            hC.flatten=false;

            clk0=hC.signal('Name','clk0','FiType','boolean');
            clkfb0=hC.signal('Name','clkfb0','FiType','boolean');
            clk125=hC.signal('Name','clk125','FiType','boolean');
            dcmclk125=hC.signal('Name','CLKFX','FiType','boolean');
            LOCKED=hC.signal('Name','LOCKED','FiType','boolean');
            rxClk_internal=hC.signal('Name','rxClk_internal','FiType','boolean');
            notLocked=hC.signal('Name','notLocked','FiType','boolean');




            Clkfbout_mult_f=max(5,round(1000/SYSCLK.Frequency));
            Clkfbout_mult_f=min(64,Clkfbout_mult_f);


            Clkout0_divide_f=SYSCLK.Frequency*Clkfbout_mult_f/125;



            Clkout1_divide=round(SYSCLK.Frequency*Clkfbout_mult_f/SynthFreq);
            if Clkout1_divide>128
                Clkout1_divide=128;
            elseif Clkout1_divide<1
                Clkout1_divide=1;
            end


            Clkfbout_mult_f=sprintf('%5.3f',Clkfbout_mult_f);
            Clkout0_divide_f=sprintf('%5.3f',Clkout0_divide_f);
            Clkout1_divide=num2str(Clkout1_divide);

            clkPeriod=sprintf('%5.3f',1000./SYSCLK.Frequency);
            CLKDV=hC.signal('Name','CLKDV','FiType','boolean');

            dcm=hC.component(...
            'UniqueName','MMCM_BASE',...
            'InstName','dcm',...
            'Component',eda.internal.component.BlackBox({...
            'CLKFBOUT','OUTPUT','boolean',...
            'CLKFBOUTB','OUTPUT','boolean',...
            'CLKOUT0','OUTPUT','boolean',...
            'CLKOUT0B','OUTPUT','boolean',...
            'CLKOUT1','OUTPUT','boolean',...
            'CLKOUT1B','OUTPUT','boolean',...
            'CLKOUT2','OUTPUT','boolean',...
            'CLKOUT2B','OUTPUT','boolean',...
            'CLKOUT3','OUTPUT','boolean',...
            'CLKOUT3B','OUTPUT','boolean',...
            'CLKOUT4','OUTPUT','boolean',...
            'CLKOUT5','OUTPUT','boolean',...
            'CLKOUT6','OUTPUT','boolean',...
            'CLKFBIN','INPUT','boolean',...
            'CLKIN1','INPUT','boolean',...
            'LOCKED','OUTPUT','boolean',...
            'PWRDWN','INPUT','boolean',...
            'RST','INPUT','boolean'}),...
            'CLKFBOUT',clk0,...
            'CLKFBOUTB','OPEN',...
            'CLKOUT0',dcmclk125,...
            'CLKOUT0B','OPEN',...
            'CLKOUT1',CLKDV,...
            'CLKOUT1B','OPEN',...
            'CLKOUT2','OPEN',...
            'CLKOUT2B','OPEN',...
            'CLKOUT3','OPEN',...
            'CLKOUT3B','OPEN',...
            'CLKOUT4','OPEN',...
            'CLKOUT5','OPEN',...
            'CLKOUT6','OPEN',...
            'CLKFBIN',clkfb0,...
            'CLKIN1',hC.CLK_IN,...
            'LOCKED',LOCKED,...
            'PWRDWN','LOW',...
            'RST',hC.RESET_IN);

            dcm.addprop('generic');

            dcm.generic=generics(...
            'BANDWIDTH','string','"OPTIMIZED"',...
            'CLOCK_HOLD','boolean','FALSE',...
            'STARTUP_WAIT','boolean','FALSE',...
            'DIVCLK_DIVIDE','integer','1',...
            'CLKFBOUT_MULT_F','double',Clkfbout_mult_f,...
            'CLKFBOUT_PHASE','double','0.000',...
            'CLKOUT0_DIVIDE_F','double',Clkout0_divide_f,...
            'CLKOUT0_PHASE','double','0.000',...
            'CLKOUT0_DUTY_CYCLE','double','0.500',...
            'CLKOUT1_DIVIDE','integer',Clkout1_divide,...
            'CLKOUT1_PHASE','double','0.000',...
            'CLKOUT1_DUTY_CYCLE','double','0.500',...
            'CLKIN1_PERIOD','double',clkPeriod,...
            'REF_JITTER1','double','0.010');

            dcm.addprop('NoHDLFiles');
            dcm.addprop('compDeclNotNeeded');
            dcm.addprop('wrapperFileNotNeeded');

            this.bufg(hC,clk0,clkfb0);
            this.bufg(hC,dcmclk125,clk125);
            this.bufg(hC,CLKDV,hC.DUTCLK);


            hC.assign(' ~ LOCKED',notLocked);
            hC.assign(notLocked,hC.RESET_OUT);

            hC.assign(clk125,hC.MACTXCLK);
            hC.assign(hC.RXCLK_IN,rxClk_internal);
            hC.assign(rxClk_internal,hC.MACRXCLK);
            this.oddr(hC,clk125,'HIGH','LOW','HIGH',hC.TXCLK,'LOW','LOW');
            if nargin>3
                hC.assign(clkfb0,hC.CLK_OUT);
            end
        end

        function hC=ClkMgr_PCIe(this,SYSCLK,SynthFreq)
            InputFreq=SYSCLK.Frequency;
            hC=eda.internal.component.WhiteBox(...
            {'CLK_IN','INPUT','ClockPort',...
            'RESET_IN','INPUT','boolean',...
            'DUTCLK','OUTPUT','boolean',...
            'RESET_OUT','OUTPUT','boolean'});

            hC.Partition.Device.PartInfo.FPGAVendor='Xilinx';
            hC.UniqueName='MWClkMgr';
            hC.addprop('enableCodeGen');
            hC.flatten=false;

            clk0=hC.signal('Name','clk0','FiType','boolean');
            clkfb0=hC.signal('Name','clkfb0','FiType','boolean');
            clk125=hC.signal('Name','clk125','FiType','boolean');
            dcmclk125=hC.signal('Name','CLKFX','FiType','boolean');
            LOCKED=hC.signal('Name','LOCKED','FiType','boolean');
            notLocked=hC.signal('Name','notLocked','FiType','boolean');




            Clkfbout_mult_f=max(5,round(1000/InputFreq));
            Clkfbout_mult_f=min(64,Clkfbout_mult_f);


            Clkout0_divide_f=InputFreq*Clkfbout_mult_f/125;



            Clkout1_divide=round(InputFreq*Clkfbout_mult_f/SynthFreq);
            if Clkout1_divide>128
                Clkout1_divide=128;
            elseif Clkout1_divide<1
                Clkout1_divide=1;
            end


            Clkfbout_mult_f=sprintf('%5.3f',Clkfbout_mult_f);
            Clkout0_divide_f=sprintf('%5.3f',Clkout0_divide_f);
            Clkout1_divide=num2str(Clkout1_divide);

            clkPeriod=sprintf('%5.3f',1000./InputFreq);
            CLKDV=hC.signal('Name','CLKDV','FiType','boolean');

            dcm=hC.component(...
            'UniqueName','MMCM_BASE',...
            'InstName','dcm',...
            'Component',eda.internal.component.BlackBox({...
            'CLKFBOUT','OUTPUT','boolean',...
            'CLKFBOUTB','OUTPUT','boolean',...
            'CLKOUT0','OUTPUT','boolean',...
            'CLKOUT0B','OUTPUT','boolean',...
            'CLKOUT1','OUTPUT','boolean',...
            'CLKOUT1B','OUTPUT','boolean',...
            'CLKOUT2','OUTPUT','boolean',...
            'CLKOUT2B','OUTPUT','boolean',...
            'CLKOUT3','OUTPUT','boolean',...
            'CLKOUT3B','OUTPUT','boolean',...
            'CLKOUT4','OUTPUT','boolean',...
            'CLKOUT5','OUTPUT','boolean',...
            'CLKOUT6','OUTPUT','boolean',...
            'CLKFBIN','INPUT','boolean',...
            'CLKIN1','INPUT','boolean',...
            'LOCKED','OUTPUT','boolean',...
            'PWRDWN','INPUT','boolean',...
            'RST','INPUT','boolean'}),...
            'CLKFBOUT',clk0,...
            'CLKFBOUTB','OPEN',...
            'CLKOUT0',dcmclk125,...
            'CLKOUT0B','OPEN',...
            'CLKOUT1',CLKDV,...
            'CLKOUT1B','OPEN',...
            'CLKOUT2','OPEN',...
            'CLKOUT2B','OPEN',...
            'CLKOUT3','OPEN',...
            'CLKOUT3B','OPEN',...
            'CLKOUT4','OPEN',...
            'CLKOUT5','OPEN',...
            'CLKOUT6','OPEN',...
            'CLKFBIN',clkfb0,...
            'CLKIN1',hC.CLK_IN,...
            'LOCKED',LOCKED,...
            'PWRDWN','LOW',...
            'RST',hC.RESET_IN);

            dcm.addprop('generic');

            dcm.generic=generics(...
            'BANDWIDTH','string','"OPTIMIZED"',...
            'CLOCK_HOLD','boolean','FALSE',...
            'STARTUP_WAIT','boolean','FALSE',...
            'DIVCLK_DIVIDE','integer','1',...
            'CLKFBOUT_MULT_F','double',Clkfbout_mult_f,...
            'CLKFBOUT_PHASE','double','0.000',...
            'CLKOUT0_DIVIDE_F','double',Clkout0_divide_f,...
            'CLKOUT0_PHASE','double','0.000',...
            'CLKOUT0_DUTY_CYCLE','double','0.500',...
            'CLKOUT1_DIVIDE','integer',Clkout1_divide,...
            'CLKOUT1_PHASE','double','0.000',...
            'CLKOUT1_DUTY_CYCLE','double','0.500',...
            'CLKIN1_PERIOD','double',clkPeriod,...
            'REF_JITTER1','double','0.010');

            dcm.addprop('NoHDLFiles');
            dcm.addprop('compDeclNotNeeded');
            dcm.addprop('wrapperFileNotNeeded');

            this.bufg(hC,clk0,clkfb0);
            this.bufg(hC,dcmclk125,clk125);
            this.bufg(hC,CLKDV,hC.DUTCLK);


            hC.assign(' ~ LOCKED',notLocked);
            hC.assign(notLocked,hC.RESET_OUT);

        end

        function hC=ClkMgr_MII(this,SYSCLK,SynthFreq)

            hC=eda.internal.component.WhiteBox(...
            {'RESET_IN','INPUT','boolean',...
            'CLK_IN','INPUT','boolean',...
            'TXCLK_IN','INPUT','boolean',...
            'RXCLK_IN','INPUT','boolean',...
            'TXCLK_OUT','OUTPUT','boolean',...
            'RXCLK_OUT','OUTPUT','boolean',...
            'DUTCLK','OUTPUT','boolean',...
            'CLK25','OUTPUT','boolean',...
            'RESET_OUT','OUTPUT','boolean'});

            hC.Partition.Device.PartInfo.FPGAVendor='Xilinx';
            hC.UniqueName='MWClkMgr';
            hC.addprop('enableCodeGen');
            hC.flatten=false;

            InClkFreq=SYSCLK.Frequency;
            clkPeriod=sprintf('%5.3f',1000/InClkFreq);



            CLKFBOUT_MULT=max(5,round(1000/InClkFreq));
            CLKFBOUT_MULT=min(64,CLKFBOUT_MULT);
            ClkFbFreq=InClkFreq*CLKFBOUT_MULT;

            DIV=round(ClkFbFreq./SynthFreq);

            DIV=min(DIV,128);
            DIV=max(1,DIV);

            DIV25=round(ClkFbFreq/25);
            DIV25=min(DIV25,128);
            DIV25=max(1,DIV25);


            DIV=sprintf('%5.3f',DIV);
            DIV25=num2str(DIV25);
            CLKFBOUT_MULT=sprintf('%5.3f',CLKFBOUT_MULT);

            clk0=hC.signal('Name','clk0','FiType','boolean');
            clkfb0=hC.signal('Name','clkfb0','FiType','boolean');
            LOCKED=hC.signal('Name','LOCKED','FiType','boolean');
            notLocked=hC.signal('Name','notLocked','FiType','boolean');

            dcm=hC.component(...
            'UniqueName','MMCM_BASE',...
            'InstName','dcm',...
            'Component',eda.internal.component.BlackBox({...
            'CLKFBOUT','OUTPUT','boolean',...
            'CLKFBOUTB','OUTPUT','boolean',...
            'CLKOUT0','OUTPUT','boolean',...
            'CLKOUT0B','OUTPUT','boolean',...
            'CLKOUT1','OUTPUT','boolean',...
            'CLKOUT1B','OUTPUT','boolean',...
            'CLKOUT2','OUTPUT','boolean',...
            'CLKOUT2B','OUTPUT','boolean',...
            'CLKOUT3','OUTPUT','boolean',...
            'CLKOUT3B','OUTPUT','boolean',...
            'CLKOUT4','OUTPUT','boolean',...
            'CLKOUT5','OUTPUT','boolean',...
            'CLKOUT6','OUTPUT','boolean',...
            'CLKFBIN','INPUT','boolean',...
            'CLKIN1','INPUT','boolean',...
            'LOCKED','OUTPUT','boolean',...
            'PWRDWN','INPUT','boolean',...
            'RST','INPUT','boolean'}),...
            'CLKFBOUT',clk0,...
            'CLKFBOUTB','OPEN',...
            'CLKOUT0',hC.DUTCLK,...
            'CLKOUT0B','OPEN',...
            'CLKOUT1',hC.CLK25,...
            'CLKOUT1B','OPEN',...
            'CLKOUT2','OPEN',...
            'CLKOUT2B','OPEN',...
            'CLKOUT3','OPEN',...
            'CLKOUT3B','OPEN',...
            'CLKOUT4','OPEN',...
            'CLKOUT5','OPEN',...
            'CLKOUT6','OPEN',...
            'CLKFBIN',clkfb0,...
            'CLKIN1',hC.CLK_IN,...
            'LOCKED',LOCKED,...
            'PWRDWN','LOW',...
            'RST',hC.RESET_IN);

            dcm.addprop('generic');

            dcm.generic=generics(...
            'BANDWIDTH','string','"OPTIMIZED"',...
            'CLOCK_HOLD','boolean','FALSE',...
            'STARTUP_WAIT','boolean','FALSE',...
            'DIVCLK_DIVIDE','integer','1',...
            'CLKFBOUT_MULT_F','double',CLKFBOUT_MULT,...
            'CLKFBOUT_PHASE','double','0.000',...
            'CLKOUT0_DIVIDE_F','double',DIV,...
            'CLKOUT0_PHASE','double','0.000',...
            'CLKOUT0_DUTY_CYCLE','double','0.500',...
            'CLKOUT1_DIVIDE','double',DIV25,...
            'CLKOUT1_PHASE','double','0.000',...
            'CLKOUT1_DUTY_CYCLE','double','0.500',...
            'CLKIN1_PERIOD','double',clkPeriod,...
            'REF_JITTER1','double','0.010');

            dcm.addprop('NoHDLFiles');
            dcm.addprop('compDeclNotNeeded');
            dcm.addprop('wrapperFileNotNeeded');

            this.bufg(hC,clk0,clkfb0);


            hC.assign(' ~ LOCKED',notLocked);
            hC.assign(notLocked,hC.RESET_OUT);


            this.ibufg(hC,hC.TXCLK_IN,hC.TXCLK_OUT);
            this.ibufg(hC,hC.RXCLK_IN,hC.RXCLK_OUT);

        end

        function hC=ClkMgr_RGMII(this,SYSCLK,SynthFreq)

            hC=ClkMgr_GMII(this,SYSCLK,SynthFreq);
        end

    end
end