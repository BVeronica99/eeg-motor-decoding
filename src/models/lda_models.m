%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: lda_models
%
% Description:
% Trains and evaluates the four Linear Discriminant Analysis (LDA)
% classifiers used in the project.
%
% Inputs:
%   X_all          - Feature matrix
%   labels_epochs  - Labels assigned to every epoch
%
% Outputs:
%   results - Structure containing all LDA models and metrics
%
% Dependencies:
%   - run_lda
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function results = lda_models(X_all, labels_epochs)

results = struct();

%% LDA 1

idx = labels_epochs==1 | labels_epochs==3;

X = X_all(idx,:);

Y_numeric = labels_epochs(idx);

valid = ~any(isnan(X),2);

X = X(valid,:);
Y_numeric = Y_numeric(valid);

Y = categorical(Y_numeric,[1 3],...
    {'Move Right Leg','Move Left Leg'});

[results.LDA1.Model,...
 results.LDA1.Accuracy,...
 results.LDA1.Sensitivity,...
 results.LDA1.Specificity] = ...
 run_lda(...
    X,...
    Y,...
    'LDA 1 - Move Right vs Move Left');

%% LDA 2

idx = labels_epochs==2 | labels_epochs==4;

X = X_all(idx,:);

Y_numeric = labels_epochs(idx);

valid = ~any(isnan(X),2);

X = X(valid,:);
Y_numeric = Y_numeric(valid);

Y = categorical(Y_numeric,[2 4],...
    {'Imagine Right Leg','Imagine Left Leg'});

[results.LDA2.Model,...
 results.LDA2.Accuracy,...
 results.LDA2.Sensitivity,...
 results.LDA2.Specificity] = ...
 run_lda(...
    X,...
    Y,...
    'LDA 2 - Imagine Right vs Imagine Left');

%% LDA 3

idx = labels_epochs>=1 & labels_epochs<=4;

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

[results.LDA3.Model,...
 results.LDA3.Accuracy,...
 results.LDA3.Sensitivity,...
 results.LDA3.Specificity] = ...
 run_lda(...
    X,...
    Y,...
    'LDA 3 - Right Leg vs Left Leg');

%% LDA 4

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

[results.LDA4.Model,...
 results.LDA4.Accuracy,...
 results.LDA4.Sensitivity,...
 results.LDA4.Specificity] = ...
 run_lda(...
    X,...
    Y,...
    'LDA 4 - Real Movement vs Rest');

end