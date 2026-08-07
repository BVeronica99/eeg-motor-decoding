%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: epoch_data
%
% Description:
% Segments the continuous EEG recording into 480 non-overlapping epochs
% of 5 seconds each using FieldTrip.
%
% Inputs:
%   EEG_referenced - EEG recording after Common Average Reference
%
% Outputs:
%   EEG_segmented - EEG recording segmented into epochs
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_redefinetrial
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function EEG_segmented = epoch_data(EEG_referenced)

%% Epoch configuration

epoch_length = 5;          % seconds
required_epochs = 480;

fs = EEG_referenced.fsample;

samples_per_epoch = epoch_length * fs;
required_samples = required_epochs * samples_per_epoch;

%% Verify recording length

if size(EEG_referenced.trial{1},2) < required_samples
    error('The recording does not contain enough data to generate 480 epochs.');
end

%% Keep only the required samples

EEG_referenced.trial{1} = EEG_referenced.trial{1}(:,1:required_samples);

EEG_referenced.time{1} = EEG_referenced.time{1}(1:required_samples);

EEG_referenced.sampleinfo = [1 required_samples];

%% Create trial definition matrix

trl = zeros(required_epochs,3);

for epoch = 1:required_epochs

    start_sample = (epoch-1) * samples_per_epoch + 1;

    end_sample = epoch * samples_per_epoch;

    trl(epoch,1) = start_sample;
    trl(epoch,2) = end_sample;
    trl(epoch,3) = 0;

end

%% Segment EEG

cfg = [];
cfg.trl = trl;

EEG_segmented = ft_redefinetrial(cfg, EEG_referenced);

%% Rebuild time vectors

for epoch = 1:length(EEG_segmented.time)

    EEG_segmented.time{epoch} = 0:1/fs:(epoch_length - 1/fs);

end

fprintf('Total epochs generated: %d\n', length(EEG_segmented.trial));

end