function hdlcode=componentBody(this)





    hdlcode=this.hdlcodeinit;



    [payLoadReg,ptr]=hdlnewsignal('payLoadReg','block',-1,0,0,'std_logic_vector(OUTPUT_DATAWIDTH + 39  downto 0)','');
    hdlcode.arch_signals=[hdlcode.arch_signals,makehdlsignaldecl(ptr)];


    dclk=this.findSignalName('dclk','componentBody');
    reset=this.findSignalName('reset','componentBody');
    dataOut=this.findSignalName('dataOut','componentBody');
    dataOutVld=this.findSignalName('dataOutVld','componentBody');
    dataIn=this.findSignalName('dataIn','componentBody');
    dataInVld=this.findSignalName('dataInVld','componentBody');
    txPayLoad=this.findSignalName('txPayLoad','componentBody');

    hdlcode.arch_body_blocks=[...
...
    ' payloadTransfer : process (',dclk,')\n',...
    ' begin\n',...
    '   if ',dclk,'''event and ',dclk,' = ''1'' then \n',...
    '     if ',reset,' = ''1'' then\n',...
    '       ',payLoadReg,' <= (others => ''0'');\n',...
    '     else \n',...
    '       if ',dataInVld,' = ''1'' then\n',...
    '         ',payLoadReg,'(OUTPUT_DATAWIDTH - 1 downto 0) <= ',dataIn,';\n',...
    '       elsif ',txPayLoad,' = ''1'' then\n',...
    '         ',payLoadReg,'(OUTPUT_DATAWIDTH - 1 downto OUTPUT_DATAWIDTH - 8) <= (others => ''0'');\n',...
    '         ',payLoadReg,'(OUTPUT_DATAWIDTH - 9 downto 0)                    <= ',payLoadReg,'(OUTPUT_DATAWIDTH - 1 downto 8);\n',...
    '       end if;\n',...
    '     end if;\n',...
    '   end if;\n',...
    ' end process payloadTransfer;\n\n',...
    '  ',...
    ' --',dataOut,'  <= ',dataIn,'(7 downto 0);\n',...
    ' --',dataOutVld,'   <= ',txPayLoad,';\n',...
    ' ',dataOut,'  <= ',payLoadReg,'(15 downto 8) when ',txPayLoad,' = ''1'' else\n',...
    '                       ',dataIn,'(7 downto 0);\n',...
    ' ',dataOutVld,'   <= ',txPayLoad,' OR ',dataInVld,';\n\n'];


end
