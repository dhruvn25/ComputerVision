function [accuracy, f1_score] = evaluateImFGBG(gt_labels, labels, is_supervised)
    % Evaluates binary classification of FG & BG.
    %   In the unsupervised setting, we cannot determine if predicted
    %   background has label 0 or label 1 so we check against both
    %
    % Arguments:
    %   gt_labels : Image (w*h) containing 0 and 1 for background and foreground
    %       respectively
    %   labels : Image (w*h) of predicted foreground & background labels.
    %   is_supervised : Does not check against both flips of the labels if
    %   true
    % Returns:
    %   accuracy - best accuracy from labels as [0,1] or as [1,0]
    %   f1_score - best f1 score from labels as [0,1] or as [1,0]
    %
    % Modification History: 
    %   Arun Venkatraman, CV SPRING 2015: Initial Commits
    if nargin < 3
        is_supervised = false;
    end
    classes = sort(unique(labels(:)));
    if numel(classes) ~=  2
        error('This function looks for foreground vs background. Should have only two label types (classes) in labels')
    end
    if ~all(sort(unique(gt_labels(:))) == [0,1].')
        error('Ground truth labels should be 0 or 1. Wrong input order?');
    end
    
    % map the two class labels to 0 and 1 respectively
    labels01 = mapClasses(labels, [0,1]);
    [tp0, tn0, fn0, fp0] = evaluteMatch(gt_labels, labels01);
    accuracy_0 = (tp0+tn0)/(tp0+tn0+fp0+fn0);
    f1_0 = (2*tp0) / (2*tp0+fp0+fn0);
    
    if (~is_supervised)
        % Since we don't know if a 0 or 1 corresponds to foreground or
        % background, try both
        labels10 = mapClasses(labels, [1,0]);
        [tp1, tn1, fn1, fp1] = evaluteMatch(gt_labels, labels10);
        accuracy_1 = (tp1+tn1)/(tp1+tn1+fp1+fn1);
        f1_1 = (2*tp1) / (2*tp1+fp1+fn1);
        
        accuracy = max(accuracy_1, accuracy_0);
        f1_score = max(f1_0, f1_1);
    else
        accuracy = accuracy_0;
        f1_score = f1_0;
    end
end

function [tp,tn,fn,fp] = evaluteMatch(gt_labels, labels)
tp =  nnz( (labels == 1) & (gt_labels == 1) );
    tn =  nnz( (labels == 0) & (gt_labels == 0) );
    fn =  nnz( (labels == 0) & (gt_labels == 1) );
    fp =  nnz( (labels == 1) & (gt_labels == 0) );
end

function remapped = mapClasses(labels, new_set)
    remapped = nan(size(labels));
    classes = sort(unique(labels(:)));
    for n = 1:numel(classes)
        mask = labels == classes(n);
        remapped(mask) = new_set(n);
    end
end