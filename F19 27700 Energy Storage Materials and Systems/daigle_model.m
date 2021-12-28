%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Leif Fredericks, Shashank Sripad, Venkat Viswanathan                  %%
%% Carnegie Mellon University                                            %%
%% Discharge Model for A3 Airbus Vahana Battery Data                     %%
%% Created: 09/14/2018                                                   %%
%% Dependencies: Open circuit potentials of electrodes                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The model shown here is based on other published work and repuposed for
% use in HW5, Energy Storage: Materials & Systems by Venkat Viswanathan
% Citation:
% Matthew Daigle and Chetan S. Kulkarni. 
% "Electrochemistry-based Battery Modeling for Prognostics"
% https://ntrs.nasa.gov/archive/nasa/casi.ntrs.nasa.gov/20140009120.pdf
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% NOTE THAT THE CODEBLOCK PRESENTED HERE IS FOR THE PURPOSE OF THE CLASS %
%% HOMEWORK AND THE CODE IS INTENTIONALLY NOT IN A FULLY USABLE FORM      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 
clear
close all

Power = xlsread('HW5.xlsx');
data = Power(:,1);
data = [data; data];

% List of parameters
    q_max        = 3040*10;  % Maximum charge in the cell (Samsung)     [C]
    S_p          = 1e-4;   % Surface area of the cathode    [m^2]
    v_sp         = 10e-6;
    v_bp         = 2e-5;
    S_n          = 4e-4;
    v_sn         = 4e-6;
    v_bn         = 2e-5;
    R            = 8.314;   % Universal gas constant            [J/mol.K]
    F            = 86485;   % Faraday's constant                [C/mol]
    n            = 1;       % Number of electrions              
    alpha        = 0.5;     % Symmetry factor
    cutoff       = 2.5;     % Lower Voltage Cutoff              [V]
    xp_init      = 0.53;    % Initial cathode filling fraction
    xn_init      = 0.36;    % Initial anode filling fraction
    iappRef      = 3*ones(length(data),1); % Current input array     [A]
    dt           = 3;       % time discretization in iappRef    [s]
    iapp         = iappRef; % Current                           [Amp]
    Tamb         = 298;     % Ambient Temperature
    Temp         = Tamb*ones(length(data),1);    % Temperature   [K]
    d            = 0;       % State of Discharge
    % Note that the heating model is not accurately implement and is part
    % of Homework 5 to implement a thermal model
    r_temp       = 298;     % Radiative cooling                 [K]
    C_T          = 1e3;     % Specific heat capacity            [J/kg.K]
    S_T          = 20;      % Entropic contribution to heating  
    
    % Other cell parameters
    D            = 5e6;     	% Diffusion Constant                [mol-s/C/m^3]
    Tau_0        = 20;          % Ohmic Time Constant               [s]
    R_0          = 30e-3;     	% Ohmic Resistance                  [Ohm]
    k_p          = 2e4;       	% Cathode Exchange Current Factor   [A/m^2]
    Tau_Np       = 250;         % Cathode Time Constant             [s]
    k_n          = 2e4;     	% Anode Exchange Current Factor     [A/m^2]
    Tau_Nn       = 500;         % Anode Time Constant               [s]    
    
    %% Initial Conditions
    qp_init      = q_max * xp_init;            % Initial Cathode Charge

    qn_init      = q_max * xn_init;            % Initial Anode Charge

    qsp          = qp_init / (1 + v_bp/v_sp);  % Initial Surface Cathode Charge 

    qbp          = qp_init - qsp;              % Initial Bulk Cathode Charge

    qsn          = qn_init / (1 + v_bn/v_sn);  % Initial Surface Anode Charge 

    qbn          = qn_init - qsn;              % Initial Bulk Cathode Charge

    V0_          = 0;         	% Initial Ohmic Overpotential Transient
    VNp_         = 0;         	% Initial Cathode Surface Overpotential Transient
    VNn_         = 0;        	% Initial Anode Surface Overpotential Transient
    %% Calculate Conditions at Each State

for k        = 1:length(iapp) %stepping through the current
    %% Calculate Equilibrium Potentials 
        % Mole Fractions
        q_max_sp     = q_max * v_sp/(v_sp+v_bp);   % Cathode Surface Max Charge
        
        q_max_sn     = q_max * v_sn/(v_sn+v_bn);   % Anode Surface Max Charge

        xp           = (qsp+qbp)/q_max;            % Cathode Mole Fraction
%         exp(k)       = xp;
        xsp          = qsp / q_max_sp;             % Cathode Surface Mole Fraction

        xn           = (qsn+qbn)/q_max;            % Anode Mole Fraciton
%         exn(k)       = xn;
        xsn          = qsn / q_max_sn;             % Anode Surface Mole Fraction 
    %% Calculate Equilibrium Potentials of the electrodes              
          VU_n         = graphite_ocv(xn); % anode OCV(R*Temp/(n*F))*log((1-xp)/xp)+
          ocvgra(k)    = VU_n;
          VU_p         = nca_ocv(xp);      % cathode OCV (R*Temp/(n*F))*log((1-xn)/xn)+
          ocvnca(k)    = VU_p;
    %% Turn Off Applied Current at Premature End-of-Discharge
            if xn <= 0
                break
            end
            if xsn <= 0
                break
            end
            if xsp >= 1
                break
            end  
            if xp >= 1
                break
            end
    %% Update Charge States

        % Cathode Bulk to Surface Diffusion
        q_dot_bsp    = 1/D * (qbp/v_bp - qsp/v_sp);  

        % Anode Bulk to Surface Diffusion
        q_dot_bsn    = 1/D * (qbn/v_bn - qsn/v_sn);  

        % Charge Differential Cathode Surface
        q_dot_sp     = iapp(k) + q_dot_bsp;    

        % Charge Differential Cathode Bulk
        q_dot_bp     = -q_dot_bsp;             

        % Charge Differential Anode Bulk
        q_dot_bn     = -q_dot_bsn;             

        % Charge Differential Anode Surface
        q_dot_sn     = -iapp(k) + q_dot_bsn;   

        % Catch for Last State
        qsp_next     = qsp + q_dot_sp*dt;   % Next Cathode Surface Charge [C]
        qbp_next     = qbp + q_dot_bp*dt;   % Next Cathode Bulk Charge [C]
        qsn_next     = qsn + q_dot_sn*dt;   % Next Anode Surface Charge [C]
        qbn_next     = qbn + q_dot_bn*dt;   % Next Anode Bulk Charge [C]   
        d_next       = d + (((qsp_next+qbp_next) - (qsp+qbp)))*0.277778; % Next SoD [mAh]

    %% Update Overpotential States
        V_0          = iapp(k) * R_0;       % Ohmic Overpotential       [V]
        J_p          = iapp(k) / (S_p);  	% Cathode Current Density   [A/m^2]
        J_n          = iapp(k) / (S_n);     % Anode Current Density     [A/m^2]

        % Cathode Exchange Current Density
        J_p0         = k_p * (1-xsp)^alpha * xsp^(1-alpha); %           [A/m^2]

        % Cathode Exchange Current Density
        J_n0         = k_n * (1-xsn)^alpha * xsn^(1-alpha); %           [A/m^2]

        % Cathode Surface Overpotential
        VN_p         = R*Temp(k)/(F*alpha) * asinh(J_p/(2*J_p0)); %    [V]
        % Anode Surface Overpotential
        VN_n         = R*Temp(k)/(F*alpha) * asinh(J_n/(2*J_n0)); %    [V] 

        % Ohmic Transient Overpotential Differential
        V0_dot       = (V_0 - V0_) / Tau_0; %                       [V/s]
        % Cathode Transient Surface Potential Differential
        VNp_dot      = (VN_p - VNp_) / Tau_Np; %                   	[V/s]
        % Anode Transient Surface Potential Differential
        VNn_dot      = (VN_n - VNn_) / Tau_Nn; %                   	[V/s]

        % Predict Next Ohmic Transient Overpotential
        V0__next     = V0_ + V0_dot*dt;
        % Predict Next Cathode Transient Surface Potential
        VNp__next    = VNp_ + VNp_dot*dt;
        % Predict Next Anode Transient Surface Potential
        VNn__next    = VNn_ + VNn_dot*dt;

    %% Calculate Next Temperature ************************************
         Delta_T_0    = Temp(k) - Tamb;
         Delta_T_cool = Delta_T_0 * exp(-r_temp * dt);
         dT_cooling   = Delta_T_cool - Delta_T_0;
         dT_R         = iapp(k).^2 * R_0 * dt ./ C_T;
         dT_S         = Temp(k) * S_T / n / F * dt;
         Temp_next    = Temp(k) + dT_cooling + dT_R + dT_S;
    %% Calculate Cell Voltage
        Voltage      = VU_p - VU_n - V0_ - VNp_ - VNn_;
        volta(k)     = Voltage; % to get the cell voltage array
        iapp(k+1) = data(k)/volta(k);
    
    %% Update States 
    
        qsp          = qsp_next;    % Next Cathode Surface Charge [C]
        qbp          = qbp_next;    % Next Cathode Bulk Charge [C]
        qsn          = qsn_next;	% Next Anode Surface Charge [C]
        qbn          = qbn_next;	% Next Anode Bulk Charge [C]
        d            = d_next;    	% Next State of Discharge [mAh]
        V0_          = V0__next;  	% Next Cathode Transient Surface Potential
        VNp_         = VNp__next;   % Next Cathode Transient Surface Potential
        VNn_         = VNn__next;   % Next Anode Transient Surface Potential
        Temp(k+1)    = Temp_next;   % Next Cell Temperature [K]
    
    %% Turn Off Applied Current at Premature Cutoff Voltage
     if Voltage <= cutoff
            break
     end
end

%% discharge curve
figure(1)
time   = linspace(1,length(volta),length(volta));
charge = iappRef.*time/3600; %Ah
plot(charge,volta)
xlabel('Capacity (mAh)')
ylabel('Cell Voltage (V)')
title('3A discharge')


%% voltage curve
figure(2)
time2 = linspace(0,12960,length(volta));
plot(time2,volta)
xlabel('Time (s)')
ylabel('Cell Voltage (V)')
xlim([0 13100])
title('Voltage Against Time')

%% current curve
figure(3)
time3 = linspace(0,13670,length(iapp));
plot(time3,iapp)
xlabel('Time (s)')
ylabel('Current (A)')
xlim([0 12960])
title('Current Against Time')

%% thermal curve
figure(4)
time4 = linspace(0,13670,length(Temp));
plot(time4,Temp)
xlabel('Time (s)')
ylabel('Temperature (K)')
xlim([0 13670])
title('Temperature Against Time')