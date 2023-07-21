function[Yss,Xss,tau,YoDC,XoDC,MV,DCR,DCalphaV,DCalphaD]=WelementStateSpaces(Nconductors,len,L,C,Ro,Go,Rs,Gd,risetime)
%#codegen



    cc=1==1;

    targetTol=-60;

    n=int32(Nconductors);
    nsq=n^2;
    ntri=rf.internal.wline.mltle_ntri(Nconductors);
    Lmat=rf.internal.wline.vecToSymMat(L,Nconductors,ntri);
    Cmat=rf.internal.wline.vecToSymMat(C,Nconductors,ntri);
    Romat=rf.internal.wline.vecToSymMat(Ro,Nconductors,ntri);
    Gomat=rf.internal.wline.vecToSymMat(Go,Nconductors,ntri);
    Rsmat=rf.internal.wline.vecToSymMat(Rs,Nconductors,ntri);
    Gdmat=rf.internal.wline.vecToSymMat(Gd,Nconductors,ntri);

    DCR=len*Romat;
    RG=Romat*Gomat;
    [VRG,DRG]=eig(RG);
    DCalphaV=real(VRG);
    DCalphaD=sqrt(real(diag(DRG)))*len;

    fmin=10;
    if risetime==0
        fmax=1e12;
    else
        fmax=1000/risetime;
    end
    f=[0;logspace(log10(fmin),log10(fmax),2001).'];
    coder.varsize('f');
    nf=int32(numel(f));
    f3d=repmat(reshape(f,1,1,nf),n,n,1);
    Lf=repmat(Lmat,1,1,nf);
    Linf=Lmat;
    Ro3d=repmat(Romat,1,1,nf);
    if any(Rsmat(:)~=0)



        Zskin=Ro3d+repmat(Rsmat,1,1,nf).*sqrt(2i*f3d);
        Rf=real(Zskin);
        Lskin=imag(Zskin)./(2*pi*f3d);
        Lskin(:,:,1)=0;
        if cc
            Lf=Lf+Lskin;
        end
    else
        Rf=Ro3d;
    end

    if all(Gdmat(:)==0)
        Cf=repmat(Cmat,1,1,nf);
        Gf=repmat(Gomat,1,1,nf);
        Cinf=Cmat;
    else
        if cc


            [Cf,Gf,Cinf]=rf.internal.wline.GCCausalityCorrection(Cmat,Gomat,Gdmat,f,1e3,1e12,1e10);

        else
            [Cf,Gf,Cinf]=noGCCausalityCorrection(Cmat,Gomat,Gdmat,f);
        end
    end

    [Yo,Xo,tau,MV,YoDC]=rf.internal.wline.rlgctable2yx(f,len,Rf,Lf,Gf,Cf,Linf,Cinf);


...
...
...
...
...
...
...
...
    coder.varsize('Xo');
    coder.varsize('Yo');
    XoDC=real(Xo(1:n,1:n,1));
    args.Tolerance=targetTol;
    if isempty(coder.target)
        args.Display='on';
    else
        args.Display='off';
    end
    args.MaxPoles=2000;
    args.TendsToZero=false;
    args.Causal=true;
    args.NoiseFloor=-Inf;
    args.QLimit=Inf;
    args.ErrorMetric='default';
    args.ColumnReduce=false;





    Yo2D=reshape(Yo,nsq,nf).';
    Xo2D=reshape(Xo,nsq,nf).';
    XoVecNorm=vecnorm(Xo2D);
    maxXoVecNorm=max(XoVecNorm);
...
...
...
    Yscale=max(abs(Yo2D(:)));
    YX=[Yo2D/Yscale,Xo2D-0.5];


    [YXa,YXc,YXd,YXerr,YXerr1]=rf.internal.rational.fitterImpl(f,YX,2*nsq,args);

    Yss.a=cell(n,1);
    Yss.c=cell(n,1);
    Yss.d=zeros(n,n);
    Yd1=zeros(n,n);
    indx=1;
    for i=1:n
        tempa=YXa{indx};
        tempc=complex(zeros(n,numel(tempa)));
        for j=1:n
            tempc(j,:)=YXc{indx}*Yscale;
            indx=indx+1;
        end

        for j=1:n
            ttj=tempc(j,:).';
            Yd1(i,j)=real(Yo(i,j,1))+real(sum(ttj./tempa));
        end
        Yss.a{i}=tempa;
        Yss.c{i}=tempc;
    end
    if 1==1
        Yss.d=Yd1;
    else
        Yss.d=reshape(YXd(1:nsq)*Yscale,n,n);
    end

    Xss.a=cell(n,n);
    Xss.c=cell(n,n);
    Xss.d=zeros(n,n);
    Xd1=zeros(n,n);
    nnzX=0;
    for j=1:n
        for i=1:n
            if XoVecNorm(indx-nsq)>1e-10*maxXoVecNorm
                Xss.a{i,j}=YXa{indx};
                Xss.c{i,j}=YXc{indx}.';
                nnzX=nnzX+1;
                Xd1(i,j)=real(Xo(i,j,1))+real(sum(YXc{indx}./YXa{indx}));
            else
                Xd1(i,j)=real(Xo(i,j,1));
            end
            indx=indx+1;
        end
    end
    if 1==1

        Xss.d=Xd1;
    else
        Xss.d=reshape(YXd(nsq+1:2*nsq),n,n)+0.5;
    end
...
...
...
...
...

...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...
...

end

function[Cf,Gf,Cinf]=noGCCausalityCorrection(Co,Go,Gd,f)
    n=size(Co,1);
    nf=numel(f);
    f3d=repmat(reshape(f,1,1,nf),n,n,1);
    Cf=repmat(Co,1,1,nf);
    Cinf=Co;
    Gf=repmat(Go,1,1,nf)+repmat(Gd,1,1,nf).*f3d;
end
