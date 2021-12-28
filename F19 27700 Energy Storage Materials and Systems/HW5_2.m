clear all;
data_graph = load('nca.csv');

kT = 0.0259;
syms k x

col = {'.','-.','-'};
x_f = min(data_graph):0.01:max(data_graph);
n_m = [6 11];
for i=1:2
    n = n_m(i);
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
    
    
    % plot data
    figure(2+i); hold off;
    plot(x_f*4,-feval(fitresult,x_f),[col{i} 'k'],'LineWidth',4,'MarkerSize',12);
    hold on
    plot(data_graph(:,1)*4,data_graph(:,2),'ob','MarkerSize',12)
    hold off;
    xlabel('x','FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
    ylabel('U (V)','FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
    set(gcf,'Color','w');
    set(gca,'FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
    xlim([0.01 4.00])
    hl=legend('R-K fit','Experimental Data');
    set(hl,'Box','off');
    if i==1,
        title('6th order R-K fit');
    else
        title('11th order R-K fit');
    end
    grid on
end
BIC

