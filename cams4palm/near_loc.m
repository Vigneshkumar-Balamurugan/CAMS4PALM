function [near_lat_bot, near_lat_top, near_lon_left, near_lon_right] = near_loc (lat_dem_mat, lon_dem_mat, cams_file_lat, cams_file_lon)

[~,near_lat_bot] = min(abs(min(lat_dem_mat(:)) - cams_file_lat));
[~,near_lat_top] = min(abs(max(lat_dem_mat(:)) - cams_file_lat));

[~,near_lon_left] = min(abs(min(lon_dem_mat(:)) - cams_file_lon));
[~,near_lon_right] = min(abs(max(lon_dem_mat(:)) - cams_file_lon));


end