function hdlcode=vhdltbcodercodeinit(this,node,level,nname)


    comment_char=hdlgetparameter('comment_char');
    indentedcomment=['  ',comment_char,' '];
    separatorline=[comment_char,' ','-'*ones(1,63-length(comment_char)),'\n'];

    hdlcode=hdlcodeinit;
    hdlcode.entity_comment=this.hdlentityComment(node,level,nname);


    hdlcode.package_comment=this.hdlpackageComment(node,nname);
    hdlcode.package_library='LIBRARY IEEE;\nUSE IEEE.std_logic_1164.all;\nUSE IEEE.numeric_std.ALL;\n';
    if isTextIOSupported(this)
        hdlcode.package_library=[hdlcode.package_library,'USE STD.textio.ALL;\nUSE IEEE.std_logic_textio.ALL;\n'];
    end
    pkg_name=[nname,hdlgetparameter('package_suffix')];
    hdlcode.package_decl=sprintf('PACKAGE %s IS\n',pkg_name);
    hdlcode.package_end=sprintf('END %s;\n\n',pkg_name);
    hdlcode.package_functions=['\n',indentedcomment,'Functions\n'];
    hdlcode.package_procedure=['\n',indentedcomment,'Procedures\n'];
    hdlcode.package_typedefs=['\n',indentedcomment,'Type Definitions\n'];
    hdlcode.package_body=sprintf('PACKAGE BODY %s IS\n',pkg_name);
    hdlcode.arch_functions=sprintf('%sLocal Functions\n',indentedcomment);
    hdlcode.arch_typedefs=sprintf('%sLocal Type Definitions\n',indentedcomment);
    hdlcode.arch_constants=sprintf('%sConstants\n',indentedcomment);
    hdlcode.arch_signals=sprintf('%sSignals\n',indentedcomment);
    hdlcode.arch_body_blocks=sprintf('\n%sBlock Statements\n',indentedcomment);
    hdlcode.arch_body_output_assignments=sprintf('%sAssignment Statements\n',indentedcomment);
    hdlcode.arch_decl=sprintf('ARCHITECTURE rtl OF %s IS\n',nname);
    if hdlgetparameter('split_entity_arch')==1,
        hdlcode.arch_comment=hdlcode.entity_comment;
    else
        hdlcoder.arch_comment=sprintf('%s%s Module Architecture %s\n%s',...
        separatorline,comment_char,nname,separatorline);
    end
    hdlcode.arch_end='END rtl;\n';
    hdlcode.arch_begin='\n\nBEGIN\n';
    hdlcode.arch_body_component_instances=sprintf('%sComponent Instances\n',indentedcomment);
    hdlcode.entity_library=hdlcode.package_library;

    if hdlgetparameter('vhdl_package_required')==1
        hdlcode.entity_package=sprintf('USE work.%s.ALL;\n',hdlgetparameter('vhdl_package_name'));
    else
        hdlcode.entity_package='\n';
    end

    hdlcode.package_library=[hdlcode.package_library,hdlcode.entity_package,'\n'];
    hdlcode.entity_package=[hdlcode.entity_package,'USE work.',[nname,hdlgetparameter('package_suffix')],'.ALL;\n\n'];
    hdlcode.entity_package=[hdlcode.entity_package,'USE work.',[nname,this.TestBenchDataPostfix],'.ALL;\n\n'];
    hdlcode.entity_decl=sprintf('ENTITY %s IS\n',nname);
    hdlcode.entity_end=sprintf('\nEND %s;\n\n\n',nname);

    if hdlgetparameter('clockinputs')==1
        clkDesc.Name=this.ClockName;
        clkDesc.Ratio=1;
        hdlcode.arch_constants=[hdlcode.arch_constants,genClockConsts(this,clkDesc)];
    else
        for ii=1:length(this.clockTable)
            if this.clockTable(ii).Kind==0
                if this.clockTable(ii).Ratio>1
                    rate_comment=sprintf('%dx slower',this.ClockTable(ii).Ratio);
                else
                    rate_comment='base rate';
                end
                hdlcode.arch_constants=[hdlcode.arch_constants,indentedcomment...
                ,sprintf('Clock constants for %s clock\n',rate_comment)];
                hdlcode.arch_constants=[hdlcode.arch_constants,genClockConsts(this,this.clockTable(ii))];
            end
        end
    end


    hdlcode.package_functions=[hdlcode.package_functions,...
    '  FUNCTION to_integer( x : IN std_logic) RETURN integer;\n',...
    '  FUNCTION to_hex( x : IN std_logic) RETURN string;\n',...
    '  FUNCTION to_hex( x : IN std_logic_vector) RETURN string;\n',...
    '  FUNCTION to_hex( x : IN signed ) RETURN string;\n',...
    '  FUNCTION to_hex( x : IN unsigned ) RETURN string;\n',...
    '  FUNCTION to_hex( x : IN real ) RETURN string;\n',...
    '  FUNCTION SLICE( x : IN bit_vector; slice : In Integer) RETURN std_logic_vector;\n',...
    '  FUNCTION SLICE( x : IN bit_vector; slice : In Integer) RETURN signed;\n',...
    '  FUNCTION SLICE( x : IN bit_vector; slice : In Integer) RETURN unsigned;\n'];

    hdlcode.package_body=[hdlcode.package_body,...
    '  FUNCTION to_integer( x : IN std_logic) RETURN integer IS\n',...
'    VARIABLE int: integer;\n'...
    ,'  BEGIN\n',...
    '    IF x = ''0'' THEN\n',...
    '      int := 0;\n',...
    '    ELSE\n',...
    '      int := 1;\n',...
    '    END IF;\n',...
    '    RETURN int;\n',...
    '  END;\n\n',...
    '  FUNCTION to_hex( x : IN std_logic_vector) RETURN string IS\n',...
    '    VARIABLE result  : STRING(1 TO 256); -- 1024 bits max\n',...
    '    VARIABLE i       : INTEGER;\n',...
    '    VARIABLE imod    : INTEGER;\n',...
    '    VARIABLE j       : INTEGER;\n',...
    '    VARIABLE jinc    : INTEGER;\n',...
    '    VARIABLE newx    : std_logic_vector(1023 DOWNTO 0);\n',...
    '  BEGIN\n',...
    '    newx := (OTHERS => ''0'');\n',...
    '    IF x''LEFT > x''RIGHT THEN\n',...
    '      j := x''LENGTH-1;\n',...
    '      jinc := -1;\n',...
    '    ELSE\n',...
    '      j := 0;\n',...
    '      jinc := 1;\n',...
    '    END IF;\n',...
    '    FOR i IN x''RANGE LOOP\n',...
    '      newx(j) := x(i);\n',...
    '      j := j+jinc;\n',...
    '    END LOOP;  -- i\n',...
    '    i := x''LENGTH-1;\n',...
    '    imod := x''LENGTH MOD 4;\n',...
    '    IF    imod = 1 THEN i := i+3;\n',...
    '    ELSIF imod = 2 THEN i := i+2;\n',...
    '    ELSIF imod = 3 THEN i := i+1;\n',...
    '    END IF;\n',...
    '    j := 1;\n',...
    '    WHILE i >= 3 LOOP\n',...
    '      IF    newx(i DOWNTO (i-3)) = "0000" THEN result(j) := ''0'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0001" THEN result(j) := ''1'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0010" THEN result(j) := ''2'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0011" THEN result(j) := ''3'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0100" THEN result(j) := ''4'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0101" THEN result(j) := ''5'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0110" THEN result(j) := ''6'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "0111" THEN result(j) := ''7'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1000" THEN result(j) := ''8'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1001" THEN result(j) := ''9'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1010" THEN result(j) := ''A'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1011" THEN result(j) := ''B'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1100" THEN result(j) := ''C'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1101" THEN result(j) := ''D'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1110" THEN result(j) := ''E'';\n',...
    '      ELSIF newx(i DOWNTO (i-3)) = "1111" THEN result(j) := ''F'';\n',...
    '      ELSE result(j) := ''X'';\n',...
    '      END IF;\n',...
    '      i := i-4;\n',...
    '      j := j+1;\n',...
    '    END LOOP;\n',...
    '    RETURN result(1 TO j-1);\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION to_hex( x : IN std_logic ) RETURN string IS\n',...
    '  BEGIN\n',...
    '    RETURN std_logic''image(x);\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION to_hex( x : IN signed ) RETURN string IS\n',...
    '  BEGIN\n',...
    '    RETURN to_hex( std_logic_vector(x) );\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION to_hex( x : IN unsigned ) RETURN string IS\n',...
    '  BEGIN\n',...
    '    RETURN to_hex( std_logic_vector(x) );\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION to_hex( x : IN real ) RETURN string IS\n',...
    '  BEGIN\n',...
    '    RETURN real''image(x);\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION SLICE( x : IN bit_vector; slice : IN Integer) RETURN std_logic_vector IS\n',...
    '    variable result : std_logic_vector(slice - 1 DOWNTO 0);\n',...
    '  BEGIN\n',...
    '    result := to_stdlogicvector(bit_vector''(x))(slice - 1 DOWNTO 0);\n',...
    '    RETURN result;\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION SLICE( x : IN bit_vector; slice : IN Integer) RETURN signed IS\n',...
    '    variable result : signed(slice -  1 DOWNTO 0);\n',...
    '  BEGIN\n',...
    '    result := signed(to_stdlogicvector(bit_vector''(x))(slice - 1 DOWNTO 0));\n',...
    '    RETURN result;\n',...
    '  END;\n',...
    '\n\n',...
    '  FUNCTION SLICE( x : IN bit_vector; slice : IN Integer) RETURN unsigned IS\n',...
    '    variable result : unsigned(slice -  1 DOWNTO 0);\n',...
    '  BEGIN\n',...
    '    result := unsigned(to_stdlogicvector(bit_vector''(x))(slice - 1 DOWNTO 0));\n',...
    '    RETURN result;\n',...
    '  END;\n',...
    '\n\n'];
end

function returnString=genClockConsts(this,clkDesc)
    highTime=this.ForceClockHighTime*clkDesc.Ratio;
    lowTime=this.ForceClockLowTime*clkDesc.Ratio;
    returnString=[...
    sprintf('  CONSTANT %-32s : time := %d ns;\n',this.hdlclkhigh(clkDesc.Name),highTime),...
    sprintf('  CONSTANT %-32s : time := %d ns;\n',this.hdlclklow(clkDesc.Name),lowTime),...
    sprintf('  CONSTANT %-32s : time := %d ns;\n',this.hdlclkperiod(clkDesc.Name),highTime+lowTime),...
    sprintf('  CONSTANT %-32s : time := %d ns;\n',this.hdlclkhold(clkDesc.Name),this.ForceHoldTime*clkDesc.Ratio),...
    ];
end


