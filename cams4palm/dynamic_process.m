function [palm_run_start_time, xval_palm, yval_palm, zval_palm, tval_palm] = dynamic_process(dynamic_dri_file)

dynamic_info = ncinfo(dynamic_dri_file);

palm_run_start_time = datetime(dynamic_info.Attributes(11).Value,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSSSSSSSS Z', 'TimeZone', 'UTC');
palm_run_end_time = datetime(dynamic_info.Attributes(12).Value,'InputFormat','yyyy-MM-dd''T''HH:mm:ss.SSSSSSSSS Z', 'TimeZone', 'UTC');

xval_palm = ncread(dynamic_dri_file, 'x');
yval_palm = ncread(dynamic_dri_file, 'y');
zval_palm = ncread(dynamic_dri_file, 'z');
tval_palm = ncread(dynamic_dri_file, 'time');

end