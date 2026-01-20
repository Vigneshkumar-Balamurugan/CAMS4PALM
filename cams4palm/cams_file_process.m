function final_result = cams_file_process (zval_palm, spe_to_inc, cams_folder, lat_dem_mat, lon_dem_mat, tval_palm, palm_run_start_time, cams_alt_ref_file, nmvoc_to_rh_ratio)

% Processing cams results for PALM domain

CAMS_levels_req = [0, 50, 100, 250, 500, 750, 1000, 2000, 3000, 5000];
non_rwq_levels = find(max(zval_palm)<CAMS_levels_req);
CAMS_levels_req(non_rwq_levels(2:end)) = [];
CAMS_levels_req_str = strcat('l', string(CAMS_levels_req));

cams_proc = struct();

for spec_xx = 1:length(spe_to_inc)
    for req_lev_xx = 1:length(CAMS_levels_req_str)
        name_con = ['cams.eaq.ira.ENSa.',char(spe_to_inc(spec_xx)),'.',char(CAMS_levels_req_str(req_lev_xx))];
        cams_matchingFiles = dir(fullfile(cams_folder, ['*',char(name_con), '*.nc']));

        if isempty(cams_matchingFiles)
            disp([char(spe_to_inc(spec_xx)), ' species file is not availble in the directory'])
            break
        end

        cams_data_cat = [];
        cams_time_cat = [];

        for cams_file_xx = 1:length(cams_matchingFiles)
            cams_file = fullfile(cams_folder,cams_matchingFiles(cams_file_xx).name);
            
            cams_file_lat = ncread(cams_file, 'lat');
            cams_file_lon = ncread(cams_file, 'lon');
            cams_file_data = ncread(cams_file, char(spe_to_inc(spec_xx)));
            cams_file_time = datetime(str2double(cams_file(end-9:end-6)), str2double(cams_file(end-4:end-3)), 1, 'TimeZone', 'Europe/Berlin'): hours(1): datetime(str2double(cams_file(end-9:end-6)), str2double(cams_file(end-4:end-3)), eomday(str2double(cams_file(end-9:end-6)), str2double(cams_file(end-4:end-3)))+1, 'TimeZone', 'Europe/Berlin');
            cams_file_time(end) = [];
            cams_file_time.TimeZone = 'UTC';

            [near_lat_bot, near_lat_top, near_lon_left, near_lon_right] = near_loc (lat_dem_mat, lon_dem_mat, cams_file_lat, cams_file_lon);

            % if near_lat_bot == near_lat_top 
            %     disp('Only one grid cell (along north-south) might be available in CAMS for PALM domain')
            % end
            % 
            % if near_lon_left == near_lon_right
            %     disp('Only one grid cell (along east-west) might be available in CAMS for PALM domain')
            % end

            cams_data_cat = cat(3, cams_data_cat,cams_file_data(near_lon_left-2:near_lon_right+2, near_lat_bot-2:near_lat_top+2, :));

            cams_time_cat = [cams_time_cat, cams_file_time];

        end
        
        near_time = nan(length(tval_palm),1);

        cams_data_proc = [];
        for tval_palm_xx = 1:length(tval_palm)
            [~, near_time(tval_palm_xx)] = min(abs(palm_run_start_time+seconds(tval_palm(tval_palm_xx)) - cams_time_cat));

            diff_hr = hours(min(abs(palm_run_start_time+seconds(tval_palm(tval_palm_xx)) - cams_time_cat)));

            if diff_hr >= 2
                disp(['The nearest available CAMS data for ', datestr(palm_run_start_time+seconds(tval_palm(tval_palm_xx))), ' is ', num2str(diff_hr) ,' hr apart'])
                disp('Check CAMS file folder and add nearest timestamp data')
            end

            cams_data_proc = cat(3, cams_data_proc, cams_data_cat(:,:,near_time(tval_palm_xx)));
        end
        cams_proc.(char(spe_to_inc(spec_xx))).(char(CAMS_levels_req_str(req_lev_xx))) = cams_data_proc;

    end
end

cams_res_fie_bf = fields(cams_proc);

if ismember('hcho', cams_res_fie_bf)
    cams_proc.ocsv = cams_proc.hcho;
end

% performing horizontal (x and y) and vertical (z) interpolation

cams_alt_ref_data = readtable(cams_alt_ref_file);
cams_alt_ref_data(1,:) = [];

cams_alt_ref_data_palm_lev = table();
cams_alt_ref_data_palm_lev.pres = interp1(cams_alt_ref_data.GeometricAltitude_m_, cams_alt_ref_data.ph_hPa_, zval_palm, 'nearest','extrap');
cams_alt_ref_data_palm_lev.temp = interp1(cams_alt_ref_data.GeometricAltitude_m_, cams_alt_ref_data.Temperature_K_, zval_palm, 'nearest','extrap');
cams_alt_ref_data_palm_lev.dens = interp1(cams_alt_ref_data.GeometricAltitude_m_, cams_alt_ref_data.Density_kg_m_3_, zval_palm, 'nearest','extrap');
cams_alt_ref_data_palm_lev.mol_vol = (0.0821*cams_alt_ref_data_palm_lev.temp)./ (cams_alt_ref_data_palm_lev.pres /1013.25);

cams_lat_proc = cams_file_lat(near_lat_bot-2:near_lat_top+2);
cams_lon_proc = cams_file_lon(near_lon_left-2:near_lon_right+2);

[lat_cams_grid, lon_cams_grid, alt_cams_grid] = meshgrid(cams_lat_proc, cams_lon_proc, CAMS_levels_req);
[lat_palm_grid, lon_palm_grid, alt_palm_grid] = meshgrid(flip(lat_dem_mat(:,1)), lon_dem_mat(1,:), zval_palm);

final_result = struct();

cams_res_fie = fields(cams_proc);

for cams_res_xx = 1:length(cams_res_fie)

    if strcmp((char(cams_res_fie(cams_res_xx))), 'co') 
        uni_con = cams_alt_ref_data_palm_lev.mol_vol/(1000*28.01); % to ppm
    elseif strcmp((char(cams_res_fie(cams_res_xx))),  'no') 
        uni_con = cams_alt_ref_data_palm_lev.mol_vol/(1000*30.01); % to ppm
    elseif strcmp((char(cams_res_fie(cams_res_xx))),  'no2') 
        uni_con = cams_alt_ref_data_palm_lev.mol_vol/(1000*46.005); % to ppm
    elseif strcmp((char(cams_res_fie(cams_res_xx))),  'o3') 
        uni_con = cams_alt_ref_data_palm_lev.mol_vol/(1000*48); % to ppm
    elseif strcmp((char(cams_res_fie(cams_res_xx))), 'nmvoc') % nmvoc will be converted to consider as RH (alkanes)
        uni_con = nmvoc_to_rh_ratio * cams_alt_ref_data_palm_lev.mol_vol/(1000*70); % to ppm
    elseif strcmp((char(cams_res_fie(cams_res_xx))), 'hcho') 
        uni_con = cams_alt_ref_data_palm_lev.mol_vol/(1000*30.031); % to ppm
    elseif strcmp((char(cams_res_fie(cams_res_xx))),  'pm2p5') || strcmp((char(cams_res_fie(cams_res_xx))), 'pm10')
        uni_con = repelem((1*10^(-9)), size(cams_alt_ref_data_palm_lev.mol_vol,1))'; % to kg/m3
    elseif strcmp((char(cams_res_fie(cams_res_xx))), 'chocho') % considered as OCNV
        uni_con = repelem((1*10^(-6) * 6.0220e+23 / 62.07), size(cams_alt_ref_data_palm_lev.mol_vol,1))'; % to #/m3 
    elseif strcmp((char(cams_res_fie(cams_res_xx))),  'ocsv') % considered as OCSV
        uni_con = repelem((1*10^(-6) * 6.0220e+23 / 30.031), size(cams_alt_ref_data_palm_lev.mol_vol,1))'; % to #/m3
    elseif strcmp((char(cams_res_fie(cams_res_xx))),  'nh3') 
        uni_con = repelem((1*10^(-6) * 6.0220e+23 / 17.031), size(cams_alt_ref_data_palm_lev.mol_vol,1))'; % to #/m3

    end 

    north_data = [];
    south_data = [];
    left_data = [];
    right_data = [];

    top_data = [];

    for tval_palm_xx_2 = 1:length(tval_palm)
        cams_ver_data = cams_proc.(char(cams_res_fie(cams_res_xx)));
        cams_ver_data_app = [];

        for req_lev_xx_2 = 1:length(CAMS_levels_req_str)
            cams_ver_data_tval = cams_ver_data.(CAMS_levels_req_str(req_lev_xx_2));
            cams_ver_data_app = cat(3, cams_ver_data_app, cams_ver_data_tval(:,:,tval_palm_xx_2));
        end

        inter_data = interp3(lat_cams_grid,lon_cams_grid,alt_cams_grid,cams_ver_data_app,lat_palm_grid,lon_palm_grid,alt_palm_grid, 'linear');

        if tval_palm_xx_2 == 1
            init_pro = squeeze(nanmean (inter_data, [1,2])) .* uni_con;
        end
        
        north_data_z_lev = [];
        south_data_z_lev = [];
        left_data_z_lev = [];
        right_data_z_lev = [];

        for z_val_palm_xx = 1:size(zval_palm,1)
            north_data_z_lev = cat(2, north_data_z_lev, squeeze(inter_data(:,end,z_val_palm_xx)).*uni_con(z_val_palm_xx));
            south_data_z_lev = cat(2, south_data_z_lev, squeeze(inter_data(:,1,z_val_palm_xx)).*uni_con(z_val_palm_xx));
            left_data_z_lev = cat(2, left_data_z_lev, squeeze(inter_data(1,:,z_val_palm_xx))'.*uni_con(z_val_palm_xx));
            right_data_z_lev = cat(2, right_data_z_lev, squeeze(inter_data(end,:,z_val_palm_xx))'.*uni_con(z_val_palm_xx));
        end
        
        north_data = cat(3, north_data, north_data_z_lev);
        south_data = cat(3, south_data, south_data_z_lev);
        left_data = cat(3, left_data, left_data_z_lev);
        right_data = cat(3, right_data, right_data_z_lev);


        top_data = cat(3, top_data, squeeze(inter_data(:,:,end)).* uni_con(end));

        if any(isnan(init_pro)) || any(isnan(north_data(:))) || any(isnan(south_data(:))) || any(isnan(left_data(:))) || any(isnan(right_data(:))) || any(isnan(top_data(:)))
            disp('Data contain nan values')
        end
    end

    final_result.(char(cams_res_fie(cams_res_xx))).int = init_pro;
    final_result.(char(cams_res_fie(cams_res_xx))).top= top_data;
    final_result.(char(cams_res_fie(cams_res_xx))).north = north_data;
    final_result.(char(cams_res_fie(cams_res_xx))).south = south_data;
    final_result.(char(cams_res_fie(cams_res_xx))).left = left_data;
    final_result.(char(cams_res_fie(cams_res_xx))).right= right_data;
    
end

end