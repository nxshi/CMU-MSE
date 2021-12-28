close all;

data_graph = load('graphite.csv');

kT = 0.0259;
syms k x

col = {'.','-.','-'}
nlist = [6 11]
x_f = min(data_graph):0.01:max(data_graph);
for i= 1:2
    n = nlist(i);
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
    SSE(i) = log(gof.sse);
    BIC(i) = log(gof.sse) + 2*n;
    
    % plot data
    figure(2+i); hold off;
    plot(x_f,-feval(fitresult,x_f),[col{i} 'k'],'LineWidth',4,'MarkerSize',12);
    hold on
    plot(data_graph(:,1),data_graph(:,2),'ob','MarkerSize',12)
    hold off;
    xlabel('x','FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
    ylabel('U (V)','FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
    set(gcf,'Color','w');
    set(gca,'FontName','Arial','FontSize',20,'LineWidth',4,'FontWeight','bold')
    xlim([0.01 1.00])
    hl=legend('R-K fit','Experimental Data');
    set(hl,'Box','off');
    if i==1,
        title('6th order R-K fit');
    else
        title('Graphite R-K fit');
    end
    grid on
end
BIC

% custom_fit.m from RK.zip
function [ fitresult, gof ] = custom_fit(x,z,My_Equation,coeffs_v)

[xData,zData] = prepareCurveData( x, z);

% Set up fittype and options.
ft = fittype(My_Equation, 'independent', {'x'},'dependent','z','coefficients',coeffs_v);
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = ones(1,length(coeffs_v));

% Fit model to data.
[fitresult, gof] = fit( [xData],zData, ft, opts );

end
