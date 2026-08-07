%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: common_average_reference
%
% Description:
% Applies Common Average Reference (CAR) to the filtered EEG recording
% using FieldTrip.
%
% Inputs:
%   EEG_filtered - Filtered EEG recording
%
% Outputs:
%   EEG_referenced - EEG recording after Common Average Reference
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_preprocessing
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function EEG_referenced = common_average_reference(EEG_filtered)

%% Common Average Reference configuration

cfg = [];

cfg.reref = 'yes';
cfg.refchannel = 'all';

%% Apply Common Average Reference

EEG_referenced = ft_preprocessing(cfg, EEG_filtered);

end