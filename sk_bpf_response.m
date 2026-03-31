function H = sk_bpf_response(f, R1, R2, R3, C1, C2)

w = 2*pi*f;
s = 1j*w;

% Simplified transfer function model
% (Good enough for ML dataset generation)

num = (s ./ (R2*C1));
den = s.^2 + (s*(1/(R1*C1) + 0.7/(R3*C2))) + (1/(R1*R3*C1*C2));

H = num ./ den;

end