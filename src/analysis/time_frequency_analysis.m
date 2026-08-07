%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: time_frequency_analysis
%
% Description:
% Computes the time-frequency representation of each experimental
% condition using Morlet wavelets implemented in FieldTrip.
%
% Inputs:
%   tasks - Cell array containing one FieldTrip structure for each
%           experimental condition
%
% Outputs:
%   TF_data - Cell array containing the time-frequency representation
%             of each experimental condition
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_freqanalysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function TF_data = time_frequency_analysis(tasks)

%% Motor channels

motor_channels = { ...
    'Fz'
    'C3'
    'Cz'
    'C4'
    'Pz'
    'PO7'
    'Oz'
    'PO8'};

%% Wavelet configuration

cfg = [];

cfg.channel = motor_channels;

cfg.output = 'pow';

cfg.method = 'wavelet';

cfg.foi = 8:0.5:30;

cfg.toi = 0.5:0.1:4.5;

cfg.width = 6;

cfg.keeptrials = 'no';

%% Compute time-frequency representation

number_of_conditions = length(tasks);

TF_data = cell(1, number_of_conditions);

for condition = 1:number_of_conditions

    TF_data{condition} = ft_freqanalysis(cfg, tasks{condition});

end

end