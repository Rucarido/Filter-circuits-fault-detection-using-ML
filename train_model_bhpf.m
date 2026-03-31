clear; clc; close all;

load('data/dataset_bhpf.mat');

% Convert labels to categorical
Y = categorical(Y);

% Normalize features
X = normalize(X);

% Stratified split
cv = cvpartition(Y, 'HoldOut', 0.3);

XTrain = X(training(cv), :);
YTrain = Y(training(cv));

XTest = X(test(cv), :);
YTest = Y(test(cv));

% Define tree template
t = templateTree(...
    'MaxNumSplits', 30, ...
    'MinLeafSize', 5);

% Train Random Forest (fitcensemble)
mdl = fitcensemble(XTrain, YTrain, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 200, ...
    'Learners', t);

% Save model
save('models/rf_model_bhpf.mat', 'mdl');

% Predict
YPred = predict(mdl, XTest);

% Accuracy
accuracy = sum(YPred == YTest)/length(YTest);

fprintf('BHPF Accuracy: %.2f%%\n', accuracy*100);

% Confusion matrix
confusionchart(YTest, YPred);