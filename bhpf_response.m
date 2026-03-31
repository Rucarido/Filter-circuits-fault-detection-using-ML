function H = bhpf_response(f, R1, R2, R3, R4, C1, C2)

w = 2*pi*f;
s = 1j*w;

% Gain
K = (R2 / R1) * (R4 / R3);

% Natural frequency
w0 = 1 / sqrt(R3 * R4 * C1 * C2);

% Quality factor
Q = sqrt(R3 * R4 * C1 * C2) / (R3*C2 + 0.5*R4*C1);

% Transfer function (High-pass)
H = K * (s.^2) ./ (s.^2 + (w0/Q)*s + w0^2);

end