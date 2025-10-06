%% ============================================================================
%% SETUP SCRIPT - Signal Studies RA1 Exam Prep
%% ============================================================================
% This script configures your MATLAB environment for the lab exercises
% Run this once at the start of each session
%% ============================================================================

fprintf('\n');
fprintf('========================================\n');
fprintf('  Signal Studies RA1 - Setup\n');
fprintf('========================================\n\n');

%% --- Add Utilities to Path ---
fprintf('Configuring MATLAB path...\n');

% Get current script directory
script_dir = fileparts(mfilename('fullpath'));

% Add Utilities folder
utilities_path = fullfile(script_dir, 'Utilities');

if isfolder(utilities_path)
    addpath(utilities_path);
    fprintf('✓ Added Utilities folder to path\n');
else
    fprintf('✗ ERROR: Utilities folder not found!\n');
    fprintf('  Expected location: %s\n', utilities_path);
    return;
end

%% --- Verify Critical Functions ---
fprintf('\nVerifying utility functions...\n');

critical_functions = {
    'impseq', 'stepseq', 'sigadd', 'sigmult', ...
    'sigshift', 'sigfold', 'evenodd', 'conv_m'
};

all_ok = true;
for i = 1:length(critical_functions)
    func_name = critical_functions{i};
    if ~isempty(which(func_name))
        fprintf('  ✓ %s\n', func_name);
    else
        fprintf('  ✗ %s NOT FOUND\n', func_name);
        all_ok = false;
    end
end

%% --- Check Lab Folders ---
fprintf('\nChecking lab folders...\n');

lab_folders = {
    'Lab1_Discrete_Sequences', ...
    'Lab2_Signal_Operations', ...
    'Lab3_LTI_Systems', ...
    'Lab4_Fourier_Analysis', ...
    'Exam_Practice'
};

for i = 1:length(lab_folders)
    folder_path = fullfile(script_dir, lab_folders{i});
    if isfolder(folder_path)
        fprintf('  ✓ %s\n', lab_folders{i});
    else
        fprintf('  ✗ %s NOT FOUND\n', lab_folders{i});
        all_ok = false;
    end
end

%% --- Final Status ---
fprintf('\n========================================\n');

if all_ok
    fprintf('  ✓ Setup Complete!\n');
    fprintf('========================================\n\n');

    fprintf('You can now run any lab:\n\n');
    fprintf('  Lab 1: cd Lab1_Discrete_Sequences; lab1_main\n');
    fprintf('  Lab 2: cd Lab2_Signal_Operations; lab2_main\n');
    fprintf('  Lab 3: cd Lab3_LTI_Systems; lab3_main\n');
    fprintf('  Lab 4: cd Lab4_Fourier_Analysis; lab4_main\n\n');

    fprintf('Quick test:\n');
    fprintf('  >> [x,n] = impseq(0, -5, 5); stem(n,x)\n\n');
else
    fprintf('  ✗ Setup Incomplete - See errors above\n');
    fprintf('========================================\n\n');
end

%% --- Display Current Directory ---
fprintf('Current directory: %s\n\n', pwd);

%% --- Optional: Display System Info ---
if nargout == 0  % Only if not assigning output
    fprintf('MATLAB version: %s\n', version);
    fprintf('Platform: %s\n\n', computer);
end

%% ============================================================================
%% TIPS FOR USING THIS SETUP
%% ============================================================================
%
% AUTOMATIC SETUP (Permanent):
%   1. Create/edit startup.m in your MATLAB folder
%   2. Add this line:
%      run('path/to/Signal_Studies_RA1_Exam_Prep/setup.m')
%   3. MATLAB will run this automatically on startup
%
% MANUAL SETUP (Each Session):
%   Just run: setup
%
% VERIFY PATH IS SET:
%   >> which impseq
%   Should show: .../Utilities/impseq.m
%
% REMOVE PATH (if needed):
%   >> rmpath('path/to/Utilities')
%
%% ============================================================================
