%%
P = 1:1:14;
S = 2.*P - 1;
D = 14 - P;
figure(1)
plot(D,P)
hold on
plot(S,P)
hold on
legend({'Demand','Supply'},'Location','northwest')
title('Supply and Demand for Uber Rides')
xlabel('Quantity')
ylabel('Price')

%%
P = 1:1:14;
S = 2.*P - 1;
D = 14 - P;
D2 = 17 - P;
figure(2)
plot(D,P)
hold on
plot(S,P)
hold on
plot(D2,P)
hold on
legend({'Demand','Supply','Demand2'},'Location','southeast')
title('Supply and Demand for Uber Rides')
xlabel('Quantity')
ylabel('Price')