clear all
close all

%% solve for k
% at x = 0, e1 = 0.1, de1 = -0.1
syms x k b1 b2
e_init = 0.1;
ld_ion = 10;
ld_solid = 2;
lsp = 0.5;
e1 = e_init.*(((4./(4-(k.^2).*lsp.^2)).*exp(-k.*x)) ...
    + ((k.^2.*lsp.^2)/(k.^2.*lsp.^2 - 4).*exp(-2*x./lsp)));
e2 = (b1 + b2.*x).*exp((-sqrt(2).*x)/ld_ion);
de1 = diff(e1,x);
de2 = diff(e2,x);
k = 1.333;
x = 0;
de1 = (2*k*exp(-k*x))/(5*(k^2/4 - 4)) - (k^2*exp(-4*x))/(10*(k^2/4 - 4));

%% solve for b1 and b2
x = 2;
de1solve = (2*k*exp(-k*x))/(5*(k^2/4 - 4)) - (k^2*exp(-4*x))/(10*(k^2/4 - 4));
de2solve = b2*exp(-(2^(1/2)*x)/10) - (2^(1/2)*exp(-(2^(1/2)*x)/10)*(b1 + b2*x))/10;
ls = 2;
le1 = e_init.*(((4./(4-(k.^2).*lsp.^2)).*exp(-k.*ls)) ...
    + ((k.^2.*lsp.^2)/(k.^2.*lsp.^2 - 4).*exp(-2*ls./lsp)));
le2 = (b1 + b2.*ls).*exp((-sqrt(2).*ls)/ld_ion);
% set boundary conditions equal to each other
eqn1 = le1 == le2;
eqn2 = de2solve == de1solve;
sol = solve([eqn1, eqn2], [b1, b2]);
b1 = sol.b1;
b2 = sol.b2;

%% plotting
x1 = 0:0.01:ls;
x2 = ls:0.01:50;
b1 = 5744714693962210653924714757459/163837363540038583958562357237888;
b2 = -1011311164896338273340231194491/81918681770019291979281178618944;
e1 = e_init.*(((4./(4-(k.^2).*lsp.^2)).*exp(-k.*x1)) ...
    + ((k.^2.*lsp.^2)/(k.^2.*lsp.^2 - 4).*exp(-2*x1./lsp)));
e2 = (b1 + b2.*x2).*exp((-sqrt(2).*x2)/ld_ion);
plot(x1,e1)
hold on
plot(x2,e2)
ylabel('Electrostatic Potential (V)')
xlabel('x (nm)')
legend('Solid Electrolyte Interphase','Ionic Liquid Electrolyte')