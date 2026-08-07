%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function: run_lda
%
% Description:
% Trains and evaluates a Linear Discriminant Analysis (LDA) classifier
% using K-Fold Cross Validation.
%
% Inputs:
%   X             - Feature matrix
%   Y             - Class labels
%   figure_title  - Confusion matrix title
%
% Outputs:
%   model         - Trained LDA model
%   accuracy      - Classification accuracy (%)
%   sensitivity   - Sensitivity (%)
%   specificity   - Specificity (%)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [model, accuracy, sensitivity, specificity] = ...
    run_lda(X, Y, figure_title)

rng(1)

cv = cvpartition(Y,'KFold',5);

model = fitcdiscr( ...
    X,...
    Y,...
    'DiscrimType','pseudolinear',...
    'CVPartition',cv);

Y_pred = kfoldPredict(model);

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

end