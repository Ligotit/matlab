%#codegen

function op=op_cast_uint32_to_emfloat(a)
    coder.allowpcode('plain');
    coder.inline('never');

    t=single(a);
    op=typecast(t,'uint32');

end