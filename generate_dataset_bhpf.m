clear; clc;

f = logspace(3, 5, 1000);   % Optimized frequency range
samples_per_class = 200;

% Nominal values
R1_nom = 1e4; R2_nom = 1e4; R3_nom = 1e4; R4_nom = 1e4;
C1_nom = 1e-9; C2_nom = 1e-9;

X = [];
Y = [];

for class = 0:12

    for i = 1:samples_per_class

        % Reduced tolerance
        tol = 0.05;

        R1 = R1_nom * (1 + tol*randn);
        R2 = R2_nom * (1 + tol*randn);
        R3 = R3_nom * (1 + tol*randn);
        R4 = R4_nom * (1 + tol*randn);

        C1 = C1_nom * (1 + tol*randn);
        C2 = C2_nom * (1 + tol*randn);

        % Fault injection
        switch class
            case 1, R1 = R1 * 1.8;
            case 2, R1 = R1 * 0.4;
            case 3, R2 = R2 * 1.8;
            case 4, R2 = R2 * 0.4;
            case 5, R3 = R3 * 1.8;
            case 6, R3 = R3 * 0.4;
            case 7, R4 = R4 * 1.8;
            case 8, R4 = R4 * 0.4;
            case 9, C1 = C1 * 1.8;
            case 10, C1 = C1 * 0.4;
            case 11, C2 = C2 * 1.8;
            case 12, C2 = C2 * 0.4;
        end

        % Get response
        H = bhpf_response(f, R1, R2, R3, R4, C1, C2);

        % Extract features
        features = extract_features_bhpf(f, H);

        X = [X; features];
        Y = [Y; class];

    end
end

save('data/dataset_bhpf.mat', 'X', 'Y');

disp('BHPF Dataset Generated!');