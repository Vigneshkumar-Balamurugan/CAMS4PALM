function create_gas_bc(final_result, dynamic_dri_file, dynamic_dri_file_incl_gas, palm_smog, palm_cbm4)

voc_to_rh_factor = 1;

if contains(palm_smog, 'YES')
    voc_to_rh_factor = 0.7;
    voc_to_rcho_factor = 0.3;
end

if contains(palm_cbm4, 'YES')
    voc_to_par_factor = 0.35;
    voc_to_ole_factor = 0.2;
    voc_to_tol_factor = 0.15;
    voc_to_xyl_factor = 0.15;
    voc_to_ald2_factor = 0.15;
end

% create a new dynamic drive file (only gaseous) and add the processed data 
copyfile (dynamic_dri_file, dynamic_dri_file_incl_gas)

final_result.pm25 = final_result.pm2p5;
final_result = rmfield(final_result, 'pm2p5');

fin_res_fie = fields(final_result);

if ismember('co', fin_res_fie)

    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);
    


    int_atm_co_def = netcdf.defVar(ncid, 'init_atmosphere_CO', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_co_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_co_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_co_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_co_def, '_FillValue', -9999.0);

    ls_north_co_def = netcdf.defVar(ncid, 'ls_forcing_north_CO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_co_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_co_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_co_def, '_FillValue', -9999.0);

    ls_south_co_def = netcdf.defVar(ncid, 'ls_forcing_south_CO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_co_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_co_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_co_def, '_FillValue', -9999.0);

    ls_left_co_def = netcdf.defVar(ncid, 'ls_forcing_left_CO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_co_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_co_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_co_def, '_FillValue', -9999.0);

    ls_right_co_def = netcdf.defVar(ncid, 'ls_forcing_right_CO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_co_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_co_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_co_def, '_FillValue', -9999.0);

    ls_top_co_def = netcdf.defVar(ncid, 'ls_forcing_top_CO', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_co_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_co_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_co_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_co_def, final_result.co.int);
    netcdf.putVar(ncid, ls_north_co_def, final_result.co.north);
    netcdf.putVar(ncid, ls_south_co_def, final_result.co.south);
    netcdf.putVar(ncid, ls_left_co_def, final_result.co.left);
    netcdf.putVar(ncid, ls_right_co_def, final_result.co.right);
    netcdf.putVar(ncid, ls_top_co_def, final_result.co.top);

    netcdf.close(ncid);
end

if ismember('no', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_no_def = netcdf.defVar(ncid, 'init_atmosphere_NO', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_no_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_no_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_no_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_no_def, '_FillValue', -9999.0);

    ls_north_no_def = netcdf.defVar(ncid, 'ls_forcing_north_NO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_no_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_no_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_no_def, '_FillValue', -9999.0);

    ls_south_no_def = netcdf.defVar(ncid, 'ls_forcing_south_NO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_no_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_no_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_no_def, '_FillValue', -9999.0);

    ls_left_no_def = netcdf.defVar(ncid, 'ls_forcing_left_NO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_no_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_no_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_no_def, '_FillValue', -9999.0);

    ls_right_no_def = netcdf.defVar(ncid, 'ls_forcing_right_NO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_no_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_no_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_no_def, '_FillValue', -9999.0);

    ls_top_no_def = netcdf.defVar(ncid, 'ls_forcing_top_NO', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_no_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_no_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_no_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_no_def, final_result.no.int);
    netcdf.putVar(ncid, ls_north_no_def, final_result.no.north);
    netcdf.putVar(ncid, ls_south_no_def, final_result.no.south);
    netcdf.putVar(ncid, ls_left_no_def, final_result.no.left);
    netcdf.putVar(ncid, ls_right_no_def, final_result.no.right);
    netcdf.putVar(ncid, ls_top_no_def, final_result.no.top);

    netcdf.close(ncid);
end

if ismember('no2', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_no2_def = netcdf.defVar(ncid, 'init_atmosphere_NO2', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_no2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_no2_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_no2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_no2_def, '_FillValue', -9999.0);

    ls_north_no2_def = netcdf.defVar(ncid, 'ls_forcing_north_NO2', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_no2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_no2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_no2_def, '_FillValue', -9999.0);

    ls_south_no2_def = netcdf.defVar(ncid, 'ls_forcing_south_NO2', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_no2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_no2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_no2_def, '_FillValue', -9999.0);

    ls_left_no2_def = netcdf.defVar(ncid, 'ls_forcing_left_NO2', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_no2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_no2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_no2_def, '_FillValue', -9999.0);

    ls_right_no2_def = netcdf.defVar(ncid, 'ls_forcing_right_NO2', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_no2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_no2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_no2_def, '_FillValue', -9999.0);

    ls_top_no2_def = netcdf.defVar(ncid, 'ls_forcing_top_NO2', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_no2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_no2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_no2_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_no2_def, final_result.no2.int);
    netcdf.putVar(ncid, ls_north_no2_def, final_result.no2.north);
    netcdf.putVar(ncid, ls_south_no2_def, final_result.no2.south);
    netcdf.putVar(ncid, ls_left_no2_def, final_result.no2.left);
    netcdf.putVar(ncid, ls_right_no2_def, final_result.no2.right);
    netcdf.putVar(ncid, ls_top_no2_def, final_result.no2.top);

    netcdf.close(ncid);
end

if ismember('o3', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_o3_def = netcdf.defVar(ncid, 'init_atmosphere_O3', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_o3_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_o3_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_o3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_o3_def, '_FillValue', -9999.0);

    ls_north_o3_def = netcdf.defVar(ncid, 'ls_forcing_north_O3', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_o3_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_o3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_o3_def, '_FillValue', -9999.0);

    ls_south_o3_def = netcdf.defVar(ncid, 'ls_forcing_south_O3', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_o3_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_o3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_o3_def, '_FillValue', -9999.0);

    ls_left_o3_def = netcdf.defVar(ncid, 'ls_forcing_left_O3', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_o3_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_o3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_o3_def, '_FillValue', -9999.0);

    ls_right_o3_def = netcdf.defVar(ncid, 'ls_forcing_right_O3', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_o3_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_o3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_o3_def, '_FillValue', -9999.0);

    ls_top_o3_def = netcdf.defVar(ncid, 'ls_forcing_top_O3', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_o3_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_o3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_o3_def, '_FillValue', -9999.0);


    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_o3_def, final_result.o3.int);
    netcdf.putVar(ncid, ls_north_o3_def, final_result.o3.north);
    netcdf.putVar(ncid, ls_south_o3_def, final_result.o3.south);
    netcdf.putVar(ncid, ls_left_o3_def, final_result.o3.left);
    netcdf.putVar(ncid, ls_right_o3_def, final_result.o3.right);
    netcdf.putVar(ncid, ls_top_o3_def, final_result.o3.top);

    netcdf.close(ncid);
end

if ismember('nmvoc', fin_res_fie) && ~contains(palm_cbm4, 'YES')
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_rh_def = netcdf.defVar(ncid, 'init_atmosphere_RH', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_rh_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_rh_def, '_FillValue', -9999.0);

    ls_north_rh_def = netcdf.defVar(ncid, 'ls_forcing_north_RH', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_rh_def, '_FillValue', -9999.0);

    ls_south_rh_def = netcdf.defVar(ncid, 'ls_forcing_south_RH', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_rh_def, '_FillValue', -9999.0);

    ls_left_rh_def = netcdf.defVar(ncid, 'ls_forcing_left_RH', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_rh_def, '_FillValue', -9999.0);

    ls_right_rh_def = netcdf.defVar(ncid, 'ls_forcing_right_RH', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_rh_def, '_FillValue', -9999.0);

    ls_top_rh_def = netcdf.defVar(ncid, 'ls_forcing_top_RH', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_rh_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);

    
    netcdf.putVar(ncid, int_atm_rh_def, (final_result.nmvoc.int)*voc_to_rh_factor);
    netcdf.putVar(ncid, ls_north_rh_def, (final_result.nmvoc.north)*voc_to_rh_factor);
    netcdf.putVar(ncid, ls_south_rh_def, (final_result.nmvoc.south)*voc_to_rh_factor);
    netcdf.putVar(ncid, ls_left_rh_def, (final_result.nmvoc.left)*voc_to_rh_factor);
    netcdf.putVar(ncid, ls_right_rh_def, (final_result.nmvoc.right)*voc_to_rh_factor);
    netcdf.putVar(ncid, ls_top_rh_def, (final_result.nmvoc.top)*voc_to_rh_factor);

    netcdf.close(ncid);
end

if contains(palm_smog, 'YES')
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_rh_def = netcdf.defVar(ncid, 'init_atmosphere_RCHO', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_rh_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_rh_def, '_FillValue', -9999.0);

    ls_north_rh_def = netcdf.defVar(ncid, 'ls_forcing_north_RCHO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_rh_def, '_FillValue', -9999.0);

    ls_south_rh_def = netcdf.defVar(ncid, 'ls_forcing_south_RCHO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_rh_def, '_FillValue', -9999.0);

    ls_left_rh_def = netcdf.defVar(ncid, 'ls_forcing_left_RCHO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_rh_def, '_FillValue', -9999.0);

    ls_right_rh_def = netcdf.defVar(ncid, 'ls_forcing_right_RCHO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_rh_def, '_FillValue', -9999.0);

    ls_top_rh_def = netcdf.defVar(ncid, 'ls_forcing_top_RCHO', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_rh_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_rh_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_rh_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);

    
    netcdf.putVar(ncid, int_atm_rh_def, (final_result.nmvoc.int)*voc_to_rcho_factor);
    netcdf.putVar(ncid, ls_north_rh_def, (final_result.nmvoc.north)*voc_to_rcho_factor);
    netcdf.putVar(ncid, ls_south_rh_def, (final_result.nmvoc.south)*voc_to_rcho_factor);
    netcdf.putVar(ncid, ls_left_rh_def, (final_result.nmvoc.left)*voc_to_rcho_factor);
    netcdf.putVar(ncid, ls_right_rh_def, (final_result.nmvoc.right)*voc_to_rcho_factor);
    netcdf.putVar(ncid, ls_top_rh_def, (final_result.nmvoc.top)*voc_to_rcho_factor);

    netcdf.close(ncid);
end

if ismember('hcho', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_hcho_def = netcdf.defVar(ncid, 'init_atmosphere_HCHO', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_hcho_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_hcho_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_hcho_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_hcho_def, '_FillValue', -9999.0);

    ls_north_hcho_def = netcdf.defVar(ncid, 'ls_forcing_north_HCHO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_hcho_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_hcho_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_hcho_def, '_FillValue', -9999.0);

    ls_south_hcho_def = netcdf.defVar(ncid, 'ls_forcing_south_HCHO', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_hcho_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_hcho_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_hcho_def, '_FillValue', -9999.0);

    ls_left_hcho_def = netcdf.defVar(ncid, 'ls_forcing_left_HCHO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_hcho_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_hcho_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_hcho_def, '_FillValue', -9999.0);

    ls_right_hcho_def = netcdf.defVar(ncid, 'ls_forcing_right_HCHO', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_hcho_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_hcho_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_hcho_def, '_FillValue', -9999.0);

    ls_top_hcho_def = netcdf.defVar(ncid, 'ls_forcing_top_HCHO', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_hcho_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_hcho_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_hcho_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_hcho_def, final_result.hcho.int);
    netcdf.putVar(ncid, ls_north_hcho_def, final_result.hcho.north);
    netcdf.putVar(ncid, ls_south_hcho_def, final_result.hcho.south);
    netcdf.putVar(ncid, ls_left_hcho_def, final_result.hcho.left);
    netcdf.putVar(ncid, ls_right_hcho_def, final_result.hcho.right);
    netcdf.putVar(ncid, ls_top_hcho_def, final_result.hcho.top);

    netcdf.close(ncid);
end

if ismember('pm25', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_pm25_def = netcdf.defVar(ncid, 'init_atmosphere_PM25', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_pm25_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, int_atm_pm25_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_pm25_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_pm25_def, '_FillValue', -9999.0);

    ls_north_pm25_def = netcdf.defVar(ncid, 'ls_forcing_north_PM25', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_pm25_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_north_pm25_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_pm25_def, '_FillValue', -9999.0);

    ls_south_pm25_def = netcdf.defVar(ncid, 'ls_forcing_south_PM25', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_pm25_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_south_pm25_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_pm25_def, '_FillValue', -9999.0);

    ls_left_pm25_def = netcdf.defVar(ncid, 'ls_forcing_left_PM25', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_pm25_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_left_pm25_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_pm25_def, '_FillValue', -9999.0);

    ls_right_pm25_def = netcdf.defVar(ncid, 'ls_forcing_right_PM25', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_pm25_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_right_pm25_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_pm25_def, '_FillValue', -9999.0);

    ls_top_pm25_def = netcdf.defVar(ncid, 'ls_forcing_top_PM25', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_pm25_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_top_pm25_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_pm25_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_pm25_def, final_result.pm25.int);
    netcdf.putVar(ncid, ls_north_pm25_def, final_result.pm25.north);
    netcdf.putVar(ncid, ls_south_pm25_def, final_result.pm25.south);
    netcdf.putVar(ncid, ls_left_pm25_def, final_result.pm25.left);
    netcdf.putVar(ncid, ls_right_pm25_def, final_result.pm25.right);
    netcdf.putVar(ncid, ls_top_pm25_def, final_result.pm25.top);

    netcdf.close(ncid);
end

if ismember('pm10', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_pm10_def = netcdf.defVar(ncid, 'init_atmosphere_PM10', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_pm10_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, int_atm_pm10_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_pm10_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_pm10_def, '_FillValue', -9999.0);

    ls_north_pm10_def = netcdf.defVar(ncid, 'ls_forcing_north_PM10', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_pm10_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_north_pm10_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_pm10_def, '_FillValue', -9999.0);

    ls_south_pm10_def = netcdf.defVar(ncid, 'ls_forcing_south_PM10', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_pm10_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_south_pm10_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_pm10_def, '_FillValue', -9999.0);

    ls_left_pm10_def = netcdf.defVar(ncid, 'ls_forcing_left_PM10', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_pm10_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_left_pm10_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_pm10_def, '_FillValue', -9999.0);

    ls_right_pm10_def = netcdf.defVar(ncid, 'ls_forcing_right_PM10', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_pm10_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_right_pm10_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_pm10_def, '_FillValue', -9999.0);

    ls_top_pm10_def = netcdf.defVar(ncid, 'ls_forcing_top_PM10', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_pm10_def, 'units', 'kg/m3');
    netcdf.putAtt(ncid, ls_top_pm10_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_pm10_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_pm10_def, final_result.pm10.int);
    netcdf.putVar(ncid, ls_north_pm10_def, final_result.pm10.north);
    netcdf.putVar(ncid, ls_south_pm10_def, final_result.pm10.south);
    netcdf.putVar(ncid, ls_left_pm10_def, final_result.pm10.left);
    netcdf.putVar(ncid, ls_right_pm10_def, final_result.pm10.right);
    netcdf.putVar(ncid, ls_top_pm10_def, final_result.pm10.top);

    netcdf.close(ncid);
end

if ismember('chocho', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_ocnv_def = netcdf.defVar(ncid, 'init_atmosphere_OCNV', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_ocnv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, int_atm_ocnv_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_ocnv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_ocnv_def, '_FillValue', -9999.0);

    ls_north_ocnv_def = netcdf.defVar(ncid, 'ls_forcing_north_OCNV', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_ocnv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_north_ocnv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_ocnv_def, '_FillValue', -9999.0);

    ls_south_ocnv_def = netcdf.defVar(ncid, 'ls_forcing_south_OCNV', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_ocnv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_south_ocnv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_ocnv_def, '_FillValue', -9999.0);

    ls_left_ocnv_def = netcdf.defVar(ncid, 'ls_forcing_left_OCNV', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_ocnv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_left_ocnv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_ocnv_def, '_FillValue', -9999.0);

    ls_right_ocnv_def = netcdf.defVar(ncid, 'ls_forcing_right_OCNV', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_ocnv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_right_ocnv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_ocnv_def, '_FillValue', -9999.0);

    ls_top_ocnv_def = netcdf.defVar(ncid, 'ls_forcing_top_OCNV', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_ocnv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_top_ocnv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_ocnv_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_ocnv_def, final_result.chocho.int);
    netcdf.putVar(ncid, ls_north_ocnv_def, final_result.chocho.north);
    netcdf.putVar(ncid, ls_south_ocnv_def, final_result.chocho.south);
    netcdf.putVar(ncid, ls_left_ocnv_def, final_result.chocho.left);
    netcdf.putVar(ncid, ls_right_ocnv_def, final_result.chocho.right);
    netcdf.putVar(ncid, ls_top_ocnv_def, final_result.chocho.top);

    netcdf.close(ncid);
end

if ismember('ocsv', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_ocsv_def = netcdf.defVar(ncid, 'init_atmosphere_OCSV', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_ocsv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, int_atm_ocsv_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_ocsv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_ocsv_def, '_FillValue', -9999.0);

    ls_north_ocsv_def = netcdf.defVar(ncid, 'ls_forcing_north_OCSV', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_ocsv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_north_ocsv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_ocsv_def, '_FillValue', -9999.0);

    ls_south_ocsv_def = netcdf.defVar(ncid, 'ls_forcing_south_OCSV', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_ocsv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_south_ocsv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_ocsv_def, '_FillValue', -9999.0);

    ls_left_ocsv_def = netcdf.defVar(ncid, 'ls_forcing_left_OCSV', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_ocsv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_left_ocsv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_ocsv_def, '_FillValue', -9999.0);

    ls_right_ocsv_def = netcdf.defVar(ncid, 'ls_forcing_right_OCSV', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_ocsv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_right_ocsv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_ocsv_def, '_FillValue', -9999.0);

    ls_top_ocsv_def = netcdf.defVar(ncid, 'ls_forcing_top_OCSV', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_ocsv_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_top_ocsv_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_ocsv_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_ocsv_def, final_result.ocsv.int);
    netcdf.putVar(ncid, ls_north_ocsv_def, final_result.ocsv.north);
    netcdf.putVar(ncid, ls_south_ocsv_def, final_result.ocsv.south);
    netcdf.putVar(ncid, ls_left_ocsv_def, final_result.ocsv.left);
    netcdf.putVar(ncid, ls_right_ocsv_def, final_result.ocsv.right);
    netcdf.putVar(ncid, ls_top_ocsv_def, final_result.ocsv.top);

    netcdf.close(ncid);
end

if ismember('nh3', fin_res_fie)
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);

    int_atm_nh3_def = netcdf.defVar(ncid, 'init_atmosphere_NH3', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_nh3_def, 'units', '#/m3');
    netcdf.putAtt(ncid, int_atm_nh3_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_nh3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_nh3_def, '_FillValue', -9999.0);

    ls_north_nh3_def = netcdf.defVar(ncid, 'ls_forcing_north_NH3', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_nh3_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_north_nh3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_nh3_def, '_FillValue', -9999.0);

    ls_south_nh3_def = netcdf.defVar(ncid, 'ls_forcing_south_NH3', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_nh3_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_south_nh3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_nh3_def, '_FillValue', -9999.0);

    ls_left_nh3_def = netcdf.defVar(ncid, 'ls_forcing_left_NH3', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_nh3_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_left_nh3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_nh3_def, '_FillValue', -9999.0);

    ls_right_nh3_def = netcdf.defVar(ncid, 'ls_forcing_right_NH3', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_nh3_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_right_nh3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_nh3_def, '_FillValue', -9999.0);

    ls_top_nh3_def = netcdf.defVar(ncid, 'ls_forcing_top_NH3', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_nh3_def, 'units', '#/m3');
    netcdf.putAtt(ncid, ls_top_nh3_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_nh3_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);
    
    netcdf.putVar(ncid, int_atm_nh3_def, final_result.nh3.int);
    netcdf.putVar(ncid, ls_north_nh3_def, final_result.nh3.north);
    netcdf.putVar(ncid, ls_south_nh3_def, final_result.nh3.south);
    netcdf.putVar(ncid, ls_left_nh3_def, final_result.nh3.left);
    netcdf.putVar(ncid, ls_right_nh3_def, final_result.nh3.right);
    netcdf.putVar(ncid, ls_top_nh3_def, final_result.nh3.top);

    netcdf.close(ncid);
end

if contains(palm_cbm4, 'YES')
    
    ncid = netcdf.open(dynamic_dri_file_incl_gas, 'NC_WRITE');
    netcdf.reDef(ncid);
    
    int_atm_par_def = netcdf.defVar(ncid, 'init_atmosphere_PAR', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_par_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_par_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_par_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_par_def, '_FillValue', -9999.0);

    ls_north_par_def = netcdf.defVar(ncid, 'ls_forcing_north_PAR', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_par_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_par_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_par_def, '_FillValue', -9999.0);

    ls_south_par_def = netcdf.defVar(ncid, 'ls_forcing_south_PAR', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_par_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_par_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_par_def, '_FillValue', -9999.0);

    ls_left_par_def = netcdf.defVar(ncid, 'ls_forcing_left_PAR', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_par_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_par_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_par_def, '_FillValue', -9999.0);

    ls_right_par_def = netcdf.defVar(ncid, 'ls_forcing_right_PAR', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_par_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_par_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_par_def, '_FillValue', -9999.0);

    ls_top_par_def = netcdf.defVar(ncid, 'ls_forcing_top_PAR', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_par_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_par_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_par_def, '_FillValue', -9999.0);
    
    int_atm_ole_def = netcdf.defVar(ncid, 'init_atmosphere_OLE', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_ole_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_ole_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_ole_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_ole_def, '_FillValue', -9999.0);

    ls_north_ole_def = netcdf.defVar(ncid, 'ls_forcing_north_OLE', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_ole_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_ole_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_ole_def, '_FillValue', -9999.0);

    ls_south_ole_def = netcdf.defVar(ncid, 'ls_forcing_south_OLE', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_ole_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_ole_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_ole_def, '_FillValue', -9999.0);

    ls_left_ole_def = netcdf.defVar(ncid, 'ls_forcing_left_OLE', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_ole_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_ole_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_ole_def, '_FillValue', -9999.0);

    ls_right_ole_def = netcdf.defVar(ncid, 'ls_forcing_right_OLE', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_ole_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_ole_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_ole_def, '_FillValue', -9999.0);

    ls_top_ole_def = netcdf.defVar(ncid, 'ls_forcing_top_OLE', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_ole_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_ole_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_ole_def, '_FillValue', -9999.0);

    int_atm_tol_def = netcdf.defVar(ncid, 'init_atmosphere_TOL', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_tol_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_tol_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_tol_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_tol_def, '_FillValue', -9999.0);

    ls_north_tol_def = netcdf.defVar(ncid, 'ls_forcing_north_TOL', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_tol_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_tol_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_tol_def, '_FillValue', -9999.0);

    ls_south_tol_def = netcdf.defVar(ncid, 'ls_forcing_south_TOL', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_tol_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_tol_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_tol_def, '_FillValue', -9999.0);

    ls_left_tol_def = netcdf.defVar(ncid, 'ls_forcing_left_TOL', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_tol_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_tol_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_tol_def, '_FillValue', -9999.0);

    ls_right_tol_def = netcdf.defVar(ncid, 'ls_forcing_right_TOL', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_tol_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_tol_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_tol_def, '_FillValue', -9999.0);

    ls_top_tol_def = netcdf.defVar(ncid, 'ls_forcing_top_TOL', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_tol_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_tol_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_tol_def, '_FillValue', -9999.0);

    int_atm_xyl_def = netcdf.defVar(ncid, 'init_atmosphere_XYL', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_xyl_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_xyl_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_xyl_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_xyl_def, '_FillValue', -9999.0);

    ls_north_xyl_def = netcdf.defVar(ncid, 'ls_forcing_north_XYL', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_xyl_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_xyl_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_xyl_def, '_FillValue', -9999.0);

    ls_south_xyl_def = netcdf.defVar(ncid, 'ls_forcing_south_XYL', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_xyl_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_xyl_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_xyl_def, '_FillValue', -9999.0);

    ls_left_xyl_def = netcdf.defVar(ncid, 'ls_forcing_left_XYL', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_xyl_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_xyl_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_xyl_def, '_FillValue', -9999.0);

    ls_right_xyl_def = netcdf.defVar(ncid, 'ls_forcing_right_XYL', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_xyl_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_xyl_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_xyl_def, '_FillValue', -9999.0);

    ls_top_xyl_def = netcdf.defVar(ncid, 'ls_forcing_top_XYL', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_xyl_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_xyl_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_xyl_def, '_FillValue', -9999.0);

    int_atm_ald2_def = netcdf.defVar(ncid, 'init_atmosphere_ALD2', 'nc_double', 2);
    netcdf.putAtt(ncid, int_atm_ald2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, int_atm_ald2_def, 'lod', int32(1));
    netcdf.putAtt(ncid, int_atm_ald2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, int_atm_ald2_def, '_FillValue', -9999.0);

    ls_north_ald2_def = netcdf.defVar(ncid, 'ls_forcing_north_ALD2', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_north_ald2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_north_ald2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_north_ald2_def, '_FillValue', -9999.0);

    ls_south_ald2_def = netcdf.defVar(ncid, 'ls_forcing_south_ALD2', 'nc_double', [0,2,7]);
    netcdf.putAtt(ncid, ls_south_ald2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_south_ald2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_south_ald2_def, '_FillValue', -9999.0);

    ls_left_ald2_def = netcdf.defVar(ncid, 'ls_forcing_left_ALD2', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_left_ald2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_left_ald2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_left_ald2_def, '_FillValue', -9999.0);

    ls_right_ald2_def = netcdf.defVar(ncid, 'ls_forcing_right_ALD2', 'nc_double', [1,2,7]);
    netcdf.putAtt(ncid, ls_right_ald2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_right_ald2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_right_ald2_def, '_FillValue', -9999.0);

    ls_top_ald2_def = netcdf.defVar(ncid, 'ls_forcing_top_ALD2', 'nc_double', [0,1,7]);
    netcdf.putAtt(ncid, ls_top_ald2_def, 'units', 'ppm');
    netcdf.putAtt(ncid, ls_top_ald2_def, 'source', 'CAMS');
    netcdf.putAtt(ncid, ls_top_ald2_def, '_FillValue', -9999.0);

    netcdf.endDef(ncid);

    
    netcdf.putVar(ncid, int_atm_par_def, (final_result.nmvoc.int)*voc_to_par_factor);
    netcdf.putVar(ncid, ls_north_par_def, (final_result.nmvoc.north)*voc_to_par_factor);
    netcdf.putVar(ncid, ls_south_par_def, (final_result.nmvoc.south)*voc_to_par_factor);
    netcdf.putVar(ncid, ls_left_par_def, (final_result.nmvoc.left)*voc_to_par_factor);
    netcdf.putVar(ncid, ls_right_par_def, (final_result.nmvoc.right)*voc_to_par_factor);
    netcdf.putVar(ncid, ls_top_par_def, (final_result.nmvoc.top)*voc_to_par_factor);
    
    netcdf.putVar(ncid, int_atm_ole_def, (final_result.nmvoc.int)*voc_to_ole_factor);
    netcdf.putVar(ncid, ls_north_ole_def, (final_result.nmvoc.north)*voc_to_ole_factor);
    netcdf.putVar(ncid, ls_south_ole_def, (final_result.nmvoc.south)*voc_to_ole_factor);
    netcdf.putVar(ncid, ls_left_ole_def, (final_result.nmvoc.left)*voc_to_ole_factor);
    netcdf.putVar(ncid, ls_right_ole_def, (final_result.nmvoc.right)*voc_to_ole_factor);
    netcdf.putVar(ncid, ls_top_ole_def, (final_result.nmvoc.top)*voc_to_ole_factor);
    
    netcdf.putVar(ncid, int_atm_xyl_def, (final_result.nmvoc.int)*voc_to_xyl_factor);
    netcdf.putVar(ncid, ls_north_xyl_def, (final_result.nmvoc.north)*voc_to_xyl_factor);
    netcdf.putVar(ncid, ls_south_xyl_def, (final_result.nmvoc.south)*voc_to_xyl_factor);
    netcdf.putVar(ncid, ls_left_xyl_def, (final_result.nmvoc.left)*voc_to_xyl_factor);
    netcdf.putVar(ncid, ls_right_xyl_def, (final_result.nmvoc.right)*voc_to_xyl_factor);
    netcdf.putVar(ncid, ls_top_xyl_def, (final_result.nmvoc.top)*voc_to_xyl_factor);
    
    netcdf.putVar(ncid, int_atm_tol_def, (final_result.nmvoc.int)*voc_to_tol_factor);
    netcdf.putVar(ncid, ls_north_tol_def, (final_result.nmvoc.north)*voc_to_tol_factor);
    netcdf.putVar(ncid, ls_south_tol_def, (final_result.nmvoc.south)*voc_to_tol_factor);
    netcdf.putVar(ncid, ls_left_tol_def, (final_result.nmvoc.left)*voc_to_tol_factor);
    netcdf.putVar(ncid, ls_right_tol_def, (final_result.nmvoc.right)*voc_to_tol_factor);
    netcdf.putVar(ncid, ls_top_tol_def, (final_result.nmvoc.top)*voc_to_tol_factor);
    
    netcdf.putVar(ncid, int_atm_ald2_def, (final_result.nmvoc.int)*voc_to_ald2_factor);
    netcdf.putVar(ncid, ls_north_ald2_def, (final_result.nmvoc.north)*voc_to_ald2_factor);
    netcdf.putVar(ncid, ls_south_ald2_def, (final_result.nmvoc.south)*voc_to_ald2_factor);
    netcdf.putVar(ncid, ls_left_ald2_def, (final_result.nmvoc.left)*voc_to_ald2_factor);
    netcdf.putVar(ncid, ls_right_ald2_def, (final_result.nmvoc.right)*voc_to_ald2_factor);
    netcdf.putVar(ncid, ls_top_ald2_def, (final_result.nmvoc.top)*voc_to_ald2_factor);

    netcdf.close(ncid);
end

end