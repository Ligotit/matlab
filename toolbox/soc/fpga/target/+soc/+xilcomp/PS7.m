classdef PS7<soc.xilcomp.XilinxComponentBase

    properties
        ClockOutputPort='';
        ClockOutputFrequency=100;
        ResetOutputPort='';
    end

    methods
        function obj=PS7(varargin)

            obj.Configuration={...
            'board_name','Xilinx Zynq ZC706 evaluation kit',...
            'memPS_addr','0x00000000',...
            'memPS_range','0',...
            'fclk0_freq','100'
            };

            if nargin>0
                obj.Configuration=varargin;
            end

            if~strcmpi(obj.Configuration.board_name,'Xilinx Zynq UltraScale+ MPSoC ZCU102 Evaluation Kit')
                obj.addAXI4Master('processing_system7/M_AXI_GP0','reg','sys');
                if str2double(obj.Configuration.hasMemPS)
                    obj.addAXI4Slave('processing_system7/S_AXI_HP0','memPS','memPS',obj.Configuration.memPS_addr,obj.Configuration.memPS_range);
                    obj.addClk({'processing_system7/S_AXI_HP0_ACLK',},'MemPSClk');
                    enableHP0='1';
                else
                    enableHP0='0';
                end
                if str2double(obj.Configuration.hasHDMI)
                    obj.addAXI4Slave('processing_system7/S_AXI_HP1','memPS','memPS',obj.Configuration.memPS_addr,obj.Configuration.memPS_range);
                    obj.addClk({'processing_system7/S_AXI_HP1_ACLK',},'MemPSClk');
                    enableHP1='1';
                else
                    enableHP1='0';
                end
                switch obj.Configuration.board_name
                case 'Xilinx Zynq ZC706 evaluation kit'
                    preset='zc706';
                case 'ZedBoard'
                    preset='zedboard';
                end
                obj.ClockOutputPort='processing_system7/FCLK_CLK0';
                obj.ClockOutputFrequency=100;
                obj.ResetOutputPort='processing_system7/FCLK_RESET0_N';
                obj.Instance=['set processing_system7 [create_bd_cell -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7]\n',...
                'set_property -dict [list CONFIG.preset {',preset,'}',...
                ' CONFIG.PCW_EN_CLK0_PORT {1}',...
                ' CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {',obj.Configuration.fclk0_freq,'}',...
                ' CONFIG.PCW_EN_RST0_PORT {1}',...
                ' CONFIG.PCW_USE_S_AXI_HP0 {',enableHP0,'}',...
                ' CONFIG.PCW_USE_S_AXI_HP1 {',enableHP1,'}',...
                '] $processing_system7\n',...
                'create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR\n',...
                'connect_bd_intf_net [get_bd_intf_pins processing_system7/DDR] [get_bd_intf_ports DDR]\n',...
                'create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO\n',...
                'connect_bd_intf_net [get_bd_intf_pins processing_system7/FIXED_IO] [get_bd_intf_ports FIXED_IO]\n',...
                ];

                obj.InstancePost='hsb_connect clkgen/clk_out1 processing_system7/M_AXI_GP0_ACLK\n';
            else
                obj.addAXI4Master('zynq_ultra_ps/M_AXI_HPM0_FPD','reg','sys');
                if str2double(obj.Configuration.hasMemPS)
                    obj.addAXI4Slave('zynq_ultra_ps/S_AXI_HP0_FPD','memPS','memPS',obj.Configuration.memPS_addr,obj.Configuration.memPS_range);
                    obj.addClk({'zynq_ultra_ps/saxihp0_fpd_aclk',},'MemPSClk');
                    enableHP0='1';
                else
                    enableHP0='0';
                end
                obj.ClockOutputPort='zynq_ultra_ps/pl_clk0';
                obj.ClockOutputFrequency=99.999001;
                obj.ResetOutputPort='zynq_ultra_ps/pl_resetn0';
                obj.Instance=[...
                'set zynq_ultra_ps [ create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.3 zynq_ultra_ps ]\n',...
                'set_property -dict [ list \\\n',...
                'CONFIG.PSU_BANK_0_IO_STANDARD {LVCMOS18} \\\n',...
                'CONFIG.PSU_BANK_1_IO_STANDARD {LVCMOS18} \\\n',...
                'CONFIG.PSU_BANK_2_IO_STANDARD {LVCMOS18} \\\n',...
                'CONFIG.PSU__CAN1__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__CAN1__PERIPHERAL__IO {MIO 24 .. 25} \\\n',...
                'CONFIG.PSU__CRF_APB__ACPU_CTRL__FREQMHZ {1200} \\\n',...
                'CONFIG.PSU__CRF_APB__ACPU_CTRL__SRCSEL {APLL} \\\n',...
                'CONFIG.PSU__CRF_APB__APLL_CTRL__SRCSEL {PSS_REF_CLK} \\\n',...
                'CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRF_APB__DBG_FPD_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRF_APB__DBG_TRACE_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRF_APB__DBG_TSTMP_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DDR_CTRL__FREQMHZ {1067} \\\n',...
                'CONFIG.PSU__CRF_APB__DDR_CTRL__SRCSEL {DPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__FREQMHZ {600} \\\n',...
                'CONFIG.PSU__CRF_APB__DPDMA_REF_CTRL__SRCSEL {APLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DPLL_CTRL__SRCSEL {PSS_REF_CLK} \\\n',...
                'CONFIG.PSU__CRF_APB__DP_AUDIO_REF_CTRL__SRCSEL {RPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DP_STC_REF_CTRL__SRCSEL {RPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__DP_VIDEO_REF_CTRL__SRCSEL {VPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__FREQMHZ {600} \\\n',...
                'CONFIG.PSU__CRF_APB__GDMA_REF_CTRL__SRCSEL {APLL} \\\n',...
                'CONFIG.PSU__CRF_APB__GPU_REF_CTRL__FREQMHZ {500} \\\n',...
                'CONFIG.PSU__CRF_APB__GPU_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRF_APB__PCIE_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__SATA_REF_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRF_APB__SATA_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRF_APB__TOPSW_LSBUS_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__FREQMHZ {533.33} \\\n',...
                'CONFIG.PSU__CRF_APB__TOPSW_MAIN_CTRL__SRCSEL {DPLL} \\\n',...
                'CONFIG.PSU__CRF_APB__VPLL_CTRL__SRCSEL {PSS_REF_CLK} \\\n',...
                'CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__FREQMHZ {500} \\\n',...
                'CONFIG.PSU__CRL_APB__ADMA_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__CAN1_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__CPU_R5_CTRL__FREQMHZ {500} \\\n',...
                'CONFIG.PSU__CRL_APB__CPU_R5_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRL_APB__DBG_LPD_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__FREQMHZ {125} \\\n',...
                'CONFIG.PSU__CRL_APB__GEM3_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__I2C0_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__I2C1_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__IOPLL_CTRL__SRCSEL {PSS_REF_CLK} \\\n',...
                'CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRL_APB__IOU_SWITCH_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__LPD_LSBUS_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__FREQMHZ {500} \\\n',...
                'CONFIG.PSU__CRL_APB__LPD_SWITCH_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__PCAP_CTRL__FREQMHZ {200} \\\n',...
                'CONFIG.PSU__CRL_APB__PCAP_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__PL0_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__PL0_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__FREQMHZ {125} \\\n',...
                'CONFIG.PSU__CRL_APB__QSPI_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__RPLL_CTRL__SRCSEL {PSS_REF_CLK} \\\n',...
                'CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__FREQMHZ {200} \\\n',...
                'CONFIG.PSU__CRL_APB__SDIO1_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__TIMESTAMP_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__UART0_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__UART0_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__UART1_REF_CTRL__FREQMHZ {100} \\\n',...
                'CONFIG.PSU__CRL_APB__UART1_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__FREQMHZ {250} \\\n',...
                'CONFIG.PSU__CRL_APB__USB0_BUS_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__FREQMHZ {20} \\\n',...
                'CONFIG.PSU__CRL_APB__USB3_DUAL_REF_CTRL__SRCSEL {IOPLL} \\\n',...
                'CONFIG.PSU__DDRC__BANK_ADDR_COUNT {2} \\\n',...
                'CONFIG.PSU__DDRC__BG_ADDR_COUNT {2} \\\n',...
                'CONFIG.PSU__DDRC__BRC_MAPPING {ROW_BANK_COL} \\\n',...
                'CONFIG.PSU__DDRC__BUS_WIDTH {64 Bit} \\\n',...
                'CONFIG.PSU__DDRC__CL {15} \\\n',...
                'CONFIG.PSU__DDRC__CLOCK_STOP_EN {0} \\\n',...
                'CONFIG.PSU__DDRC__COL_ADDR_COUNT {10} \\\n',...
                'CONFIG.PSU__DDRC__COMPONENTS {UDIMM} \\\n',...
                'CONFIG.PSU__DDRC__CWL {14} \\\n',...
                'CONFIG.PSU__DDRC__DDR4_ADDR_MAPPING {0} \\\n',...
                'CONFIG.PSU__DDRC__DDR4_CAL_MODE_ENABLE {0} \\\n',...
                'CONFIG.PSU__DDRC__DDR4_CRC_CONTROL {0} \\\n',...
                'CONFIG.PSU__DDRC__DDR4_T_REF_MODE {0} \\\n',...
                'CONFIG.PSU__DDRC__DDR4_T_REF_RANGE {Normal (0-85)} \\\n',...
                'CONFIG.PSU__DDRC__DEVICE_CAPACITY {4096 MBits} \\\n',...
                'CONFIG.PSU__DDRC__DIMM_ADDR_MIRROR {0} \\\n',...
                'CONFIG.PSU__DDRC__DM_DBI {DM_NO_DBI} \\\n',...
                'CONFIG.PSU__DDRC__DRAM_WIDTH {8 Bits} \\\n',...
                'CONFIG.PSU__DDRC__ECC {Disabled} \\\n',...
                'CONFIG.PSU__DDRC__FGRM {1X} \\\n',...
                'CONFIG.PSU__DDRC__LP_ASR {manual normal} \\\n',...
                'CONFIG.PSU__DDRC__MEMORY_TYPE {DDR 4} \\\n',...
                'CONFIG.PSU__DDRC__PARITY_ENABLE {0} \\\n',...
                'CONFIG.PSU__DDRC__PER_BANK_REFRESH {0} \\\n',...
                'CONFIG.PSU__DDRC__PHY_DBI_MODE {0} \\\n',...
                'CONFIG.PSU__DDRC__RANK_ADDR_COUNT {0} \\\n',...
                'CONFIG.PSU__DDRC__ROW_ADDR_COUNT {15} \\\n',...
                'CONFIG.PSU__DDRC__SELF_REF_ABORT {0} \\\n',...
                'CONFIG.PSU__DDRC__SPEED_BIN {DDR4_2133P} \\\n',...
                'CONFIG.PSU__DDRC__STATIC_RD_MODE {0} \\\n',...
                'CONFIG.PSU__DDRC__TRAIN_DATA_EYE {1} \\\n',...
                'CONFIG.PSU__DDRC__TRAIN_READ_GATE {1} \\\n',...
                'CONFIG.PSU__DDRC__TRAIN_WRITE_LEVEL {1} \\\n',...
                'CONFIG.PSU__DDRC__T_FAW {30.0} \\\n',...
                'CONFIG.PSU__DDRC__T_RAS_MIN {33} \\\n',...
                'CONFIG.PSU__DDRC__T_RC {47.06} \\\n',...
                'CONFIG.PSU__DDRC__T_RCD {15} \\\n',...
                'CONFIG.PSU__DDRC__T_RP {15} \\\n',...
                'CONFIG.PSU__DDRC__VREF {1} \\\n',...
                'CONFIG.PSU__DISPLAYPORT__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__DPAUX__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__DPAUX__PERIPHERAL__IO {MIO 27 .. 30} \\\n',...
                'CONFIG.PSU__DP__LANE_SEL {Single Lower} \\\n',...
                'CONFIG.PSU__DP__REF_CLK_FREQ {27} \\\n',...
                'CONFIG.PSU__DP__REF_CLK_SEL {Ref Clk3} \\\n',...
                'CONFIG.PSU__ENET3__GRP_MDIO__ENABLE {1} \\\n',...
                'CONFIG.PSU__ENET3__GRP_MDIO__IO {MIO 76 .. 77} \\\n',...
                'CONFIG.PSU__ENET3__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__ENET3__PERIPHERAL__IO {MIO 64 .. 75} \\\n',...
                'CONFIG.PSU__FPGA_PL0_ENABLE {1} \\\n',...
                'CONFIG.PSU__GPIO0_MIO__IO {MIO 0 .. 25} \\\n',...
                'CONFIG.PSU__GPIO0_MIO__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__GPIO1_MIO__IO {MIO 26 .. 51} \\\n',...
                'CONFIG.PSU__GPIO1_MIO__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__I2C0__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__I2C0__PERIPHERAL__IO {MIO 14 .. 15} \\\n',...
                'CONFIG.PSU__I2C1__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__I2C1__PERIPHERAL__IO {MIO 16 .. 17} \\\n',...
                'CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC0_SEL {APB} \\\n',...
                'CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC1_SEL {APB} \\\n',...
                'CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC2_SEL {APB} \\\n',...
                'CONFIG.PSU__IOU_SLCR__IOU_TTC_APB_CLK__TTC3_SEL {APB} \\\n',...
                'CONFIG.PSU__OVERRIDE__BASIC_CLOCK {0} \\\n',...
                'CONFIG.PSU__PCIE__BAR0_ENABLE {0} \\\n',...
                'CONFIG.PSU__PCIE__CLASS_CODE_BASE {0x06} \\\n',...
                'CONFIG.PSU__PCIE__CLASS_CODE_SUB {0x4} \\\n',...
                'CONFIG.PSU__PCIE__CRS_SW_VISIBILITY {1} \\\n',...
                'CONFIG.PSU__PCIE__DEVICE_ID {0xD021} \\\n',...
                'CONFIG.PSU__PCIE__DEVICE_PORT_TYPE {Root Port} \\\n',...
                'CONFIG.PSU__PCIE__LANE1__ENABLE {0} \\\n',...
                'CONFIG.PSU__PCIE__LINK_SPEED {5.0 Gb/s} \\\n',...
                'CONFIG.PSU__PCIE__MAXIMUM_LINK_WIDTH {x1} \\\n',...
                'CONFIG.PSU__PCIE__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__PCIE__PERIPHERAL__ROOTPORT_IO {MIO 31} \\\n',...
                'CONFIG.PSU__PCIE__REF_CLK_FREQ {100} \\\n',...
                'CONFIG.PSU__PCIE__REF_CLK_SEL {Ref Clk0} \\\n',...
                'CONFIG.PSU__PMU__GPI0__ENABLE {0} \\\n',...
                'CONFIG.PSU__PMU__GPI1__ENABLE {0} \\\n',...
                'CONFIG.PSU__PMU__GPI2__ENABLE {0} \\\n',...
                'CONFIG.PSU__PMU__GPI3__ENABLE {0} \\\n',...
                'CONFIG.PSU__PMU__GPI4__ENABLE {0} \\\n',...
                'CONFIG.PSU__PMU__GPI5__ENABLE {0} \\\n',...
                'CONFIG.PSU__PMU__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__PSS_REF_CLK__FREQMHZ {33.333} \\\n',...
                'CONFIG.PSU__QSPI__GRP_FBCLK__ENABLE {1} \\\n',...
                'CONFIG.PSU__QSPI__GRP_FBCLK__IO {MIO 6} \\\n',...
                'CONFIG.PSU__QSPI__PERIPHERAL__DATA_MODE {x4} \\\n',...
                'CONFIG.PSU__QSPI__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__QSPI__PERIPHERAL__IO {MIO 0 .. 12} \\\n',...
                'CONFIG.PSU__QSPI__PERIPHERAL__MODE {Dual Parallel} \\\n',...
                'CONFIG.PSU__SATA__LANE1__ENABLE {1} \\\n',...
                'CONFIG.PSU__SATA__LANE1__IO {GT Lane3} \\\n',...
                'CONFIG.PSU__SATA__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__SATA__REF_CLK_FREQ {125} \\\n',...
                'CONFIG.PSU__SATA__REF_CLK_SEL {Ref Clk1} \\\n',...
                'CONFIG.PSU__SD1__DATA_TRANSFER_MODE {8Bit} \\\n',...
                'CONFIG.PSU__SD1__GRP_CD__ENABLE {1} \\\n',...
                'CONFIG.PSU__SD1__GRP_CD__IO {MIO 45} \\\n',...
                'CONFIG.PSU__SD1__GRP_POW__ENABLE {1} \\\n',...
                'CONFIG.PSU__SD1__GRP_POW__IO {MIO 43} \\\n',...
                'CONFIG.PSU__SD1__GRP_WP__ENABLE {1} \\\n',...
                'CONFIG.PSU__SD1__GRP_WP__IO {MIO 44} \\\n',...
                'CONFIG.PSU__SD1__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__SD1__PERIPHERAL__IO {MIO 39 .. 51} \\\n',...
                'CONFIG.PSU__SD1__SLOT_TYPE {SD 3.0} \\\n',...
                'CONFIG.PSU__SWDT0__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__SWDT1__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__TTC0__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__TTC1__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__TTC2__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__TTC3__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__UART0__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__UART0__PERIPHERAL__IO {MIO 18 .. 19} \\\n',...
                'CONFIG.PSU__UART1__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__UART1__PERIPHERAL__IO {MIO 20 .. 21} \\\n',...
                'CONFIG.PSU__USB0__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__USB0__PERIPHERAL__IO {MIO 52 .. 63} \\\n',...
                'CONFIG.PSU__USB0__REF_CLK_FREQ {26} \\\n',...
                'CONFIG.PSU__USB0__REF_CLK_SEL {Ref Clk2} \\\n',...
                'CONFIG.PSU__USB3_0__PERIPHERAL__ENABLE {1} \\\n',...
                'CONFIG.PSU__USB3_0__PERIPHERAL__IO {GT Lane2} \\\n',...
                'CONFIG.PSU__USE__IRQ0 {0} \\\n',...
                'CONFIG.PSU__USE__M_AXI_GP0 {1} \\\n',...
                'CONFIG.PSU__USE__M_AXI_GP1 {0} \\\n',...
                'CONFIG.PSU__USE__M_AXI_GP2 {0} \\\n',...
                'CONFIG.PSU__USE__S_AXI_ACP {0} \\\n',...
                'CONFIG.PSU__USE__S_AXI_GP2 {',enableHP0,'} \\\n',...
                'CONFIG.PSU__USE__S_AXI_GP3 {0} \\\n',...
                ' ] $zynq_ultra_ps\n',...
                ];
                obj.InstancePost='hsb_connect clkgen/clk_out1 zynq_ultra_ps/maxihpm0_fpd_aclk\n';
            end

        end
    end

end