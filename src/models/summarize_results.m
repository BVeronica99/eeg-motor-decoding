%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: summarize_results
%
% Description:
% Creates a summary table containing the performance metrics of all
% Decision Tree and LDA classifiers.
%
% Inputs:
%   tree_results - Structure containing Decision Tree results
%   lda_results  - Structure containing LDA results
%
% Outputs:
%   Results_Table - Summary table
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Results_Table = summarize_results(tree_results, lda_results)

Classifier = { ...
    'Tree 1'
    'LDA 1'
    'Tree 2'
    'LDA 2'
    'Tree 3'
    'LDA 3'
    'Tree 4'
    'LDA 4'};

Comparison = { ...
    'Move Right vs Move Left'
    'Move Right vs Move Left'
    'Imagine Right vs Imagine Left'
    'Imagine Right vs Imagine Left'
    'Right Leg vs Left Leg'
    'Right Leg vs Left Leg'
    'Real Movement vs Rest'
    'Real Movement vs Rest'};

Accuracy = [ ...
    tree_results.Tree1.Accuracy
    lda_results.LDA1.Accuracy
    tree_results.Tree2.Accuracy
    lda_results.LDA2.Accuracy
    tree_results.Tree3.Accuracy
    lda_results.LDA3.Accuracy
    tree_results.Tree4.Accuracy
    lda_results.LDA4.Accuracy];

Sensitivity = [ ...
    tree_results.Tree1.Sensitivity
    lda_results.LDA1.Sensitivity
    tree_results.Tree2.Sensitivity
    lda_results.LDA2.Sensitivity
    tree_results.Tree3.Sensitivity
    lda_results.LDA3.Sensitivity
    tree_results.Tree4.Sensitivity
    lda_results.LDA4.Sensitivity];

Specificity = [ ...
    tree_results.Tree1.Specificity
    lda_results.LDA1.Specificity
    tree_results.Tree2.Specificity
    lda_results.LDA2.Specificity
    tree_results.Tree3.Specificity
    lda_results.LDA3.Specificity
    tree_results.Tree4.Specificity
    lda_results.LDA4.Specificity];

Results_Table = table( ...
    Classifier,...
    Comparison,...
    Accuracy,...
    Sensitivity,...
    Specificity);

fprintf('\nClassification Summary\n');

disp(Results_Table);

end