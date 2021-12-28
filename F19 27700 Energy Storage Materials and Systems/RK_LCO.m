clear all;
data_graph = load('LCO.csv');

kT = 0.0259;
syms k x

col = {'.','-.','-'}
n_m = 6;
x_f = 0.45:0.01:0.99;
for i=2:2:n_m
    n = i;
    for j=1:n+1
        c_v{j}=sprintf('a%d', j);
    end
    a = sym('a',[1 n+1]);
    
    f1 = (1-2*x)^(k+1);
    f2 = -2*k*x*(1-x)*(1-2*x)^(k-1);
    f3 = kT * log(x/(1-x));
    
    V = sum(subs((f1+f2),k,0:n).*a);
    
    My_Equation = char(V+f3);
    
    [ fitresult, gof ] = custom_fit(data_graph(:,1),-data_graph(:,2),My_Equation,c_v);
    
    clear c_v a;
    SSE(n) = log(gof.sse);
    BIC(n) = log(gof.sse) + 2*n;
    plot(x_f,-feval(fitresult,x_f),[col{i/2} 'k'],'LineWidth',4,'MarkerSize',12);
    hold on
end
plot(data_graph(:,1),data_graph(:,2),'ob','MarkerSize',12)
hold on
xlabel('x','FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
ylabel('U (V)','FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
set(gcf,'Color','w');
set(gca,'FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
xlim([0.45 0.99])
hl=legend('R-K fit 2nd order','R-K fit 4th order','R-K fit 6th order','Experimental Data')
set(hl,'Box','off')
BIC
grid on
