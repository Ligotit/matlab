




classdef SupportedUnitConversionConstraint<slci.compatibility.Constraint

    properties(Access=private)


        fSupportedConversion={'deg_rad','rad_deg',...
        'degC_degF','degF_degC',...
        'degC_degR','degR_degC',...
        'degR_degF','degF_degR',...
        'degC_K','K_degC',...
        'degF_K','K_degF',...
        'degR_K','K_degR',...
        'deltadegC_deltadegF','deltadegF_deltadegC',...
        'deltadegC_deltadegR','deltadegR_deltadegC',...
        'deltadegR_deltadegF','deltadegF_deltadegR',...
        'deltadegC_deltaK','deltaK_deltadegC',...
        'deltadegF_deltaK','deltaK_deltadegF',...
        'deltadegR_deltaK','deltaK_deltadegR',...
        'ft_m','m_ft',...
        'mi_ft','ft_mi',...
        'M_ft','ft_M',...
        'm_M','M_m',...
        'kg_lbm','lbm_kg',...
        'lbf_N','N_lbf',...
        'inHg_Pa','Pa_inHg',...
        'mmHg_inHg','inHg_mmHg',...
        'kn_mph','mph_kn',...
        'mph_fps','fps_mph',...
        'fps_kn','kn_fps',...
        'percent_one','one_percent',...
        'kn_nmi/s','nmi/s_kn',...
        'ms_s','s_ms',...
        'psf_psi','psi_psf',...
        'lbf/hr_lbf/sec','lbf/sec_lbf/hr',...
        'lbm/hr_lbm/sec','lbm/sec_lbm/hr',...
        'kip_N','N_kip',...
        'kip_lbf','lbf_kip',...
        'fpm_fps','fps_fpm',...
        'hr_min','min_hr','min_s',...
        'ft*lbf/slug/degR_ft*lbf/slug/K',...
        'ft*lb/slug/degR_ft*lb/slug/K',...
        'slug_lbm','lbm_slug',...
        's_hr',...
        'ft/min_kn',...
        'kn_ft/min',...
        'hr_s',...
        's_min',...
        };
    end

    methods(Access=private)


        function out=getSupportedConversion(aObj)
            out=aObj.fSupportedConversion;
        end

    end

    methods


        function out=getDescription(aObj)
            out=['Unit conversion Block only support the following conversions:',...
            aObj.getSupportedConversion()];
        end


        function obj=SupportedUnitConversionConstraint()
            obj.setEnum('SupportedUnitConversionConstraint');
            obj.setCompileNeeded(1);
            obj.setFatal(false);
        end


        function out=check(aObj)
            out=[];


            mdlHdl=get_param(aObj.ParentBlock().getHandle(),'Handle');
            [inportUnit,outportUnit]=slci.internal.getCompiledPortUnits(mdlHdl);



            sameUnits=isequal(inportUnit,outportUnit);

            if~sameUnits

                unitConversion=strcat(inportUnit,{'_'},outportUnit);

                supportedConversion=aObj.getSupportedConversion();


                isSupported=cellfun(@(x)...
                strcmp(x,unitConversion),supportedConversion);

                if~(any(isSupported))
                    out=slci.compatibility.Incompatibility(...
                    aObj,...
                    aObj.getEnum,...
                    aObj.ParentBlock().getName());
                end

            end

        end

    end

end