function[V,Idc]=FunctionFullBridge(g,Vdc,I)
%#codegen
    coder.allowpcode('plain');
    dataType='double';
    V=zeros(2,1,dataType);
    V(1)=-1.0*(g(2)+g(3)-1)*Vdc;
    V(2)=-1.0*(g(1)+g(4)-1)*Vdc;
    Idc=((g(2)+g(3)-1)*I(1))+((g(1)+g(4)-1)*I(2));
    if((g(1)+g(2)+g(3)+g(4))==4)
        Idc=I(1);
        V(1)=-Vdc;
        V(2)=-Vdc;
    end