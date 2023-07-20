function elementSchema=f8port_noise_rf(~)








    elementSchema=ne_lookupschema(@schema);

end

function schema=schema

    schema=NetworkEngine.ElementSchemaBuilder('f8port_noise_rf');
    schema.descriptor='F8PORT_NOISE_RF';


    p1=schema.terminal('p1');
    p1.description='Positive terminal 1';
    p1.domain=foundation.rf.circuitenvelope;
    p1.label='+1';
    p1.location={'left'};

    n1=schema.terminal('n1');
    n1.description='Negative terminal 1';
    n1.domain=foundation.rf.circuitenvelope;
    n1.label='-1';
    n1.location={'left'};

    p2=schema.terminal('p2');
    p2.description='Positive terminal 2';
    p2.domain=foundation.rf.circuitenvelope;
    p2.label='+2';
    p2.location={'right'};

    n2=schema.terminal('n2');
    n2.description='Negative terminal 2';
    n2.domain=foundation.rf.circuitenvelope;
    n2.label='-2';
    n2.location={'right'};

    p3=schema.terminal('p3');
    p3.description='Positive terminal 3';
    p3.domain=foundation.rf.circuitenvelope;
    p3.label='+3';
    p3.location={'left'};

    n3=schema.terminal('n3');
    n3.description='Negative terminal 3';
    n3.domain=foundation.rf.circuitenvelope;
    n3.label='-3';
    n3.location={'left'};

    p4=schema.terminal('p4');
    p4.description='Positive terminal 4';
    p4.domain=foundation.rf.circuitenvelope;
    p4.label='+4';
    p4.location={'right'};

    n4=schema.terminal('n4');
    n4.description='Negative terminal 4';
    n4.domain=foundation.rf.circuitenvelope;
    n4.label='-4';
    n4.location={'right'};

    p5=schema.terminal('p5');
    p5.description='Positive terminal 5';
    p5.domain=foundation.rf.circuitenvelope;
    p5.label='+5';
    p5.location={'left'};

    n5=schema.terminal('n5');
    n5.description='Negative terminal 5';
    n5.domain=foundation.rf.circuitenvelope;
    n5.label='-5';
    n5.location={'left'};

    p6=schema.terminal('p6');
    p6.description='Positive terminal 6';
    p6.domain=foundation.rf.circuitenvelope;
    p6.label='+6';
    p6.location={'right'};

    n6=schema.terminal('n6');
    n6.description='Negative terminal 6';
    n6.domain=foundation.rf.circuitenvelope;
    n6.label='-6';
    n6.location={'right'};

    p7=schema.terminal('p7');
    p7.description='Positive terminal 7';
    p7.domain=foundation.rf.circuitenvelope;
    p7.label='+7';
    p7.location={'left'};

    n7=schema.terminal('n7');
    n7.description='Negative terminal 7';
    n7.domain=foundation.rf.circuitenvelope;
    n7.label='-7';
    n7.location={'left'};

    p8=schema.terminal('p8');
    p8.description='Positive terminal 8';
    p8.domain=foundation.rf.circuitenvelope;
    p8.label='+8';
    p8.location={'right'};

    n8=schema.terminal('n8');
    n8.description='Negative terminal 8';
    n8.domain=foundation.rf.circuitenvelope;
    n8.label='-8';
    n8.location={'right'};

    vn1=schema.input('noise1');
    vn1.description='Port 1 noise';
    vn1.type=ne_type('real',[1,1],'V');
    vn1.label='n1';
    vn1.location={'left'};

    vn2=schema.input('noise2');
    vn2.description='Port 2 noise';
    vn2.type=ne_type('real',[1,1],'V');
    vn2.label='n2';
    vn2.location={'right'};

    vn3=schema.input('noise3');
    vn3.description='Port 3 noise';
    vn3.type=ne_type('real',[1,1],'V');
    vn3.label='n3';
    vn3.location={'left'};

    vn4=schema.input('noise4');
    vn4.description='Port 4 noise';
    vn4.type=ne_type('real',[1,1],'V');
    vn4.label='n4';
    vn4.location={'right'};

    vn5=schema.input('noise5');
    vn5.description='Port 5 noise';
    vn5.type=ne_type('real',[1,1],'V');
    vn5.label='n5';
    vn5.location={'left'};

    vn6=schema.input('noise6');
    vn6.description='Port 6 noise';
    vn6.type=ne_type('real',[1,1],'V');
    vn6.label='n6';
    vn6.location={'right'};

    vn7=schema.input('noise7');
    vn7.description='Port 7 noise';
    vn7.type=ne_type('real',[1,1],'V');
    vn7.label='n7';
    vn7.location={'left'};

    vn8=schema.input('noise8');
    vn8.description='Port 8 noise';
    vn8.type=ne_type('real',[1,1],'V');
    vn8.label='n8';
    vn8.location={'right'};


    ZO=schema.parameter('ZO');
    ZO.description='Resistive impedance, ZO';
    ZO.type=ne_type('real','variable','Ohm');
    ZO.default={ones(1,8)*50,'Ohm'};

    tau=schema.parameter('tau');
    tau.description='Impulse response length, tau';
    tau.type=ne_type('real','variable','s');
    tau.default={ones(1,1)*0,'s'};

    freqs=schema.parameter('freqs');
    freqs.description='Vector of frequencies';
    freqs.type=ne_type('real','variable','Hz');

    freqs.default={[0,1e6],'Hz'};

    S=schema.parameter('S');
    S.description='S-data in a [real, imag] row-wise format';
    S.type=ne_type('real','variable','1');

    S.default=ones(1,256);

    schema.setup(@setup);

    schema=schema.finish();
end

function setup(src)

    num_ports=8;
    hasNoise=true;

    simrfV2_sbox_setup_freq_domain(src,num_ports,hasNoise)

end
