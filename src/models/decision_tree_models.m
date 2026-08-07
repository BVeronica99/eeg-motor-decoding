%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: decision_tree_models
%
% Description:
% Trains and evaluates the four Decision Tree classifiers used in the
% project.
%
% Inputs:
%   X_all          - Feature matrix
%   labels_epochs  - Labels assigned to every epoch
%   feature_names  - Predictor names
%
% Outputs:
%   results - Structure containing all Decision Tree models and metrics
%
% Dependencies:
%   - run_decision_tree
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = decision_tree_models(X_all, labels_epochs, feature_names)

results = struct();

%% TREE 1
% Task 1 vs Task 3
% Move Right Leg vs Move Left Leg

idx = labels_epochs == 1 | labels_epochs == 3;

X = X_all(idx,:);

Y_numeric = labels_epochs(idx);

valid = ~any(isnan(X),2);

X = X(valid,:);
Y_numeric = Y_numeric(valid);

Y = categorical(Y_numeric,[1 3],...
    {'Move Right Leg','Move Left Leg'});

[results.Tree1.Model,...
 results.Tree1.Accuracy,...
 results.Tree1.Sensitivity,...
 results.Tree1.Specificity] = ...
 run_decision_tree(...
    X,...
    Y,...
    feature_names,...
    'Decision Tree 1 - Move Right vs Move Left');

%% TREE 2
% Task 2 vs Task 4
% Imagine Right Leg vs Imagine Left Leg

idx = labels_epochs == 2 | labels_epochs == 4;

X = X_all(idx,:);

Y_numeric = labels_epochs(idx);

valid = ~any(isnan(X),2);

X = X(valid,:);
Y_numeric = Y_numeric(valid);

Y = categorical(Y_numeric,[2 4],...
    {'Imagine Right Leg','Imagine Left Leg'});

[results.Tree2.Model,...
 results.Tree2.Accuracy,...
 results.Tree2.Sensitivity,...
 results.Tree2.Specificity] = ...
 run_decision_tree(...
    X,...
    Y,...
    feature_names,...
    'Decision Tree 2 - Imagine Right vs Imagine Left');

%% TREE 3
% Right Leg vs Left Leg

idx = labels_epochs >= 1 & labels_epochs <= 4;

X = X_all(idx,:);

Y_original = labels_epochs(idx);

Y_numeric = zeros(size(Y_original));

Y_numeric(Y_original==1 | Y_original==2)=1;
Y_numeric(Y_original==3 | Y_original==4)=2;

valid = ~any(isnan(X),2);

X = X(valid,:);
Y_numeric = Y_numeric(valid);

Y = categorical(Y_numeric,[1 2],...
    {'Right Leg','Left Leg'});

[results.Tree3.Model,...
 results.Tree3.Accuracy,...
 results.Tree3.Sensitivity,...
 results.Tree3.Specificity] = ...
 run_decision_tree(...
    X,...
    Y,...
    feature_names,...
    'Decision Tree 3 - Right Leg vs Left Leg');

%% TREE 4
% Rest vs Real Movement

idx = labels_epochs==0 | labels_epochs==1 | labels_epochs==3;

X = X_all(idx,:);

Y_original = labels_epochs(idx);

Y_numeric = zeros(size(Y_original));

Y_numeric(Y_original==0)=0;
Y_numeric(Y_original==1 | Y_original==3)=1;

valid = ~any(isnan(X),2);

X = X(valid,:);
Y_numeric = Y_numeric(valid);

Y = categorical(Y_numeric,[1 0],...
    {'Real Movement','Rest'});

[results.Tree4.Model,...
 results.Tree4.Accuracy,...
 results.Tree4.Sensitivity,...
 results.Tree4.Specificity] = ...
 run_decision_tree(...
    X,...
    Y,...
    feature_names,...
    'Decision Tree 4 - Real Movement vs Rest');

end