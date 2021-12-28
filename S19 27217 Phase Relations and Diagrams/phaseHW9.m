%% Q2
fs = 0:0.001:0.95;
c0 = 0.005;
k1 = 0.1;
k2 = 0.9;
k3 = 1.1;
cs1 = k1.*c0.*(1-fs).^(k1-1);
cs2 = k2.*c0.*(1-fs).^(k2-1);
cs3 = k3.*c0.*(1-fs).^(k3-1);
figure(1)
plot(fs,cs1)
hold on
plot(fs,cs2)
hold on
plot(fs,cs3)
legend({'k=0.1','k=0.9','k=1.1'},'Location','northwest')
title('fs vs. Cs plot for Scheil Conditions')
xlabel('fs')
ylabel('Cs')

%% Q3
l1 = 0.001;
l2 = 0.0005;
x1 = linspace(0,10*l1/pi,100);
x2 = linspace(0,20*l2/pi,100);
cmin = 0.02;
cmax = 0.22;
b0 = (cmin+cmax)/2;
D0 = 1.3; %cm^2/s
Q = 184096; %kcal/mol
R = 8.314; %J/molK
T = 775+273.15; %K
D = D0*exp(-Q/(R*T));
tau1 = l1^2/(D*pi^2);
tau2 = l2^2/(D*pi^2);
%at half amplitude
t1 = tau1;
t2 = tau2;
cbar = cmin + b0;
%for l1
c01 = cbar + b0.*sin(pi.*x1/l1);
cx1 = cbar + b0.*exp(-t1/tau1).*sin(pi.*x1/l1);
%for l2
c02 = cbar + b0.*sin(pi.*x2/l2);
cx2 = cbar + b0.*exp(-t2/tau2).*sin(pi.*x2/l2);
figure(2)
plot(x1,c01)
hold on
plot(x1,cx1)
hold on
plot(x2,c02)
hold on
plot(x2,cx2)
hold on
plot(x2,cbar*ones(size(x2)))
legend({'t = 0s when l = 10um','t =  116.55s when l = 10um','t = 0s when l = 5um','t = tau = 29.14s when l = 5um'},'Location','northeast')
title('Homogenization of a Bronze Alloy')
xlabel('x (cm)')
ylabel('C (weight % Sn))')