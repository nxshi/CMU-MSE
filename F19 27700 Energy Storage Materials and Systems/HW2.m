close all

xb=0.0001:0.0001:0.9999;
%Qii
w=0.1;
T=298;
ua0=0.02;
ub0=0.03;
k = 8.617*10^-5;%eV/K
m=T*k;
ub = (w.*(1-(2.*xb))) + (m.*(log(xb)-log(1-xb))) - ua0 + ub0;
figure(1)
l1 = plot(xb,ub);
hold on
ucoex = (w.*(1-(2.*0.5))) + (m.*(log(0.5)-log(1-0.5))) - ua0 + ub0;
l2 = plot(xb,ucoex*ones(size(xb)));
title('Chemical Potential Against Filling Fraction for Li ion in Li-rich phase')
xlabel('x')
ylabel('ub')
legend({'ub','ucoex'},'Location','northwest')
points(1) = fminsearch(@fdiff2,0.01);
points(2) = fminsearch(@fdiff2,0.5);
points(3) = fminsearch(@fdiff2,0.99);
plot(points,ucoex,'x')
points
%Qiv
dp2=ub + 2.*k.*T.*asinh(4.*2./(1-xb));
dp10=ub + 2.*k.*T.*asinh(4.*10./(1-xb));
dp20=ub + 2.*k.*T.*asinh(4.*20./(1-xb));
dp30=ub + 2.*k.*T.*asinh(4.*30./(1-xb));
dp40=ub + 2.*k.*T.*asinh(4.*40./(1-xb));
dp50=ub + 2.*k.*T.*asinh(4.*50./(1-xb));
figure(2)
plot(xb,dp2)
hold on
plot(xb,dp10)
hold on
plot(xb,dp20)
hold on
plot(xb,dp30)
hold on
plot(xb,dp40)
hold on
plot(xb,dp50)
hold on
legend({'2C','10C','20C','30C','40C','50C'},'Location','northwest')
title('Non-equilibrium Chemical Potential Against Filling Fraction for Li ion in Li-rich phases')
xlabel('x')
ylabel('ub')
%Qv
figure(3)
plot(xb,3.4-dp2)
hold on
plot(xb,3.4-dp10)
hold on
plot(xb,3.4-dp20)
hold on
plot(xb,3.4-dp30)
hold on
plot(xb,3.4-dp40)
hold on
plot(xb,3.4-dp50)
hold on
legend({'2C','10C','20C','30C','40C','50C'},'Location','northeast')
title('Voltage Against Filling Fraction for Li ion in Li-rich phases')
xlabel('x')
ylabel('V')
figure(4)
plot(xb*170,3.4-dp2)
hold on
plot(xb*170,3.4-dp10)
hold on
plot(xb*170,3.4-dp20)
hold on
plot(xb*170,3.4-dp30)
hold on
plot(xb*170,3.4-dp40)
hold on
plot(xb*170,3.4-dp50)
legend({'2C','10C','20C','30C','40C','50C'},'Location','northeast')
title('Voltage Against Theoretical Capacity for Li ion in Li-rich phases')
xlabel('capacity (mAh/g)')
ylabel('Voltage (V)')
%Qvi
figure(5)
t=[2,10,20,30,40,50];
syms x
int2=3.4 - int((w.*(1-(2.*x))) + (m.*(log(x)-log(1-x))) - ua0 + ub0 + 2.*k.*T.*asinh(4.*2./(1-x)),[0 1]);
int10=3.4 - int((w.*(1-(2.*x))) + (m.*(log(x)-log(1-x))) - ua0 + ub0 + 2.*k.*T.*asinh(4.*10./(1-x)),[0 1]);
int20=3.4 - int((w.*(1-(2.*x))) + (m.*(log(x)-log(1-x))) - ua0 + ub0 + 2.*k.*T.*asinh(4.*20./(1-x)),[0 1]);
int30=3.4 - int((w.*(1-(2.*x))) + (m.*(log(x)-log(1-x))) - ua0 + ub0 + 2.*k.*T.*asinh(4.*30./(1-x)),[0 1]);
int40=3.4 - int((w.*(1-(2.*x))) + (m.*(log(x)-log(1-x))) - ua0 + ub0 + 2.*k.*T.*asinh(4.*40./(1-x)),[0 1]);
int50=3.4 - int((w.*(1-(2.*x))) + (m.*(log(x)-log(1-x))) - ua0 + ub0 + 2.*k.*T.*asinh(4.*50./(1-x)),[0 1]);
y=[int2,int10,int20,int30,int40,int50];
plot(t,y)
title('Average Cell Voltage Against C-rate for Li ion in Li-rich phases')
xlabel('C')
ylabel('Average Voltage (V)')