%% run_leaf_level_biochemical_model.m
%  Use this script to modify input parameters for biochemical.m

%% 1. Prepare needed inputs for biochemical.m

%  let's set the default values for these parameters
leafbio.Cab             = [40 50];
leafbio.Cca             = 10;
leafbio.Cdm             = 0.012;
leafbio.Cw              = 0.009;
leafbio.Cs              = 0;
leafbio.Cant            = 1;
leafbio.N               = 1.5;
leafbio.Vcmo            = [60 80 100 120];
leafbio.m               = 8;
leafbio.BallBerry0      = 0.01;
leafbio.Type            = 0;
leafbio.Tparam          = [0.2, 0.3, 281, 308, 328]; % this is correct (: instead of 14)
%fqe                     = 0.01;
leafbio.Rdparam         = 0.015;

leafbio.fPAR            = 0.8;

leafbio.rho_thermal     = 0.01;
leafbio.tau_thermal     = 0.01;

leafbio.Tyear           = 15;
leafbio.beta            = 0.51;
leafbio.kNPQs           = 0;
leafbio.qLs             = 1;
leafbio.stressfactor    = 1;

meteo.Cs                = 410;
meteo.Q                 = [200 300 600 800 1000 1500 2000]; % here we need to use the unit umol/m2/sec
meteo.T                 = [10 20 30]; % convert temperatures to K if not already
meteo.eb                = 15; %use ea for now
meteo.Oa                = 209;
meteo.p                 = 970;

options.apply_T_corr    = 1;

%% 2. Generate input as an LUT

input                   = combvec(leafbio.Cab, leafbio.Cca, leafbio.Cdm, ...
                                  leafbio.Cw, leafbio.Cs, leafbio.Cant, ...
                                  leafbio.N, leafbio.Vcmo, leafbio.m, ...
                                  leafbio.BallBerry0, leafbio.Type, leafbio.Rdparam, ...
                                  leafbio.fPAR, leafbio.rho_thermal, leafbio.tau_thermal, ...
                                  leafbio.Tyear, leafbio.beta, leafbio.kNPQs, ...
                                  leafbio.qLs, leafbio.stressfactor, meteo.Cs, ...
                                  meteo.Q, meteo.T, meteo.eb, ...
                                  meteo.Oa, meteo.p);
dim                             = size(input);

%% 3. Run the model
sif                             = nan(1,length(input));
Ve                              = nan(1,length(input));
Ag                              = nan(1,length(input));
Ci                              = nan(1,length(input));
gamma_star                      = nan(1,length(input));
Ja                              = nan(1,length(input));
A                               = nan(1,length(input));
Vc                              = nan(1,length(input));

for i = 1: dim(2)

    leafbio_ind.Cab             = input(1,i);
    leafbio_ind.Cca             = input(2,i);
    leafbio_ind.Cdm             = input(3,i);
    leafbio_ind.Cw              = input(4,i);
    leafbio_ind.Cs              = input(5,i);
    leafbio_ind.Cant            = input(6,i);
    leafbio_ind.N               = input(7,i);
    leafbio_ind.Vcmo            = input(8,i);
    leafbio_ind.m               = input(9,i);
    leafbio_ind.BallBerry0      = input(10,i);
    leafbio_ind.Type            = input(11,i);
    leafbio_ind.Tparam          = [0.2, 0.3, 281, 308, 328]; % this is correct (: instead of 14)
    leafbio_ind.Rdparam         = input(12,i);

    leafbio_ind.fPAR            = input(13,i);

    leafbio_ind.rho_thermal     = input(14,i);
    leafbio_ind.tau_thermal     = input(15,i);

    leafbio_ind.Tyear           = input(16,i);
    leafbio_ind.beta            = input(17,i);
    leafbio_ind.kNPQs           = input(18,i);
    leafbio_ind.qLs             = input(19,i);
    leafbio_ind.stressfactor    = input(20,i);

    meteo_ind.Cs                = input(21,i);
    meteo_ind.Q                 = input(22,i); % here we need to use the unit umol/m2/sec
    meteo_ind.T                 = input(23,i); % convert temperatures to K if not already
    meteo_ind.eb                = input(24,i); %use ea for now
    meteo_ind.Oa                = input(25,i);
    meteo_ind.p                 = input(26,i);

    biochem_out                 = biochemical(leafbio_ind,meteo_ind,options,1,1); % fV is 1 for leaf level
    
    sif(1,i)                      = biochem_out.SIF;
    Ve(1,i)                       = biochem_out.Ve;
    Ag(1,i)                       = biochem_out.Ag;
    Ci(1,i)                       = biochem_out.Ci;
    gamma_star(1,i)               = biochem_out.Gamma_star;
    Ja(1,i)                       = biochem_out.Ja;
    A(1,i)                        = biochem_out.A;
    Vc(1,i)                       = biochem_out.Vc;
end


%% 3. Making plots
subplot(2,1,1)
plot(sif,Ja,'ro')
subplot(2,1,2)
plot(sif,Vc,'ko')





