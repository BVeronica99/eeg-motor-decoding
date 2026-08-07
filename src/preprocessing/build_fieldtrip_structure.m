%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: build_fieldtrip_structure
%
% Description:
% Creates a FieldTrip-compatible EEG structure from the concatenated EEG
% recordings.
%
% Inputs:
%   data - Concatenated EEG signal (channels × samples)
%   fs   - Sampling frequency (Hz)
%
% Outputs:
%   EEG  - FieldTrip data structure
%
% Dependencies:
%   - FieldTrip Toolbox
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function EEG = build_fieldtrip_structure(data, fs)

%% Channel labels

channels = { ...
    'Fz'
    'C3'
    'Cz'
    'C4'
    'Pz'
    'PO7'
    'Oz'
    'PO8'};

%% Create FieldTrip structure

EEG = struct;

EEG.trial = cell(1,1);
EEG.trial{1} = data;

EEG.fsample = fs;

EEG.label = channels;

EEG.sampleinfo = [1 size(data,2)];

EEG.time = cell(1,1);
EEG.time{1} = 0:1/fs:(size(data,2)/fs - 1/fs);

end