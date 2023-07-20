function simrfV2ladderlc(block,action)





    top_sys=bdroot(block);
    if strcmpi(get_param(top_sys,'BlockDiagramType'),'library')...
        &&strcmpi(top_sys,'simrfV2elements')
        return;
    end




    switch(action)
    case 'simrfInit'

        if any(strcmpi(get_param(top_sys,'SimulationStatus'),...
            {'running','paused'}))
            return
        end


        MaskVals=get_param(block,'MaskValues');
        idxMaskNames=simrfV2getblockmaskparamsindex(block);
        MaskWSValues=simrfV2getblockmaskwsvalues(block);

        MaskDisplay=sprintf('%s\n%s',...
        '[xData yData] = simrfV2iconplotlc(gcb);',...
        'plot(xData, yData)');


        switch lower(MaskVals{idxMaskNames.InternalGrounding})
        case 'on'

            MaskDisplay=simrfV2_add_portlabel(MaskDisplay,...
            1,{'1'},1,{'2'},true);
            set_param(block,'MaskDisplay',MaskDisplay)
            simrfV2repblk(struct('RepBlk','1-',...
            'SrcBlk','simrfV2elements/Gnd',...
            'SrcLib','simrfV2elements','DstBlk','Gnd1'),block);
            replace_gnd_complete=simrfV2repblk(struct(...
            'RepBlk','2-',...
            'SrcBlk','simrfV2elements/Gnd',...
            'SrcLib','simrfV2elements','DstBlk','Gnd2'),block);

            if replace_gnd_complete
                simrfV2connports(struct('SrcBlk','Node',...
                'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                'DstBlk','Gnd1','DstBlkPortStr','LConn',...
                'DstBlkPortIdx',1),block);
                simrfV2connports(struct('SrcBlk','Node',...
                'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                'DstBlk','Gnd2','DstBlkPortStr','LConn',...
                'DstBlkPortIdx',1),block);
            end

        case 'off'

            simrfV2repblk(struct('RepBlk','Gnd1','SrcBlk',...
            'nesl_utility_internal/Connection Port',...
            'SrcLib','nesl_utility_internal','DstBlk','1-',...
            'Param',{{'Side','Left','Orientation','Up',...
            'Port','3'}}),block);
            replace_gnd_complete=simrfV2repblk(struct(...
            'RepBlk','Gnd2',...
            'SrcBlk','nesl_utility_internal/Connection Port',...
            'SrcLib','nesl_utility_internal','DstBlk','2-',...
            'Param',{{'Side','Right','Orientation','Up',...
            'Port','4'}}),block);
            if replace_gnd_complete
                simrfV2connports(struct('SrcBlk','Node',...
                'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                'DstBlk','1-','DstBlkPortStr','RConn',...
                'DstBlkPortIdx',1),block);
                simrfV2connports(struct('SrcBlk','Node',...
                'SrcBlkPortStr','RConn','SrcBlkPortIdx',1,...
                'DstBlk','2-','DstBlkPortStr','RConn',...
                'DstBlkPortIdx',1),block);
            end
            MaskDisplay=simrfV2_add_portlabel(MaskDisplay,...
            2,{'1'},2,{'2'},false);
            set_param(block,'MaskDisplay',MaskDisplay)
        end


        topology=MaskWSValues.LadderType;
        switch topology
        case 'LC Lowpass Tee'
            caps=MaskWSValues.Capacitance_lpt;
            inds=MaskWSValues.Inductance_lpt;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_lpt_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_lpt_unit);

        case 'LC Highpass Pi'
            caps=MaskWSValues.Capacitance_hpp;
            inds=MaskWSValues.Inductance_hpp;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_hpp_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_hpp_unit);

        case 'LC Lowpass Pi'
            caps=MaskWSValues.Capacitance_lpp;
            inds=MaskWSValues.Inductance_lpp;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_lpp_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_lpp_unit);

        case 'LC Highpass Tee'
            caps=MaskWSValues.Capacitance_hpt;
            inds=MaskWSValues.Inductance_hpt;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_hpt_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_hpt_unit);

        case 'LC Bandpass Tee'
            caps=MaskWSValues.Capacitance_bpt;
            inds=MaskWSValues.Inductance_bpt;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_bpt_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_bpt_unit);

        case 'LC Bandpass Pi'
            caps=MaskWSValues.Capacitance_bpp;
            inds=MaskWSValues.Inductance_bpp;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_bpp_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_bpp_unit);

        case 'LC Bandstop Tee'
            caps=MaskWSValues.Capacitance_bst;
            inds=MaskWSValues.Inductance_bst;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_bst_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_bst_unit);

        case 'LC Bandstop Pi'
            caps=MaskWSValues.Capacitance_bsp;
            inds=MaskWSValues.Inductance_bsp;
            caps=simrfV2convert2baseunit(caps,...
            MaskWSValues.Capacitance_bsp_unit);
            inds=simrfV2convert2baseunit(inds,...
            MaskWSValues.Inductance_bsp_unit);
        end

        validateattributes(caps,{'numeric'},...
        {'nonempty','vector','finite','real','positive'},...
        mfilename,'Capacitance')

        validateattributes(inds,{'numeric'},...
        {'nonempty','vector','finite','real','positive'},...
        mfilename,'Inductance')

        topology=MaskWSValues.LadderType;
        switch topology
        case{'LC Lowpass Tee','LC Highpass Pi'}
            if~(numel(inds)==numel(caps)||...
                numel(inds)-1==numel(caps))
                error(message('simrf:simrfV2errors:ArraySizeBad',...
                'Capacitance',numel(inds)-1,numel(inds)));
            end
        case{'LC Lowpass Pi','LC Highpass Tee'}
            if~(numel(caps)==numel(inds)||...
                numel(caps)-1==numel(inds))
                error(message('simrf:simrfV2errors:ArraySizeBad',...
                'Inductance',numel(caps)-1,numel(caps)));
            end
        case{'LC Bandpass Tee','LC Bandpass Pi',...
            'LC Bandstop Tee','LC Bandstop Pi'}
            validateattributes(caps,{'numeric'},...
            {'numel',numel(inds)},mfilename,'Capacitance')
        end

        Udata=get_param(block,'UserData');
        if isempty(Udata)||...
            ~strcmp(topology,Udata.Topology)||...
            numel(Udata.NumCaps)~=numel(caps)||...
            ~all(Udata.NumCaps==caps)||...
            (numel(Udata.NumInds)~=numel(inds)||...
            ~all(Udata.NumInds==inds))
            Udata.Topology=topology;
            Udata.NumCaps=caps;
            Udata.NumInds=inds;
            set_param(block,'UserData',Udata);
            simrfV2_lcladder_setup(block,topology,inds,caps)
        end
    end

end