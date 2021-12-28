%% Q2
f = 0.001;
b = 2.5*10^-4;
d = 1:0.5:100;
sig = 5.9.*((f^(1/2))./(d./1000)).*log((d./1000)./b);
sig = 5.9.*((f^(1/2))./(d./1000)).*log((d./1000)./b);
figure(1)
plot(d,sig)
hold on
title('increased strength vs. average precipitate diamter plot')
xlabel('average precipitate diameter (nm)')
ylabel('increased strength (MPa)')

%% Q2
R = 8.314;
x = 0.01:0.01:1;
dGma = 1050.*x + R.*1500.*((1-x).*log(1-x)+x.*log(x));
dGml = 4500.*(1-x) + R.*850.*((1-x).*log(1-x)+x.*log(x));
figure(2)
hold on
title('dG vs. XNe plot')
xlabel('XNe')
ylabel('dG')
legend({'dGma','dGml'},'Location','northwest')