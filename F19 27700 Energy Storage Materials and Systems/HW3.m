logI = [0.9444,1.1771,1.3376,1.554,1.7069,1.8275,1.9803,2.1092,2.3188,2.4561,2.6740];
overpotential = [0.0045,0.0109,0.0147,0.0221,0.0271,0.0325,0.0409,0.0485,0.0636,0.0756,0.0935];
k = 8.617*10^-5;
T = 298;
o = 0:0.001:0.1;
j0 = 17;
a = 0.5;
n = 2;
R = 8.314;
F = 96485;
A = 25;
l = 25000;
logj=log10(j0*2*sinh(a*n*o/(k*T))); %BV
logK = log10(j0*A*(exp(-((l-F*o).^2)/(4*l*R*T))-exp(-((l+F*o).^2)/(4*l*R*T)))); %Marcus
xlabel('Overpotential (V)')
ylabel('Activity log(I)')
title({'Experimental Data for Activity vs. Overpotential','for Zinc Deposition from 0.1 M ZnSO4 Solution'})
hold off
plot(overpotential,logI, 'x')
hold on
plot(o,logj)
hold on
plot(o,logK)
legend('Experimental Data','Butler-Volmer','Marcus','Location','northwest')
xlabel('Overpotential (V)')
ylabel('Activity log(rate)')
title({'Activity vs. Overpotential','for Zinc Deposition from 0.1 M ZnSO4 Solution'})