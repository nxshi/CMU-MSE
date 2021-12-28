close all
[p,U] = meshgrid(linspace(0,1),linspace(0,.1));
goh = (0.9/14)-(0.636514*0.0259)-(0.0259.*log(p))./42;
theta = 1./(1+exp((goh - (exp(1).*U))./0.0259));
C = contourf(p,U,theta);
xlabel('pressure of water vapor (p)')
ylabel('electrode potential (U)')
title('Plot of Coverage as a Function of Pressure and Electrode Potential')
clabel(C)
colormap summer