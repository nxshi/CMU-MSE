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