close all

%% equilibrium case
To    = 298;
kB    = 8.617*10.^(-5);
muoA  = 0.02;
muoB  = 0.03;
Omega = 0.1;
jratio = 4;
x     = linspace(0.01,0.99,501);
mu_eq = muoB - muoA + kB*To*log(x./(1-x)) + Omega*(1-2*x);
figure(1)
plot(x,mu_eq);
title('Chemical Potential Against Filling Fraction for Li ion in Li-rich phase (equilibrium)')
xlabel('Filling Fraction (x)')
ylabel('Chemical Potential (mu)')
hold on

%find ucoex at =lib
xb     = linspace(0.1,0.9,501);
mu_eq2 = muoB - muoA + kB*To*log(xb./(1-xb)) + Omega*(1-2*xb);
ymax=max(mu_eq2);
ymin=min(mu_eq2);
% xmax=0.1+(find(mu_eq2==ymax)*(0.8/501));
% xmin=0.1+(find(mu_eq2==ymin)*(0.8/501));
ucoex = ymin + (ymax-ymin)/2
hline = refline([0 ucoex]);
hline.Color = 'r';

%find miscibility gap at =lib
points(1) = fzero(@fdiff,0.03);
points(2) = fzero(@fdiff,0.99);
hold on;
plot(points,ucoex,'x')
hold off;
x1 = points(1,1)
x2 = points(1,2)
misc = x2 - x1
figure(2)
g = (1-x).*muoA + x.*muoB + kB.*To.*(x.*log(x)+(1-x).*log(1-x)) +Omega.*x.*(1-x);
plot(x,g)
hold on
gat1=(1-x1)*muoA + x1*muoB + kB*To*(x1*log(x1)+(1-x1)*log(1-x1)) +Omega*x1*(1-x1);
gat2=(1-x2)*muoA + x2*muoB + kB*To*(x2*log(x2)+(1-x2)*log(1-x2)) +Omega*x2*(1-x2);
muat1=muoB - muoA + kB*To*log(x1/(1-x1)) + Omega*(1-2*x1);
muat2=muoB - muoA + kB*To*log(x2/(1-x2)) + Omega*(1-2*x2);
T_coex = (Omega)*(1-2*x1)/(kB*log((1-x1)/x1));
tslope = (gat2-gat1)/(misc);
tangent = tslope*x + (gat1-tslope*(x1));
plot (x,tangent,'-.')
title('Free Energy Against Filling Fraction for Li ion in Li-rich phase (equilibrium)')
xlabel('Filling Fraction (x)')
ylabel('Free Eneergy (G)')

%% BV case
eta = 2*kB*To*asinh(2./(1-x));
mu_b = mu_eq + eta;
figure(3)
plot(x,mu_b);
hold on
title('Chemical Potential Against Filling Fraction for Li ion in Li-rich phase (Butler-Volmer)')
xlabel('Filling Fraction (x)')
ylabel('Chemical Potential (mu)')

%find miscibility gap at
ymax2 = findpeaks(mu_b)
ymin2 = -findpeaks(-mu_b,'MinPeakDistance', 20)
ucoex2 = ymin2 + (ymax2-ymin2)/2
points(1) = fzero(@fdiff2,0.10);
points(2) = fzero(@fdiff2,0.70);
hold on;
plot(points,ucoex2,'x')
hold off;
x1bv = points(1,1)
x2bv = points(1,2)
miscbv = x2bv-x1bv

%% Marcus case
Lambda = 0.1;
eta2 = Lambda + sqrt(4.*Lambda.*kB.*To.*log(4./(1-x)));
mu_m = mu_eq + eta2;
figure(4)
plot(x,mu_m)
hold on
title('Chemical Potential Against Filling Fraction for Li ion in Li-rich phase (Marcus)')
xlabel('Filling Fraction (x)')
ylabel('Chemical Potential (mu)')

%find miscibility gap at
ymax3 = findpeaks(mu_m)
ymin3 = -findpeaks(-mu_m,'MinPeakDistance', 20)
ucoex3 = ymin3 + (ymax3-ymin3)/2
points(1) = fzero(@fdiff3,0.20);
points(2) = fzero(@fdiff3,0.65);
hold on;
plot(points,ucoex3,'x')
hold off;
x1m = points(1,1)
x2m = points(1,2)
miscm = x2m-x1m

%% BV + M case
mu_bvm = mu_eq + eta + eta2;
figure(5)
plot(x,mu_bvm)
hold on
title('Chemical Potential Against Filling Fraction for Li ion in Li-rich phase (Butler-Volmer and Marcus)')
xlabel('Filling Fraction (x)')
ylabel('Chemical Potential (mu)')

%find miscibility gap at
ymax4 = findpeaks(mu_bvm)
ymin4 = -findpeaks(-mu_bvm,'MinPeakDistance', 20)
ucoex4 = ymin4 + (ymax4-ymin4)/2
points(1) = fzero(@fdiff4,0.15);
points(2) = fzero(@fdiff4,0.75);
hold on;
plot(points,ucoex4,'x')
hold on;
hline2 = line([points(1,1),points(1,2)],[ucoex4,ucoex4]);
hline2.Color = 'r';
hold off;
x1bvm = points(1,1)
x2bvm = points(1,2)
miscbvm = x2bvm-x1bvm

%% functions

function y = fdiff(x)

To    = 298;
kB    = 8.617*10.^(-5);
muoA  = 0.02;
muoB  = 0.03;
Omega = 0.1;

mu_eq = muoB - muoA + kB*To*log(x./(1-x)) + Omega*(1-2*x);
y = mu_eq - 0.01;

end

function y = fdiff2(x)

To    = 298;
kB    = 8.617*10.^(-5);
muoA  = 0.02;
muoB  = 0.03;
Omega = 0.1;

mu_eq = muoB - muoA + kB*To*log(x./(1-x)) + Omega*(1-2*x);
eta = 2*kB*To*asinh(2./(1-x));
mu_b = mu_eq + eta;
y = mu_b - 0.1185;

end

function y = fdiff3(x)

To    = 298;
kB    = 8.617*10.^(-5);
muoA  = 0.02;
muoB  = 0.03;
Omega = 0.1;

mu_eq = muoB - muoA + kB*To*log(x./(1-x)) + Omega*(1-2*x);
Lambda = 0.1;
eta2 = Lambda + sqrt(4.*Lambda.*kB.*To.*log(4./(1-x)));
mu_m = mu_eq + eta2;
y = mu_m - 0.2586;

end

function y = fdiff4(x)

To    = 298;
kB    = 8.617*10.^(-5);
muoA  = 0.02;
muoB  = 0.03;
Omega = 0.1;

mu_eq = muoB - muoA + kB*To*log(x./(1-x)) + Omega*(1-2*x);
eta = 2*kB*To*asinh(2./(1-x));
Lambda = 0.1;
eta2 = Lambda + sqrt(4.*Lambda.*kB.*To.*log(4./(1-x)));
mu_bvm = mu_eq + eta + eta2;
y = mu_bvm - 0.0764;

end