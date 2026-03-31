function feat = extract_features_bhpf(f, H)

mag = abs(H);
phase = angle(H);

% ---- Core features ----
peak_mag = max(mag);

[~, idx] = max(mag);
center_freq = f(idx);

bandwidth = sum(mag > peak_mag/sqrt(2));

mean_mag = mean(mag);
std_mag = std(mag);

phase_mean = mean(phase);
phase_std = std(phase);

% ---- Slope (around peak) ----
if idx > 5 && idx < length(f)-5
    f1 = log10(f(idx-5));
    f2 = log10(f(idx+5));
    m1 = mag(idx-5);
    m2 = mag(idx+5);
    slope = (m2 - m1) / (f2 - f1);
else
    slope = 0;
end

% ---- IMPORTANT HPF FEATURES ----
low_freq_mag = mag(1);        % low frequency attenuation
high_freq_mag = mag(end);     % high frequency gain

transition_ratio = high_freq_mag / (low_freq_mag + 1e-6);

% ---- Final feature vector ----
feat = [peak_mag, center_freq, bandwidth, ...
        mean_mag, std_mag, phase_mean, phase_std, ...
        slope, low_freq_mag, high_freq_mag, transition_ratio];

end