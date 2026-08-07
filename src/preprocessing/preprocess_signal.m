%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: preprocess_signal
%
% Description:
% Applies the preprocessing pipeline to the EEG recording using
% FieldTrip. The preprocessing includes:
%   - High-pass filtering
%   - Low-pass filtering
%   - Notch filtering
%
% Inputs:
%   EEG - Raw EEG recording in FieldTrip format
%
% Outputs:
%   EEG_filtered - Filtered EEG recording
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_preprocessing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function EEG_filtered = preprocess_signal(EEG)

%% Filter configuration

filter_order = 60;

cfg = [];

cfg.continuous = 'yes';
cfg.channel = 'all';

%% High-pass filter

cfg.hpfilter = 'yes';
cfg.hpfreq = 5;
cfg.hpfiltord = filter_order;
cfg.hpfilttype = 'fir';

%% Low-pass filter

cfg.lpfilter = 'yes';
cfg.lpfreq = 35;
cfg.lpfiltord = filter_order;
cfg.lpfilttype = 'fir';

%% Notch filter

cfg.bsfilter = 'yes';
cfg.bsfreq = [59 61];
cfg.bsfiltord = filter_order;
cfg.bsfilttype = 'fir';

%% Apply preprocessing

EEG_filtered = ft_preprocessing(cfg, EEG);

end