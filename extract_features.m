%{
function feat = extract_features(f, H)

mag = abs(H);
phase = angle(H);

% Features
peak_mag = max(mag);

[~, idx] = max(mag);
center_freq = f(idx);

bandwidth = sum(mag > peak_mag/sqrt(2));

mean_mag = mean(mag);
std_mag = std(mag);

phase_mean = mean(phase);
phase_std = std(phase);

feat = [peak_mag, center_freq, bandwidth, ...
        mean_mag, std_mag, phase_mean, phase_std];

end
%}
function feat = extract_features(f, H)

mag = abs(H);
phase = angle(H);

% ---- Existing features ----
peak_mag = max(mag);

[~, idx] = max(mag);
center_freq = f(idx);

bandwidth = sum(mag > peak_mag/sqrt(2));

mean_mag = mean(mag);
std_mag = std(mag);

phase_mean = mean(phase);
phase_std = std(phase);

% ---- NEW FEATURE: slope around peak ----

% Ensure we have points around peak
if idx > 5 && idx < length(f)-5
    
    f1 = log10(f(idx-5));
    f2 = log10(f(idx+5));
    
    m1 = mag(idx-5);
    m2 = mag(idx+5);
    
    slope = (m2 - m1) / (f2 - f1);  % slope in log-frequency scale

else
    slope = 0;  % edge case
end

left_slope  = (mag(idx) - mag(idx-5)) / (log10(f(idx)) - log10(f(idx-5)));
right_slope = (mag(idx+5) - mag(idx)) / (log10(f(idx+5)) - log10(f(idx)));

% ---- Final feature vector ----
feat = [peak_mag, center_freq, bandwidth, ...
        mean_mag, std_mag, phase_mean, phase_std, slope, ...
        left_slope, right_slope];

end