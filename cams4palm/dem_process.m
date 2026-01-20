function [lat_dem_mat, lon_dem_mat] = dem_process (dem_palm_file)
warning('off')

[img, R] = geotiffread(dem_palm_file);
[rows, cols, ~] = size(img);

[colGrid, rowGrid] = meshgrid(1:cols, 1:rows);

[xGrid, yGrid] = intrinsicToWorld(R, colGrid, rowGrid);

projIn = projcrs(25832, 'Authority', 'EPSG'); 
projOut = geocrs(4326);

[lat_dem_mat, lon_dem_mat] = projinv(projIn, xGrid, yGrid);

end