classdef(ConstructOnLoad)MWAPBI2C<eda.internal.component.WhiteBox


    properties

pClk
pResetn
pSel
pEnable
pReady
pAddr
pWrite
pRdata
pWdata
pStrb
pSlvErr

SDA_IN
SDA_OUT
SDA_OE
SCL_IN
SCL_OUT
SCL_OE

status

        generic=generics('baudrate','integer','480000',...
        'clockfreq','integer','25000000',...
        'DATA_SETUP_TIME','integer','25',...
        'DATA_HOLD_TIME','integer','125',...
        'SCL_HIGH','integer','125',...
        'SLV_BASEADDR','std8','"00000100"');

    end

    methods
        function this=MWAPBI2C(varargin)
            this.setGenerics(varargin);
            this.pClk=eda.internal.component.ClockPort;
            this.pResetn=eda.internal.component.ResetPort;
            this.pSel=eda.internal.component.Inport('FiType','boolean');
            this.pEnable=eda.internal.component.Inport('FiType','boolean');
            this.pReady=eda.internal.component.Outport('FiType','boolean');
            this.pAddr=eda.internal.component.Inport('FiType','std32');
            this.pWrite=eda.internal.component.Inport('FiType','boolean');
            this.pWdata=eda.internal.component.Inport('FiType','std32');
            this.pRdata=eda.internal.component.Outport('FiType','std32');
            this.pSlvErr=eda.internal.component.Outport('FiType','boolean');
            this.pStrb=eda.internal.component.Inport('FiType','std4');
            this.status=eda.internal.component.Outport('FiType','boolean');

            this.SDA_IN=eda.internal.component.Inport('FiType','boolean');
            this.SDA_OUT=eda.internal.component.Outport('FiType','boolean');
            this.SCL_IN=eda.internal.component.Inport('FiType','boolean');
            this.SCL_OUT=eda.internal.component.Outport('FiType','boolean');
            this.SDA_OE=eda.internal.component.Outport('FiType','boolean');
            this.SCL_OE=eda.internal.component.Outport('FiType','boolean');
            this.flatten=false;
        end

        function implement(this)
            clear_err=this.signal('Name','clear_err','FiType','boolean');
            iic_rxdata=this.signal('Name','iic_rxdata','FiType','std8');
            iic_rxvld=this.signal('Name','iic_rxvld','FiType','boolean');
            iic_txdata=this.signal('Name','iic_txdata','FiType','std8');
            iic_txvld=this.signal('Name','iic_txvld','FiType','boolean');
            iic_txrdy=this.signal('Name','iic_txrdy','FiType','boolean');
            iic_rxEOP=this.signal('Name','iic_rxEOP','FiType','boolean');
            iic_txEOP=this.signal('Name','iic_txEOP','FiType','boolean');
            iic_err=this.signal('Name','iic_err','FiType','boolean');

            rst=this.signal('Name','rst','FiType','boolean');

            this.assign(' ~ this.pResetn',rst);




            this.component(...
            'Name','I2CAPBSlave',...
            'Component',eda.internal.component.MWAPBSlave('SLV_DATA_WIDTH','8',...
            'SLV_BASEADDR',this.generic.SLV_BASEADDR),...
            'pClk',this.pClk,...
            'pResetn',this.pResetn,...
            'pAddr',this.pAddr,...
            'pSel',this.pSel,...
            'pEnable',this.pEnable,...
            'pWrite',this.pWrite,...
            'pWdata',this.pWdata,...
            'pRdata',this.pRdata,...
            'pReady',this.pReady,...
            'pSlvErr',this.pSlvErr,...
            'pStrb',this.pStrb,...
            'status',this.status,...
            'clearErr',clear_err,...
            'slv_rxdata',iic_rxdata,...
            'slv_rxvld',iic_rxvld,...
            'slv_txdata',iic_txdata,...
            'slv_txvld',iic_txvld,...
            'slv_txrdy',iic_txrdy,...
            'slv_rxEOP',iic_rxEOP,...
            'slv_txEOP',iic_txEOP,...
            'slv_err',iic_err);




            i2c=this.component(...
            'UniqueName','MWAPBI2C_i2c',...
            'InstName','MWAPBI2C_i2c',...
            'Component',eda.internal.component.BlackBox({...
            'clk','INPUT','boolean',...
            'reset','INPUT','boolean',...
            'SDA_IN','INPUT','boolean',...
            'SDA_OUT','OUTPUT','boolean',...
            'SDA_OE','OUTPUT','boolean',...
            'SCL_OUT','OUTPUT','boolean',...
            'SCL_IN','INPUT','boolean',...
            'SCL_OE','OUTPUT','boolean',...
            'clearErr','INPUT','boolean',...
            'i2c_rxEOP','OUTPUT','boolean',...
            'i2c_err','OUTPUT','boolean',...
            'tx_vld','INPUT','boolean',...
            'tx_data_byte','INPUT','std8',...
            'rx_vld','OUTPUT','boolean',...
            'rx_data_byte','OUTPUT','std8',...
            'txrdy','OUTPUT','boolean'}),...
            'clk',this.pClk,...
            'reset',rst,...
            'SDA_IN',this.SDA_IN,...
            'SDA_OUT',this.SDA_OUT,...
            'SDA_OE',this.SDA_OE,...
            'SCL_IN',this.SCL_IN,...
            'SCL_OUT',this.SCL_OUT,...
            'SCL_OE',this.SCL_OE,...
            'clearErr',clear_err,...
            'i2c_rxEOP',iic_rxEOP,...
            'i2c_err',iic_err,...
            'tx_vld',iic_txvld,...
            'tx_data_byte',iic_txdata,...
            'rx_vld',iic_rxvld,...
            'rx_data_byte',iic_rxdata,...
            'txrdy',iic_txrdy);

            i2c.addprop('generic');
            i2c.generic=generics('baudrate','integer','480000',...
            'clockfreq','integer','25000000',...
            'DATA_SETUP_TIME','integer','25',...
            'DATA_HOLD_TIME','integer','125',...
            'SCL_HIGH','integer','125');
            i2c.setGenerics({'baudrate',this.generic.baudrate,...
            'clockfreq',this.generic.clockfreq,...
            'DATA_SETUP_TIME',this.generic.DATA_SETUP_TIME,...
            'DATA_HOLD_TIME',this.generic.DATA_HOLD_TIME,...
            'SCL_HIGH',this.generic.SCL_HIGH})

            i2c.addprop('CopyHDLFiles');
            i2c.HDLFileDir={fullfile(matlabroot,'toolbox','shared','eda','fpgabase',...
            '+eda','+internal','+component','@MWAPBI2C')};
            i2c.HDLFiles={'MWAPBI2C_i2c.vhd'};




            ctrl=this.component(...
            'UniqueName','MWAPBI2C_ctrlLogic',...
            'InstName','MWAPBI2C_ctrlLogic',...
            'Component',eda.internal.component.BlackBox({...
            'pClk','INPUT','boolean',...
            'pResetn','INPUT','boolean',...
            'pAddr','INPUT','std32',...
            'pSel','INPUT','boolean',...
            'pEnable','INPUT','boolean',...
            'pWrite','INPUT','boolean',...
            'pWdata','INPUT','std32',...
            'txEOP','OUTPUT','boolean'}),...
            'pClk',this.pClk,...
            'pResetn',this.pResetn,...
            'pAddr',this.pAddr,...
            'pSel',this.pSel,...
            'pEnable',this.pEnable,...
            'pWrite',this.pWrite,...
            'pWdata',this.pWdata,...
            'txEOP',iic_txEOP);

            ctrl.addprop('generic');
            ctrl.generic=generics('SLV_BASEADDR','std8','"00000100"');
            ctrl.setGenerics({'SLV_BASEADDR',this.generic.SLV_BASEADDR});

            ctrl.addprop('CopyHDLFiles');
            ctrl.HDLFileDir={fullfile(matlabroot,'toolbox','shared','eda','fpgabase',...
            '+eda','+internal','+component','@MWAPBI2C')};
            ctrl.HDLFiles={'MWAPBI2C_ctrlLogic.vhd'};
        end
    end
end