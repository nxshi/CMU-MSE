clear all
close all

%% lco brugg
lco = load('lco.txt');
lporo = lco(:,1);
ltort = lco(:,2);
figure(1)
plot(lporo,ltort,'.')
hold on
lasphere = 1.221; %using cftool
lacylinder = 0.8546;
le = 0.35:0.001:0.65;
lsphere = lasphere.*le.^-0.5;
lcylinder = lacylinder.*le.^-1;
plot(le,lsphere)
hold on
plot(le,lcylinder)
title('LCO')
xlabel('Porosity')
ylabel('Tortuosity')
legend('Data','Sphere','Cylinder')


%% graphite brugg
graphite = load('graphite.txt');
gporo = graphite(:,1);
gtort = graphite(:,2);
figure(2)
plot(gporo,gtort,'.')
hold on
gasphere = 2.759; %using cftool
gacylinder = 1.941;
ge = 0.35:0.001:0.7;
gsphere = gasphere.*ge.^-0.5;
gcylinder = gacylinder.*ge.^-1;
plot(ge,gsphere)
hold on
plot(ge,gcylinder)
title('Graphite')
xlabel('Porosity')
ylabel('Tortuosity')
legend('Data','Sphere','Cylinder')

%% lco perc
lcrit = -0.07; %using cftool
lcrit1 = 1e-10;
lperc = le.*((1-lcrit)./(le-lcrit)).^2;
lperc1 = le.*((1-lcrit1)./(le-lcrit1)).^2;
figure(3)
plot(lporo,ltort,'.')
hold on
plot(le,lperc)
plot(le,lperc1)
title('LCO')
xlabel('Porosity')
ylabel('Tortuosity')
legend('Data','Negative Porosity','Positive Porosity')

%% graphite perc
gcrit = 0.18; %using cftool
gperc = ge.*((1-gcrit)./(ge-gcrit)).^2;
figure(4)
plot(gporo,gtort,'.')
hold on
plot(ge,gperc)
title('Graphite')
xlabel('Porosity')
ylabel('Tortuosity')