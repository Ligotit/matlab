function v_settings=block_validate_settings(this,hC)%#ok





    v_settings=struct;

    v_settings.checkcomplex=false;
    v_settings.checknfp=false;
    v_settings.checknfpdouble=false;
    v_settings.checknfphalf=false;
    v_settings.checkmatrices=true;
    v_settings.maxsupporteddimension=2;
end