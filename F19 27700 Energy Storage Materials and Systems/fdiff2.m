function y = fdiff2(xb)
    w=0.1;
    T=298;
    ua0=0.02;
    ub0=0.03;
    k = 8.617*10^-5;%eV/K
    m=T*k;

    ub = (w.*(1-(2.*xb))) + (m.*(log(xb)-log(1-xb))) - ua0 + ub0;
    ucoex = (w.*(1-(2.*0.5))) + (m.*(log(0.5)-log(1-0.5))) - ua0 + ub0;
    y = (ub-ucoex).^2;
end