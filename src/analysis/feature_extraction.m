%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: feature_extraction
%
% Description:
% Extracts spectral features from segmented EEG recordings for machine
% learning classification. Features include:
%   - Log-transformed band power
%   - C3-C4 asymmetry
%   - Cz versus lateral electrodes
%
% Inputs:
%   EEG_segmented - Segmented EEG recording
%
% Outputs:
%   X_all         - Feature matrix
%   feature_names - Names of all extracted features
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_freqanalysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [X_all, feature_names] = feature_extraction(EEG_segmented)

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

cfg.keeptrials = 'yes';

freq_features = ft_freqanalysis(cfg, EEG_segmented);

%% Frequency bands

band_limits = [ ...
     8 13
    13 20
    20 30
     8 30];

band_names = { ...
    'Mu_8_13'
    'BetaLow_13_20'
    'BetaHigh_20_30'
    'Motor_8_30'};

%% Initialize outputs

X_all = [];

feature_names = {};

%% Locate motor cortex channels

idx_C3 = find(strcmp(motor_channels,'C3'));

idx_Cz = find(strcmp(motor_channels,'Cz'));

idx_C4 = find(strcmp(motor_channels,'C4'));

%% Feature extraction

for band = 1:size(band_limits,1)

    idx_band = ...
        freq_features.freq >= band_limits(band,1) & ...
        freq_features.freq <= band_limits(band,2);

    band_power = squeeze( ...
        mean(freq_features.powspctrm(:,:,idx_band),3));

    band_power_log = log10(band_power + eps);

    X_all = [X_all band_power_log];

    for channel = 1:length(motor_channels)

        feature_names{end+1} = ...
            [motor_channels{channel} '_' band_names{band}];

    end

    %% C3-C4 asymmetry

    asym_C3_C4 = ...
        band_power_log(:,idx_C3) - band_power_log(:,idx_C4);

    %% Cz versus lateral cortex

    cz_vs_lateral = ...
        band_power_log(:,idx_Cz) - ...
        mean(band_power_log(:,[idx_C3 idx_C4]),2);

    X_all = [X_all asym_C3_C4 cz_vs_lateral];

    feature_names{end+1} = ...
        ['Asym_C3_minus_C4_' band_names{band}];

    feature_names{end+1} = ...
        ['Cz_minus_mean_C3_C4_' band_names{band}];

end

%% Summary

fprintf('\nFeature matrix created successfully.\n');

fprintf('Epochs: %d\n', size(X_all,1));

fprintf('Features: %d\n', size(X_all,2));

end