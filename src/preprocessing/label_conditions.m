%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: label_conditions
%
% Description:
% Assigns experimental condition labels to each EEG epoch according to the
% acquisition protocol and separates the dataset into individual FieldTrip
% structures for each experimental condition.
%
% Inputs:
%   EEG_segmented - EEG recording segmented into epochs
%
% Outputs:
%   tasks             - Cell array containing one FieldTrip structure per
%                       experimental condition
%   conditions        - Names of the experimental conditions
%   condition_labels  - Numeric labels assigned to each condition
%   labels_epochs     - Label assigned to every epoch
%
% Dependencies:
%   - FieldTrip Toolbox
%   - ft_selectdata
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [tasks, conditions, condition_labels, labels_epochs] = ...
    label_conditions(EEG_segmented)

%% Experimental protocol
%
% One experimental cycle (60 seconds):
%
%   5 s   Rest
%  10 s   Task 1
%   5 s   Rest
%  10 s   Task 2
%   5 s   Rest
%  10 s   Task 3
%   5 s   Rest
%  10 s   Task 4
%
% Since every epoch lasts 5 seconds:
%
% Rest  = 1 epoch
% Task  = 2 consecutive epochs
%

labels_one_cycle = [ ...
    0 ...
    1 1 ...
    0 ...
    2 2 ...
    0 ...
    3 3 ...
    0 ...
    4 4];

epochs_per_cycle = length(labels_one_cycle);

number_of_epochs = length(EEG_segmented.trial);

if mod(number_of_epochs, epochs_per_cycle) ~= 0
    error('The number of epochs is not compatible with the experimental protocol.');
end

number_of_cycles = number_of_epochs / epochs_per_cycle;

labels_epochs = repmat(labels_one_cycle,1,number_of_cycles);

labels_epochs = labels_epochs(:);

%% Display label distribution

fprintf('\nEpoch distribution:\n');

fprintf('Rest:   %d\n', sum(labels_epochs == 0));
fprintf('Task 1: %d\n', sum(labels_epochs == 1));
fprintf('Task 2: %d\n', sum(labels_epochs == 2));
fprintf('Task 3: %d\n', sum(labels_epochs == 3));
fprintf('Task 4: %d\n', sum(labels_epochs == 4));

%% Locate epochs

idx_rest = find(labels_epochs == 0);

idx_task1 = find(labels_epochs == 1);

idx_task2 = find(labels_epochs == 2);

idx_task3 = find(labels_epochs == 3);

idx_task4 = find(labels_epochs == 4);

%% Separate each condition

cfg = [];
cfg.trials = idx_rest;
task_rest = ft_selectdata(cfg, EEG_segmented);

cfg.trials = idx_task1;
task_1 = ft_selectdata(cfg, EEG_segmented);

cfg.trials = idx_task2;
task_2 = ft_selectdata(cfg, EEG_segmented);

cfg.trials = idx_task3;
task_3 = ft_selectdata(cfg, EEG_segmented);

cfg.trials = idx_task4;
task_4 = ft_selectdata(cfg, EEG_segmented);

%% Store outputs

conditions = { ...
    'Rest'
    'Task 1'
    'Task 2'
    'Task 3'
    'Task 4'};

condition_labels = [0 1 2 3 4];

tasks = { ...
    task_rest
    task_1
    task_2
    task_3
    task_4};

end