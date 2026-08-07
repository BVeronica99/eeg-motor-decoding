%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: frequency_analysis
%
% Description:
% Computes the power spectrum of each experimental condition using
% FieldTrip's multitaper FFT implementation.
%
% Inputs:
%   tasks - Cell array containing one FieldTrip structure for each
%           experimental condition
%
% Outputs:
%   freq_data - Cell array containing the power spectrum for every
%               experimental condition
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_freqanalysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function freq_data = frequency_analysis(tasks)

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

%% Frequency analysis configuration

cfg = [];

cfg.trials = 'all';
cfg.channel = motor_channels;

cfg.method = 'mtmfft';
cfg.output = 'pow';

cfg.foi = 8:0.25:30;

cfg.taper = 'hanning';

cfg.keeptrials = 'no';

%% Compute power spectra

number_of_conditions = length(tasks);

freq_data = cell(1, number_of_conditions);

for condition = 1:number_of_conditions

    freq_data{condition} = ft_freqanalysis(cfg, tasks{condition});

end

end