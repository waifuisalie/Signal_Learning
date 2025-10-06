%% ============================================================================
%% EXAM PRACTICE TEMPLATE
%% ============================================================================
% Use this template to solve practice problems and exam-style questions
%
% INSTRUCTIONS:
% 1. Copy this file and rename (e.g., problem1.m, practice_convolution.m)
% 2. Fill in each section with your solution
% 3. Run and verify results
%
% STRUCTURE:
% - Problem statement
% - Given data
% - Step-by-step solution
% - Verification
% - Visualization
%% ============================================================================

%% --- INITIALIZATION ---
clear; clc; close all;

% Add utilities to path (if not already done)
addpath('../Utilities');

%% ============================================================================
%% PROBLEM STATEMENT
%% ============================================================================
% [Copy the exam question here]
%
% Example:
% "Given x[n] = {1,2,3,4} for n∈[0,3] and h[n] = {1,-1} for n∈[0,1],
%  find y[n] = x[n] * h[n] using convolution"

%% ============================================================================
%% GIVEN DATA
%% ============================================================================
% Define all given signals, parameters, and conditions

% Example:
% x = [1, 2, 3, 4];
% nx = 0:3;
%
% h = [1, -1];
% nh = 0:1;

%% ============================================================================
%% SOLUTION - STEP 1: [Describe what you're doing]
%% ============================================================================
% Break down the problem into clear steps
% Add comments explaining your reasoning

% Example:
% % Step 1: Verify input signals
% figure;
% subplot(2,1,1); stem(nx, x, 'filled'); title('Input x[n]'); grid on;
% subplot(2,1,2); stem(nh, h, 'filled'); title('Impulse Response h[n]'); grid on;

%% ============================================================================
%% SOLUTION - STEP 2: [Next step]
%% ============================================================================

% Example:
% % Step 2: Compute convolution using conv_m
% [y, ny] = conv_m(x, nx, h, nh);
%
% % Verify: Output length should be len(x) + len(h) - 1
% expected_length = length(x) + length(h) - 1;
% fprintf('Expected length: %d\n', expected_length);
% fprintf('Actual length: %d\n', length(y));

%% ============================================================================
%% SOLUTION - STEP 3: [Additional steps as needed]
%% ============================================================================

% Continue with more steps if needed...

%% ============================================================================
%% VERIFICATION
%% ============================================================================
% Check your answer using alternative methods or known properties

% Example:
% % Method 1: Use standard conv() and adjust indices
% y_check = conv(x, h);
% ny_check = (nx(1)+nh(1)) : (nx(end)+nh(end));
%
% % Compare results
% if isequal(y, y_check) && isequal(ny, ny_check)
%     fprintf('✓ Verification passed!\n');
% else
%     fprintf('✗ Results do not match - check your work\n');
% end

%% ============================================================================
%% VISUALIZATION
%% ============================================================================
% Plot your results

% Example:
% figure;
% stem(ny, y, 'filled', 'LineWidth', 1.5);
% title('Convolution Result y[n] = x[n] * h[n]');
% xlabel('n'); ylabel('y[n]'); grid on;

%% ============================================================================
%% ANSWER SUMMARY
%% ============================================================================
% Clearly state your final answer

% Example:
% fprintf('\n=== FINAL ANSWER ===\n');
% fprintf('y[n] = [');
% fprintf('%g ', y);
% fprintf(']\n');
% fprintf('for n ∈ [%d, %d]\n\n', ny(1), ny(end));

%% ============================================================================
%% PROBLEM-SPECIFIC TEMPLATES
%% ============================================================================

%% --- TEMPLATE TYPE 1: SIGNAL OPERATIONS ---
% % Given: Multiple signal operations
% % Step 1: Define base signal
% x = [...];
% n = ...;
%
% % Step 2: Perform each operation
% [x_shifted, n_shifted] = sigshift(x, n, k);
% [x_folded, n_folded] = sigfold(x, n);
%
% % Step 3: Combine
% [y, ny] = sigadd(x_shifted, n_shifted, x_folded, n_folded);
%
% % Step 4: Plot
% stem(ny, y, 'filled');

%% --- TEMPLATE TYPE 2: SYSTEM ANALYSIS ---
% % Given: Difference equation or h[n]
% % Step 1: Extract coefficients
% % Equation: y[n] + a1*y[n-1] + a2*y[n-2] = b0*x[n] + b1*x[n-1]
% a = [1, -a1, -a2];  % Note: inverted signs!
% b = [b0, b1];
%
% % Step 2: Create input (impulse or step)
% [x, n] = impseq(0, 0, 50);  % or stepseq
%
% % Step 3: Compute response
% y = filter(b, a, x);
%
% % Step 4: Analyze
% stem(n, y, 'filled');
% title('System Response');

%% --- TEMPLATE TYPE 3: FOURIER SYNTHESIS ---
% % Given: Waveform type and parameters
% F = 50;          % Fundamental frequency (Hz)
% Fs = 8000;       % Sampling frequency (Hz)
% N_harmonics = 20; % Number of harmonics
%
% % Time vector
% T = 1/F;
% t = 0:1/Fs:5*T;
%
% % Synthesis (example: square wave)
% y = zeros(size(t));
% for k = 1:2:(2*N_harmonics-1)  % Odd harmonics only
%     y = y + (4/pi) * (1/k) * sin(2*pi*k*F*t);
% end
%
% % Plot
% figure;
% plot(t, y, 'LineWidth', 1.5);
% title('Square Wave Synthesis');
% xlabel('Time (s)'); ylabel('Amplitude'); grid on;

%% --- TEMPLATE TYPE 4: FFT ANALYSIS ---
% % Given: Time-domain signal
% % Assume signal x and Fs are defined
%
% % Compute FFT
% L = length(x);
% Y = fft(x);
% P2 = abs(Y/L);
% P1 = P2(1:floor(L/2)+1);
% P1(2:end-1) = 2*P1(2:end-1);
% f = Fs*(0:floor(L/2))/L;
%
% % Plot spectrum
% figure;
% stem(f, P1, 'Marker', 'none');
% title('Frequency Spectrum');
% xlabel('Frequency (Hz)'); ylabel('Magnitude');
% grid on; xlim([0 500]);

%% --- TEMPLATE TYPE 5: ALIASING PROBLEM ---
% % Given: Analog frequency f and sampling rate Fs
% f_analog = 1500;  % Hz
% Fs = 2000;        % Hz
%
% % Check Nyquist
% f_Nyquist = Fs/2;
% fprintf('Nyquist frequency: %.1f Hz\n', f_Nyquist);
%
% if f_analog > f_Nyquist
%     fprintf('ALIASING occurs!\n');
%     f_apparent = abs(f_analog - Fs);
%     fprintf('Apparent frequency: %.1f Hz\n', f_apparent);
% else
%     fprintf('No aliasing (f < Nyquist)\n');
% end
%
% % Normalized frequency
% omega = 2*pi*f_analog/Fs;
% fprintf('Normalized frequency: %.3f rad/sample\n', omega);

%% --- TEMPLATE TYPE 6: PERIODICITY TEST ---
% % Given: x[n] = cos(omega*n), check if periodic
% omega = 3*pi/8;  % Example
%
% % Test: omega/(2*pi) must be rational
% ratio = omega/(2*pi);
% fprintf('omega/(2*pi) = %.6f\n', ratio);
%
% % Try to find k/N representation
% % (In practice, use symbolic or approximation)
% % If rational: periodic with period N
% % If irrational: not periodic

%% ============================================================================
%% NOTES AND REMINDERS
%% ============================================================================
%
% COMMON EXAM TOPICS:
% 1. Multi-step signal operations (Lab 2)
% 2. filter() coefficient extraction (Lab 3)
% 3. Convolution with arbitrary indices (Lab 3)
% 4. Fourier synthesis formulas (Lab 4)
% 5. FFT interpretation (Lab 4)
% 6. Aliasing detection (Lab 1)
% 7. Periodicity testing (Lab 1)
%
% QUICK REFERENCE:
% • impseq(n0,n1,n2): δ[n-n0] for n∈[n1,n2]
% • stepseq(n0,n1,n2): u[n-n0] for n∈[n1,n2]
% • sigshift(x,m,k): y[n]=x[n-k] (k>0=delay)
% • sigfold(x,n): y[n]=x[-n]
% • filter([b],[a],x): difference equation
% • conv_m(x,nx,h,nh): convolution with indices
%
% FORMULAS TO MEMORIZE:
% • ω = 2πf/Fs
% • Square: (4/π)Σ[sin(2πkFt)/k], k=odd
% • Triangle: (8/π²)Σ[(-1)^... sin(...)/k²], k=odd
% • Sawtooth: (2/π)Σ[sin(2πkFt)/k], k=all
%
%% ============================================================================
