clear; clc; close all;

load('data/dataset.mat');

% Split
X = normalize(X);
Y = categorical(Y);

cv = cvpartition(Y, 'HoldOut', 0.3, 'Stratify', true);

XTrain = X(training(cv), :);
YTrain = Y(training(cv));

XTest = X(test(cv), :);
YTest = Y(test(cv));

% Train model
t = templateTree(...
    'MaxNumSplits', 30, ...
    'MinLeafSize', 5);

mdl = fitcensemble(XTrain, YTrain, ...
    'Method','Bag', ...
    'NumLearningCycles', 200, 'Learners', t);

% Save model
save('models/rf_model.mat', 'mdl');

% Predict
YPred = predict(mdl, XTest);

% Accuracy
accuracy = sum(YPred == YTest)/length(YTest);

fprintf('Accuracy: %.2f%%\n', accuracy*100);

% Confusion matrix
confusionchart(YTest, YPred);