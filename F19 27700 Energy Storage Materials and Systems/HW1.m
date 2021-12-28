%% Q1.iv
I10 = 0:0.01:0.6;
I50 = 0:0.01:0.6;
Isc10 = 1.1;
Isc50 = 1.2;
P10 = (Isc10 - I10).*I10;
P50 = (Isc50 - I50).*I50;
figure(1)
plot(I10,P10)
hold on
plot(I50,P50)
legend({'SOC = 10%','SOC = 50%'},'Location','northwest')
title('Power Density against Current Density for 10% and 50% SOC')
xlabel('Current Density (A/cm^2)')
ylabel('Power Density (W/cm^2)')
max10 = max(P10);
max50 = max(P50);