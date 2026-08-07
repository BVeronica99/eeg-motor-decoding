%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: run_decision_tree
%
% Description:
% Trains and evaluates a Decision Tree classifier using K-Fold
% Cross Validation.
%
% Inputs:
%   X             - Feature matrix
%   Y             - Class labels
%   feature_names - Predictor names
%   figure_title  - Confusion matrix title
%
% Outputs:
%   model         - Trained decision tree
%   accuracy      - Classification accuracy (%)
%   sensitivity   - Sensitivity (%)
%   specificity   - Specificity (%)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [model, accuracy, sensitivity, specificity] = ...
    run_decision_tree(X, Y, feature_names, figure_title)

rng(1)

cv = cvpartition(Y,'KFold',5);

model = fitctree( ...
    X,...
    Y,...
    'PredictorNames',feature_names,...
    'MinLeafSize',5);

CVModel = crossval(model,'CVPartition',cv);

Y_pred = kfoldPredict(CVModel);

confMat = confusionmat(Y,Y_pred);

TP = confMat(1,1);
FN = confMat(1,2);
FP = confMat(2,1);
TN = confMat(2,2);

accuracy = (TP + TN)/(TP+TN+FP+FN)*100;

sensitivity = TP/(TP+FN)*100;

specificity = TN/(TN+FP)*100;

figure

confusionchart( ...
    Y,...
    Y_pred,...
    'RowSummary','row-normalized',...
    'ColumnSummary','column-normalized')

title(figure_title)

view(model,'Mode','Graph');

end