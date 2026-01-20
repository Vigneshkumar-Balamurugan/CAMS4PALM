clear; clc
% This program is written to prepare the boundary conditions of chemical species from the CAMS model for input into the PALM4U model. 
% This program only rewrites or appends the existing data (dynamic driver) prepared by WRF4PALM.
%% required fields

dem_palm_file = "H:\Munich_campaign_analysis\PALM_4U\Jobs\1_pre_jobs\12km_3km_nest\Static_driver\Munich_static_dem_N01.tif"; % DEM file preprocessed by GEO4PALM
dynamic_dri_file = "H:\Munich_campaign_analysis\PALM_4U\Jobs\1_pre_jobs\12km_3km_nest\6_7_Aug\dynamic_driver_N01_sandy.nc"; % Dynamic driver file preprocessed by WRF4PALM

cams_folder = 'H:\Munich_campaign_analysis\PALM_4U\WRF4PALM\cams\cams_europe_reanalysis_clip'; % Folder containing CAMS EUROPE REANALYSIS DATASET 

spe_to_inc = {'co', 'no', 'no2', 'o3', 'pm2p5', 'pm10', 'chocho', 'hcho', 'nh3', 'nmvoc'}; % Choose the gaseous species to be included in the output file 

nmvoc_to_rh_ratio = 1; % Ratio of nmvoc to rh (alkanes)

palm_smog = 'NO'; % YES if your PALM chemistry mechanism is SMOG

palm_cbm4 = 'NO'; % YES if your PALM chemistry mechanism is CBM4

cams_alt_ref_file = 'H:\Munich_campaign_analysis\PALM_4U\WRF4PALM\cams\CAMS_global_reana\cams_pres_level_info.csv'; % File that contain information to calculate the air pressure and tempature at differnt altitudes --> https://confluence.ecmwf.int/display/UDOC/L137+model+level+definitions

dynamic_dri_file_incl_gas =  'H:\Munich_campaign_analysis\PALM_4U\Jobs\1_pre_jobs\12km_3km_nest\6_7_Aug\dynamic_driver_with_gas_bc_N01_sandy.nc'; % Output File name 

%% Processing data 

[lat_dem_mat, lon_dem_mat] = dem_process (dem_palm_file); % processing DEM file for extracting the lat and lon of PALM domain

[palm_run_start_time, xval_palm, yval_palm, zval_palm, tval_palm] = dynamic_process(dynamic_dri_file); % processing dynamic file for extracting the PALM model run time and other details 

final_result = cams_file_process (zval_palm, spe_to_inc, cams_folder, lat_dem_mat, lon_dem_mat, tval_palm, palm_run_start_time, cams_alt_ref_file, nmvoc_to_rh_ratio); % processing CAMS REANALYSIS DATASET

create_gas_bc(final_result, dynamic_dri_file, dynamic_dri_file_incl_gas, palm_smog, palm_cbm4) % writing NC file that include gaseous BC (boundary conditions) 

