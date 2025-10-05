# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a signals and systems study repository for preparing for RA1 (first assessment) tests. It contains MATLAB/Octave code for digital signal processing labs and theory materials in Portuguese.

## Directory Structure

- `Lab_test/Lab_Sinais_Codes/Labs/` - MATLAB laboratory scripts and utility functions
- `Theory_test/` - Theory materials (PDFs: Lista1.pdf, Topics_To_Study.pdf)

## MATLAB Environment

This codebase is designed for MATLAB or GNU Octave. All code files use `.m` extension.

### Running Lab Scripts

Lab scripts are standalone and can be executed directly in MATLAB/Octave:
```matlab
cd Lab_test/Lab_Sinais_Codes/Labs/
lab2_sinais_final    % Run Lab 2
lab3_sinais_final    % Run Lab 3
lab4_sinais_script   % Run Lab 4
```

Lab scripts will generate multiple figure windows with plots. Each script is self-contained with initialization (`clc; clear; close all;`).

## Code Architecture

### Core Signal Processing Utilities

The repository uses custom utility functions (not built-in MATLAB functions) for discrete signal operations:

- **`impseq(n0, n1, n2)`** - Generates unit impulse δ[n-n0] for n1 ≤ n ≤ n2
- **`stepseq(n0, n1, n2)`** - Generates unit step u[n-n0] for n1 ≤ n ≤ n2
- **`sigadd(x1, n1, x2, n2)`** - Adds two signals with potentially different time supports
- **`sigmult(x1, n1, x2, n2)`** - Multiplies two signals with different time supports
- **`sigshift(x, n, k)`** - Time-shifts signal x[n] by k samples
- **`sigfold(x, n)`** - Time-reverses signal to produce x[-n]
- **`evenodd(x, n)`** - Decomposes signal into even and odd components
- **`conv_m(x, nx, h, nh)`** - Modified convolution that preserves arbitrary time indices

### Signal Representation Convention

Signals are represented as two arrays:
- `x` - amplitude values
- `n` - corresponding time indices (can start at negative, zero, or positive values)

Example:
```matlab
x = [3, 11, 7, 0, -1, 4, 2];
n = -3:3;  % n=0 is at the 4th element of x
```

### Laboratory Topics by Script

**Lab 2** (`lab2_sinais_final.m`): Basic discrete signal operations
- Impulse and step sequence generation
- Signal addition, multiplication
- Time shifting and folding
- Combined operations on discrete sequences

**Lab 3** (`lab3_sinais_final.m`): Discrete systems and filtering
- Even/odd decomposition
- Convolution of discrete signals (standard and with arbitrary indices)
- System response (impulse and step)
- Moving average filter implementation
- Real-time difference equation implementation

**Lab 4** (`lab4_sinais_script.m`): Fourier series synthesis and spectral analysis
- Periodic waveform synthesis (square, triangular, sawtooth)
- Effect of number of harmonics on approximation quality
- Frequency spectrum visualization using FFT
- Composite signal analysis

### Filter Utility Functions

The Labs directory contains numerous filter design utilities (uppercase `.M` files):
- Analog filter prototypes: `U_BUTTAP.M`, `U_ELIPAP.M`, `U_CHB1AP.M`, `U_CHB2AP.M`
- Analog filter design: `AFD_BUTT.M`, `AFD_ELIP.M`, `AFD_CHB1.M`, `AFD_CHB2.M`
- Filter structure conversions: `DIR2CAS.M`, `CAS2DIR.M`, `DIR2PAR.M`, `PAR2DIR.M`
- Lattice/ladder filters: `DIR2LATC.M`, `LATC2DIR.M`, `LADR2DIR.M`
- DFT utilities: `DFT.M`, `IDFT.M`, `DFS.M`, `IDFS.M`
- Window functions: `BLACKMAN.M`
- Quantization: `QUANTIZE.M`, `TWOSCOMPLEMENT.m`, `ONESCOMPLEMENT.m`

## Key Implementation Notes

1. **Time Index Handling**: The custom signal functions (`sigadd`, `sigmult`, `conv_m`) handle signals with arbitrary starting indices, unlike MATLAB's built-in functions which assume zero-based indexing.

2. **Fourier Series Synthesis**: Lab 4 implements Fourier series from mathematical formulas:
   - Square wave: x(t) = (4/π) Σ[sin(2πkFt)/k] for odd k
   - Triangle wave: x(t) = (8/π²) Σ[(-1)^((k-1)/2) sin(2πkFt)/k²] for odd k
   - Sawtooth wave: x(t) = (2/π) Σ[sin(2πkFt)/k]

3. **FFT Spectral Analysis**: Uses standard FFT approach with normalization and conversion to single-sided spectrum (see `plot_spectrum` function in lab4_sinais_script.m:21-37).

4. **Interactive Input**: Lab 3 exercise 4c includes interactive console input using `input()` for real-time difference equation implementation.

## Working with This Repository

- All lab scripts are in Portuguese with comments and variable names in Portuguese
- Scripts follow academic laboratory format with clear section headers using `%%`
- Each major exercise uses separate figure windows for visualization
- Utility functions are documented with header comments describing inputs/outputs

---

## Study Progress and Available Resources

### Theory Study Materials

**Completed Work:**
- ✅ **`Theory_test/Lista1_Solutions.md`** - Comprehensive solutions to all 20 exercises from Lista1.pdf
  - Contains extremely detailed, step-by-step solutions with verbose explanations
  - Each problem includes:
    - Theory background explaining the underlying concepts
    - Step-by-step calculations with every intermediate step shown
    - Physical interpretation of results
    - References to formulas from the formula sheet
    - Verification of answers where applicable

**Topics Covered in Solutions:**
1. **Sampling & Aliasing (Problems 1-7)** - Nyquist theorem, frequency normalization (F/Fs), A/D→D/A conversion, aliasing detection and calculation
2. **Periodicity (Problems 8-10)** - Determining if discrete sequences are periodic, understanding f = k/N notation
3. **Signal Operations (Problem 11)** - Impulse δ[n] and step u[n] functions, windowing, signal manipulation
4. **Convolution & LTI Systems (Problems 12-13)** - Convolution calculations, h[n] ↔ difference equations, block diagrams, frequency response H(e^jω)
5. **System Properties (Problems 14-17)** - Recursive difference equations, time-invariance testing, linearity testing
6. **Recursive Filters & DFT (Problems 18-20)** - Moving average filters, IIR systems, DFT computation and spectrum plotting

### How to Use the Solutions Document

**When the user asks questions about theory:**
1. Reference the specific section in `Theory_test/Lista1_Solutions.md`
2. Provide detailed explanations using the same pedagogical approach
3. Walk through calculations step-by-step
4. Explain both WHAT is being done and WHY
5. Connect theory to physical/practical interpretation
6. Use examples from the solved problems to illustrate concepts

**The user is a beginner in signal processing** - be extremely verbose and literal:
- Never skip steps in calculations
- Explain every operation (e.g., "We multiply both sides by X because...")
- Define all variables and notation
- Reference which theory/formula is being applied
- Provide intuition for abstract concepts

### Next Steps

**User's next objective:** Work on lab exercises in `Lab_test/Lab_Sinais_Codes/Labs/`

**When working on labs:**
- Help understand the MATLAB code and what it's computing
- Explain the signal processing concepts being implemented
- Connect lab implementations to theory from Lista1_Solutions.md
- Assist with debugging or modifying lab scripts
- Explain results and plots generated by the scripts

### Key Study Resources in Repository

1. **`Theory_test/Topics_To_Study.pdf`** - Official study guide listing all exam topics
2. **`Theory_test/Lista1.pdf`** - Exercise list (20 problems) with formula sheet on page 5
3. **`Theory_test/Lista1_Solutions.md`** - Complete solutions with detailed explanations (YOUR WORK)
4. **`Lab_test/Lab_Sinais_Codes/Labs/`** - MATLAB lab scripts for practical work
   - `lab2_sinais_final.m` - Basic discrete signal operations
   - `lab3_sinais_final.m` - Discrete systems and filtering
   - `lab4_sinais_script.m` - Fourier series and spectral analysis
   - Plus ~80 utility functions for signal processing

### Teaching Approach

When helping the user:
- Be patient and thorough - they are learning from scratch
- Use the same detailed, step-by-step style as in Lista1_Solutions.md
- Always explain the "why" behind mathematical operations
- Connect abstract math to physical meaning
- Encourage questions and provide multiple explanations if needed
- Reference both the Portuguese materials and your explanations
- Use examples and analogies to build intuition
