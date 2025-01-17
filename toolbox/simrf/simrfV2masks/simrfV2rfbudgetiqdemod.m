function simrfV2rfbudgetiqdemod(block,action)








    switch(action)
    case 'simrfInit'
        top_sys=bdroot(block);

        if strcmpi(top_sys,'rfBudgetAnalyzer_lib')
            return
        end


        MaskVals=get_param(block,'MaskValues');
        idxMaskNames=simrfV2getblockmaskparamsindex(block);

        RFinPort='RF';
        QoutPort='Q';
        IoutPort='I';

        IRFilter=sprintf('Ideal\nImage Reject');
        CSFilterI=sprintf('Ideal I-branch\nChannel Select');
        CSFilterQ=sprintf('Ideal Q-branch\nChannel Select');

        isSetFilters=false;
        isNewFromLib=false;
        if(~any(strcmpi(get_param(top_sys,'SimulationStatus'),...
            {'running','paused'})))
            if(strcmpi(MaskVals{idxMaskNames.SetFilters},'on'))
                isSetFilters=true;


                set_param(block,'SetFilters','off')
            end



            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            IRFilter);
            if(~isempty(repBlkFullPath))
                userData=get_param(repBlkFullPath{1},'UserData');
                if((isfield(userData,'initIRFilter'))&&...
                    (userData.initIRFilter))
                    isNewFromLib=true;


                    userData.initIRFilter=false;
                    set_param(repBlkFullPath{1},'UserData',userData);
                end
            end
        end
        if(isSetFilters||isNewFromLib)


            set_param([block,'/IQ Demodulator'],...
            'Source_linear_gain','Available power gain',...
            'linear_gain',MaskVals{idxMaskNames.linear_gain},...
            'linear_gain_unit','dB',...
            'LOFreq',MaskVals{idxMaskNames.LOFreq},...
            'LOFreq_unit',MaskVals{idxMaskNames.LOFreq_unit},...
            'Zin',MaskVals{idxMaskNames.Zin},...
            'Zout',MaskVals{idxMaskNames.Zout},...
            'NF',MaskVals{idxMaskNames.NF},...
            'Source_Poly','Even and odd order',...
            'IPType','Output',...
            'IP2','Inf',...
            'IP2_unit','dBm',...
            'IP3',MaskVals{idxMaskNames.IP3},...
            'IP3_unit','dBm')


            MaskEnables=get_param(block,'MaskEnables');
            if strcmpi(MaskVals{idxMaskNames.IRFilterOnInit},'off')
                set_param(block,'IRFilterOn','off')
                MaskEnables{idxMaskNames.IRFilterOn}='off';
            end
            if strcmpi(MaskVals{idxMaskNames.CSFiltersOnInit},'off')
                set_param(block,'CSFiltersOn','off')
                MaskEnables{idxMaskNames.CSFiltersOn}='off';
            end
            MaskVals=get_param(block,'MaskValues');
            set_param(block,'MaskEnables',MaskEnables);


            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            CSFilterI);
            if(strcmpi(MaskVals{idxMaskNames.CSFiltersOn},'on')&&...
                ~isempty(repBlkFullPath))
                set_param([block,'/',CSFilterI],...
                'DataSource','Network-parameters',...
                'Paramtype','S-parameters',...
                'Sparam',MaskVals{idxMaskNames.SparamCS},...
                'SparamFreq',...
                MaskVals{idxMaskNames.SparamFreqCS},...
                'SparamFreq_unit',...
                MaskVals{idxMaskNames.SparamFreqCS_unit},...
                'SparamRepresentation','Frequency domain',...
                'AutoImpulseLength','off',...
                'ImpulseLength','0',...
                'AddNoise','off',...
                'SparamZ0','50')
                set_param([block,'/',CSFilterQ],...
                'DataSource','Network-parameters',...
                'Paramtype','S-parameters',...
                'Sparam',MaskVals{idxMaskNames.SparamCS},...
                'SparamFreq',...
                MaskVals{idxMaskNames.SparamFreqCS},...
                'SparamFreq_unit',...
                MaskVals{idxMaskNames.SparamFreqCS_unit},...
                'SparamRepresentation','Frequency domain',...
                'AutoImpulseLength','off',...
                'ImpulseLength','0',...
                'AddNoise','off',...
                'SparamZ0','50')
            end
            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            IRFilter);
            if(strcmpi(MaskVals{idxMaskNames.IRFilterOn},'on')&&...
                ~isempty(repBlkFullPath))
                set_param([block,'/',IRFilter],...
                'DataSource','Network-parameters',...
                'Paramtype','S-parameters',...
                'Sparam',MaskVals{idxMaskNames.SparamIR},...
                'SparamFreq',...
                MaskVals{idxMaskNames.SparamFreqIR},...
                'SparamFreq_unit',...
                MaskVals{idxMaskNames.SparamFreqIR_unit},...
                'SparamRepresentation','Frequency domain',...
                'AutoImpulseLength','off',...
                'ImpulseLength','0',...
                'AddNoise','off',...
                'SparamZ0','50')
            end
        end


        if((isSetFilters||isNewFromLib)||...
            ~isempty(regexpi(get_param(top_sys,'SimulationStatus'),...
            '^(updating|initializing)$')))

            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            IRFilter);
            if strcmpi(MaskVals{idxMaskNames.IRFilterOn},'on')
                if isempty(repBlkFullPath)

                    posSparamBlk=...
                    get_param('simrfV2elements/S-parameters',...
                    'Position');
                    posSparamBlk_dx=posSparamBlk(3)-posSparamBlk(1);
                    posSparamBlk_dy=posSparamBlk(4)-posSparamBlk(2);
                    posIinBlk=get_param([block,'/',RFinPort],...
                    'Position');
                    posIQDemodBlk=...
                    get_param([block,'/IQ Demodulator'],'Position');
                    posIinBlk_y_mid=(posIinBlk(2)+posIinBlk(4))/2;
                    posIinBlk_x_mid=(posIinBlk(1)+posIinBlk(3))/2;
                    Blks_halfway=(-posIinBlk(1)+posIQDemodBlk(1))/2;
                    phIinBlk=get_param([block,'/',RFinPort],...
                    'PortHandles');
                    simrfV2deletelines(get(phIinBlk.RConn,'Line'));

                    add_block('simrfV2elements/S-parameters',...
                    [block,'/',IRFilter],...
                    'DataSource','Network-parameters',...
                    'Paramtype','S-parameters',...
                    'Sparam',MaskVals{idxMaskNames.SparamIR},...
                    'SparamFreq',...
                    MaskVals{idxMaskNames.SparamFreqIR},...
                    'SparamFreq_unit',...
                    MaskVals{idxMaskNames.SparamFreqIR_unit},...
                    'SparamRepresentation','Frequency domain',...
                    'AutoImpulseLength','off',...
                    'ImpulseLength','0',...
                    'AddNoise','off',...
                    'SparamZ0','50',...
                    'Position',[posIinBlk_x_mid-...
                    posSparamBlk_dx/2+Blks_halfway...
                    ,posIinBlk_y_mid-posSparamBlk_dy/2...
                    ,posIinBlk_x_mid+posSparamBlk_dx/2+...
                    Blks_halfway,posIinBlk_y_mid+...
                    posSparamBlk_dy/2]);



                    userData=get_param([block,'/',IRFilter],'UserData');
                    userData.initIRFilter=false;
                    set_param([block,'/',IRFilter],'UserData',userData);
                    simrfV2connports(struct('SrcBlk',IRFilter,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','IQ Demodulator','DstBlkPortStr',...
                    'LConn','DstBlkPortIdx',1),block);
                    simrfV2connports(struct('SrcBlk',IRFilter,...
                    'SrcBlkPortStr','LConn','SrcBlkPortIdx',1,...
                    'DstBlk',RFinPort,'DstBlkPortStr','RConn',...
                    'DstBlkPortIdx',1),block);
                end
            else
                if~isempty(repBlkFullPath)



                    phIRBlk=get_param([block,'/',IRFilter],...
                    'PortHandles');

                    simrfV2deletelines(get(phIRBlk.LConn,'Line'));

                    simrfV2deletelines(get(phIRBlk.RConn,'Line'));
                    delete_block([block,'/',IRFilter]);
                    simrfV2connports(struct('SrcBlk',RFinPort,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','IQ Demodulator','DstBlkPortStr',...
                    'LConn','DstBlkPortIdx',1),block);
                end
            end


            repBlkFullPath=find_system(block,'LookUnderMasks',...
            'all','FollowLinks','on','SearchDepth',1,'Name',...
            CSFilterI);
            if strcmpi(MaskVals{idxMaskNames.CSFiltersOn},'on')
                if isempty(repBlkFullPath)

                    posSparamBlk=...
                    get_param('simrfV2elements/S-parameters',...
                    'Position');
                    posSparamBlk_dx=posSparamBlk(3)-posSparamBlk(1);
                    posSparamBlk_dy=posSparamBlk(4)-posSparamBlk(2);
                    posIoutBlk=get_param([block,'/',IoutPort],...
                    'Position');
                    posIQDemodBlk=...
                    get_param([block,'/IQ Demodulator'],'Position');
                    posIoutBlk_y_mid=(posIoutBlk(2)+posIoutBlk(4))/2;
                    posIoutBlk_x_mid=(posIoutBlk(1)+posIoutBlk(3))/2;
                    Blks_halfway=(-posIQDemodBlk(3)+posIoutBlk(3))/2;
                    phRFoutBlk=get_param([block,'/',IoutPort],...
                    'PortHandles');
                    simrfV2deletelines(get(phRFoutBlk.RConn,'Line'));

                    add_block('simrfV2elements/S-parameters',...
                    [block,'/',CSFilterI],...
                    'DataSource','Network-parameters',...
                    'Paramtype','S-parameters',...
                    'Sparam',MaskVals{idxMaskNames.SparamCS},...
                    'SparamFreq',...
                    MaskVals{idxMaskNames.SparamFreqCS},...
                    'SparamFreq_unit',...
                    MaskVals{idxMaskNames.SparamFreqCS_unit},...
                    'SparamRepresentation','Frequency domain',...
                    'AutoImpulseLength','off',...
                    'ImpulseLength','0',...
                    'AddNoise','off',...
                    'SparamZ0','50',...
                    'Position',[posIoutBlk_x_mid-...
                    posSparamBlk_dx/2-Blks_halfway...
                    ,posIoutBlk_y_mid-posSparamBlk_dy/2...
                    ,posIoutBlk_x_mid+posSparamBlk_dx/2-...
                    Blks_halfway,posIoutBlk_y_mid+...
                    posSparamBlk_dy/2]);
                    simrfV2connports(struct('SrcBlk',CSFilterI,...
                    'SrcBlkPortStr','LConn','SrcBlkPortIdx',1,...
                    'DstBlk','IQ Demodulator','DstBlkPortStr',...
                    'RConn','DstBlkPortIdx',1),block);
                    simrfV2connports(struct('SrcBlk',CSFilterI,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk',IoutPort,'DstBlkPortStr','RConn',...
                    'DstBlkPortIdx',1),block);

                    posQoutBlk=get_param([block,'/',QoutPort],...
                    'Position');
                    posQoutBlk_y_mid=(posQoutBlk(2)+posQoutBlk(4))/2;
                    phQoutBlk=get_param([block,'/',QoutPort],...
                    'PortHandles');
                    simrfV2deletelines(get(phQoutBlk.RConn,'Line'));

                    add_block('simrfV2elements/S-parameters',...
                    [block,'/',CSFilterQ],...
                    'DataSource','Network-parameters',...
                    'Paramtype','S-parameters',...
                    'Sparam',MaskVals{idxMaskNames.SparamCS},...
                    'SparamFreq',...
                    MaskVals{idxMaskNames.SparamFreqCS},...
                    'SparamFreq_unit',...
                    MaskVals{idxMaskNames.SparamFreqCS_unit},...
                    'SparamRepresentation','Frequency domain',...
                    'AutoImpulseLength','off',...
                    'ImpulseLength','0',...
                    'AddNoise','off',...
                    'SparamZ0','50',...
                    'Position',[posIoutBlk_x_mid-...
                    posSparamBlk_dx/2-Blks_halfway...
                    ,posQoutBlk_y_mid-posSparamBlk_dy/2...
                    ,posIoutBlk_x_mid+posSparamBlk_dx/2-...
                    Blks_halfway,posQoutBlk_y_mid+...
                    posSparamBlk_dy/2]);
                    simrfV2connports(struct('SrcBlk',CSFilterQ,...
                    'SrcBlkPortStr','LConn','SrcBlkPortIdx',1,...
                    'DstBlk','IQ Demodulator','DstBlkPortStr',...
                    'RConn','DstBlkPortIdx',2),block);
                    simrfV2connports(struct('SrcBlk',CSFilterQ,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk',QoutPort,'DstBlkPortStr','RConn',...
                    'DstBlkPortIdx',1),block);
                end
            else
                if~isempty(repBlkFullPath)



                    phCSBlk=get_param([block,'/',CSFilterI],...
                    'PortHandles');

                    simrfV2deletelines(get(phCSBlk.LConn,'Line'));

                    simrfV2deletelines(get(phCSBlk.RConn,'Line'));
                    delete_block([block,'/',CSFilterI]);
                    simrfV2connports(struct('SrcBlk',IoutPort,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','IQ Demodulator','DstBlkPortStr',...
                    'RConn','DstBlkPortIdx',1),block);




                    phCSBlk=get_param([block,'/',CSFilterQ],...
                    'PortHandles');

                    simrfV2deletelines(get(phCSBlk.LConn,'Line'));

                    simrfV2deletelines(get(phCSBlk.RConn,'Line'));
                    delete_block([block,'/',CSFilterQ]);
                    simrfV2connports(struct('SrcBlk',QoutPort,...
                    'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                    'DstBlk','IQ Demodulator','DstBlkPortStr',...
                    'RConn','DstBlkPortIdx',2),block);
                end
            end
        end

    case 'simrfDelete'

    case 'simrfCopy'

    case 'simrfDefault'

    end

end