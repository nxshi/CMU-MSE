%%
Xa = 0:0.001:1;
R = 8.314;
t1ds = R.*500.*(Xa.*log(Xa)+(1-Xa).*log(1-Xa));
t2ds = R.*1500.*(Xa.*log(Xa)+(1-Xa).*log(1-Xa));
t3ds = R.*2500.*(Xa.*log(Xa)+(1-Xa).*log(1-Xa));
figure(1)
plot(Xa,t1ds)
hold on
plot(Xa,t2ds)
hold on
plot(Xa,t3ds)
legend({'500K','1500K','2500K'},'Location','southwest')
title('-TdS plot')
xlabel('Xa')
ylabel('-TdS')

%%
a1 = 15000;
a2 = -5000;
dH1 = a1.*Xa.*(1-Xa);
dH2 = a2.*Xa.*(1-Xa);
figure(2)
plot(Xa,dH1)
hold on
plot(Xa,dH2)
legend({'15000 J/mol','-5000 J/mol'},'Location','southwest')
title('dH plot')
xlabel('Xa')
ylabel('dH')

%% a1
dGa1 = dH1+t1ds;
dGa2 = dH1+t2ds;
dGa3 = dH1+t3ds;
figure(3)
plot(Xa,dGa1)
hold on
plot(Xa,dGa2)
hold on
plot(Xa,dGa3)
legend({'500K','1500K','2500K'},'Location','southwest')
title('dG plot at a = 15000 J/mol')
xlabel('Xa')
ylabel('dG')

%% a2
dGa4 = dH2+t1ds;
dGa5 = dH2+t2ds;
dGa6 = dH2+t3ds;
figure(4)
plot(Xa,dGa4)
hold on
plot(Xa,dGa5)
hold on
plot(Xa,dGa6)
legend({'500K','1500K','2500K'},'Location','southwest')
title('dG plot at a = -5000 J/mol')
xlabel('Xa')
ylabel('dG')