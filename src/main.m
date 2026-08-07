%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% EEG Motor Intent Classification Pipeline
%
% Description:
% Main script for the complete EEG analysis workflow.
%
% Pipeline:
%
%   1. Load EEG recordings
%   2. Build FieldTrip structure
%   3. Preprocess EEG
%   4. Apply Common Average Reference
%   5. Segment EEG into epochs
%   6. Label experimental conditions
%   7. Frequency-domain analysis
%   8. Time-frequency analysis
%   9. Compute ERD/ERS
%  10. Generate visualization figures
%  11. Extract features
%  12. Train Decision Tree classifiers
%  13. Train LDA classifiers
%  14. Generate performance summary
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
clc
close all

%% Add project folders

addpath(genpath('preprocessing'))
addpath(genpath('analysis'))
addpath(genpath('models'))
addpath(genpath('utils'))

%% Load EEG recordings

[data, fs, file_duration_original, file_duration_final] = load_data();

%% Build FieldTrip structure

EEG = build_fieldtrip_structure(data, fs);

%% Preprocess EEG

EEG_filtered = preprocess_signal(EEG);

%% Apply Common Average Reference

EEG_referenced = common_average_reference(EEG_filtered);

%% Segment EEG into epochs

EEG_segmented = epoch_data(EEG_referenced);

%% Label experimental conditions

[tasks, conditions, condition_labels, labels_epochs] = ...
    label_conditions(EEG_segmented);

%% Frequency-domain analysis

freq_data = frequency_analysis(tasks);

%% Time-frequency analysis

TF_data = time_frequency_analysis(tasks);

%% Compute ERD/ERS

ERDERS_data = compute_erd_ers(TF_data);

%% Generate figures

plot_topographies(ERDERS_data, conditions);

%% Feature extraction

[X_all, feature_names] = ...
    feature_extraction(EEG_segmented);

%% Decision Tree models

tree_results = decision_tree_models( ...
    X_all,...
    labels_epochs,...
    feature_names);

%% LDA models

lda_results = lda_models( ...
    X_all,...
    labels_epochs);

%% Summary table

Results_Table = summarize_results( ...
    tree_results,...
    lda_results);

disp(' ')
disp('==========================================')
disp(' EEG MOTOR INTENT CLASSIFICATION COMPLETE ')
disp('==========================================')