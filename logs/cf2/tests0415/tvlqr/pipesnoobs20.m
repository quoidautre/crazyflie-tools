function [d imFnames]=pipesnoobs20()
full_fname = 'pipesnoobs20.mat';
fname = '/home/drc/code/crazyflie-tools/logs/cf2/tests0415/tvlqr/pipesnoobs20.mat';
if (exist(full_fname,'file'))
    filename = full_fname;
else
    filename = fname;
end
d = load(filename);