clear; clc;

load('models/rf_model.mat');

% Generate ONE random faulty sample

f = logspace(1,6,500);

R1 = 1e4; R2 = 1e4; R3 = 1e4;
C1 = 1e-9; C2 = 1e-9;

% Inject fault (example: R1 increased)
R1 = R1 * 1.5;

H = sk_bpf_response(f, R1, R2, R3, C1, C2);

feat = extract_features(f, H);

pred = predict(mdl, feat);

fprintf('Predicted Fault Class: F%d\n', pred);