%% Q2
T = 273:1:373;
dH = 41090;
R = 8.314;
lnP = -dH./(R.*T);
figure(1)
plot(T,lnP)
hold on
title('lnP vs. T plot')
xlabel('T')
ylabel('lnP')

%% Q2
R = 8.314;
x = 0.01:0.01:1;
dGma = 1050.*x + R.*1500.*((1-x).*log(1-x)+x.*log(x));
dGml = 4500.*(1-x) + R.*850.*((1-x).*log(1-x)+x.*log(x));
figure(2)
plot(x,dGma)
hold on
plot(x,dGml)
title('dG vs. XNe plot')
xlabel('XNe')
ylabel('dG')
legend({'dGma','dGml'},'Location','northwest')