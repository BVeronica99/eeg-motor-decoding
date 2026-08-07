%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: load_data
%
% Description:
% Loads four BioSemi BDF recordings, removes the first five seconds from
% each acquisition, trims the remaining signal to ten minutes, and
% concatenates all recordings into a single continuous EEG dataset.
%
% Inputs:
%   None
%
% Outputs:
%   data                    - Concatenated EEG signal
%   fs                      - Sampling frequency (Hz)
%   file_duration_original  - Original duration of each recording (s)
%   file_duration_final     - Duration after trimming (s)
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_read_header
%   - ft_read_data
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [data, fs, file_duration_original, file_duration_final] = load_data()

%% Configuration

number_of_files = 4;
number_of_channels = 8;

seconds_to_remove_start = 5;
target_duration_seconds = 600;

%% Select BDF files

[filenames, pathname] = uigetfile( ...
    '*.bdf', ...
    'Select four BDF files in chronological order', ...
    'MultiSelect', 'on');

if isequal(filenames,0)
    error('No BDF files were selected.');
end

if ischar(filenames)
    filenames = {filenames};
end

if length(filenames) ~= number_of_files
    error('Exactly four BDF files must be selected.');
end

%% Initialize variables

data_all = [];
fs = [];

file_duration_original = zeros(number_of_files,1);
file_duration_final = zeros(number_of_files,1);

%% Read each BDF recording

for k = 1:number_of_files

    file = fullfile(pathname, filenames{k});

    header = ft_read_header(file);
    data_temp = ft_read_data(file);

    if isempty(fs)
        fs = header.Fs;
    end

    if header.Fs ~= fs
        error('The selected files do not share the same sampling frequency.');
    end

    % Keep only the EEG channels used in this project
    data_temp = data_temp(1:number_of_channels,:);
        % Record original duration
    original_samples = size(data_temp,2);
    file_duration_original(k) = original_samples / fs;

    % Compute trimming limits
    samples_to_remove_start = round(seconds_to_remove_start * fs);
    target_samples = round(target_duration_seconds * fs);

    start_sample = samples_to_remove_start + 1;
    end_sample = samples_to_remove_start + target_samples;

    % Verify recording length
    if size(data_temp,2) < end_sample
        error(['File ' filenames{k} ...
            ' is too short after removing the first five seconds.']);
    end

    % Keep only the desired recording segment
    data_temp = data_temp(:, start_sample:end_sample);

    % Store final recording duration
    file_duration_final(k) = size(data_temp,2) / fs;

    % Concatenate recordings
    data_all = [data_all data_temp];

end

%% Output data

data = data_all;

total_duration_seconds = size(data,2) / fs;

%% Display summary

fprintf('\nOriginal duration of each recording (s):\n');
disp(file_duration_original);

fprintf('Final duration of each recording (s):\n');
disp(file_duration_final);

fprintf(['Total concatenated recording: %.2f seconds ' ...
         '(%.2f minutes)\n'], ...
         total_duration_seconds, total_duration_seconds/60);

end