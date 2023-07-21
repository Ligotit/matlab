classdef LayerSeparation<slmetric.metric.Metric




    properties(Access=private,Constant)


        AllowedSubsystemBlocks={...
        'Inport:';...
        'Outport:';...
        'Mux:';...
        'Demux:';...
        'BusSelector:';...
        'BusCreator:';...
        'Selector:';...
        'Ground:';...
        'Terminator:';...
        'From:';...
        'Goto:';...
        'Merge:';...
        'UnitDelay:';...
        'RateTransition:';...
        'DataTypeConversion:';...
        'DataStoreMemory:';...
        'If:';...
        'SwitchCase:';...
        'FunctionCallSplit:';...
        'S-Function:Function-Call Generator';...
        'EnablePort:';...
        'TriggerPort:';...
        'ActionPort:';...
        'SubSystem:Conversion Inherited';...
        'SubSystem:VerificationSubsystem';...
        'ModelReference:';...
        'SubSystem:';...
        'SubSystem:masked subsystem';...
        'SubSystem:CMBlock';
        };
    end

    methods
        function this=LayerSeparation()
            this.ID='mathworks.metrics.LayerSeparation';
            this.Version=1;
            this.ComponentScope=[Advisor.component.Types.Model,...
            Advisor.component.Types.SubSystem];
            this.AggregationMode=slmetric.AggregationMode.Sum;

            this.Name=DAStudio.message('slcheck:metric:LayerSeparation_Name');
            this.Description=DAStudio.message('slcheck:metric:LayerSeparation_Desc');
            this.ValueName=DAStudio.message('slcheck:metric:LayerSeparation_ValueLabel');
            this.AggregatedValueName=DAStudio.message('slcheck:metric:LayerSeparation_AggregateValueLabel');

            this.setCSH('ma.metricchecks','LayerSeparation');
        end

        function res=algorithm(this,component)

            slPath=component.getPath();
            count=this.getNonConformingBlockCount(slPath);

            res=slmetric.metric.Result();
            res.ComponentID=component.ID;
            res.MetricID=this.ID;
            res.Value=count;
        end
    end

    methods(Access=private)
        function num=getNonConformingBlockCount(this,slPath)
            num=0;




            blks=find_system(slPath,...
            'MatchFilter',@Simulink.match.internal.filterOutInactiveVariantSubsystemChoices,...
            'LookUnderMasks','all',...
            'FollowLinks','on',...
            'SearchDepth',1);


            blks=blks(2:end);


            blks=blks(~slprivate('is_stateflow_based_block',blks));


            BlockTypeMaskType=strcat(get_param(blks,'BlockType'),...
            {':'},get_param(blks,'MaskType'));


            if any(strcmp(BlockTypeMaskType,'SubSystem:'))
                for jdx=1:length(BlockTypeMaskType)

                    if~any(strcmp(BlockTypeMaskType{jdx},this.AllowedSubsystemBlocks))
                        num=num+1;
                    end
                end
            end
        end
    end
end
