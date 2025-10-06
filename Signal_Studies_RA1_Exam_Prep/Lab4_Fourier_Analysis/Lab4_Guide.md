# Lab 4: Fourier Analysis - Study Guide

## 🎯 Learning Objectives
- Synthesize periodic waveforms using Fourier series
- Understand harmonic content and convergence
- Perform spectral analysis with FFT
- Interpret frequency-domain representations

---

## 📋 Fourier Series Formulas (MEMORIZE!)

### **1. Square Wave (Onda Quadrada)**
```
x(t) = (4/π) · Σ[sin(2πkFt)/k]  for k = 1,3,5,7,... (ODD only)
              k
```

**Characteristics:**
- Only ODD harmonics: k = 1,3,5,7,...
- Amplitude: 1/k (slow decay)
- Symmetry: x(t) = -x(t+T/2)

**MATLAB Implementation:**
```matlab
y = zeros(size(t));
for k = 1:2:(2*N-1)  % k = 1,3,5,...
    y = y + (4/pi) * (1/k) * sin(2*pi*k*F*t);
end
```

---

### **2. Triangle Wave (Onda Triangular)**
```
x(t) = (8/π²) · Σ[(-1)^((k-1)/2) · sin(2πkFt)/k²]  for k ODD
               k
```

**Characteristics:**
- Only ODD harmonics: k = 1,3,5,7,...
- Amplitude: 1/k² (FAST decay!)
- Sign alternation: +,-,+,-,...
  - k=1: +1, k=3: -1, k=5: +1

**MATLAB Implementation:**
```matlab
y = zeros(size(t));
for k = 1:2:(2*N-1)
    y = y + (8/pi^2) * ((-1)^((k-1)/2)) * sin(2*pi*k*F*t) / (k^2);
end
```

---

### **3. Sawtooth Wave (Dente de Serra)**
```
x(t) = (2/π) · Σ[sin(2πkFt)/k]  for k = 1,2,3,4,... (ALL)
              k
```

**Characteristics:**
- ALL harmonics: k = 1,2,3,4,...
- Amplitude: 1/k
- Asymmetric waveform

**MATLAB Implementation:**
```matlab
y = zeros(size(t));
for k = 1:N
    y = y + (2/pi) * sin(2*pi*k*F*t) / k;
end
```

---

## 🔧 Exercise Breakdown

### **(a) Synthesis with N=50 Harmonics**

Synthesize all three waveforms with 50 terms:
- Square wave: 25 harmonics (k=1,3,...,99)
- Triangle wave: 25 harmonics (k=1,3,...,99)
- Sawtooth: 50 harmonics (k=1,2,...,50)

**Observation:** More harmonics = better approximation

---

### **(b) Convergence Analysis**

Compare N = {1, 3, 5, 15, 50}:

**Square Wave:**
- N=1: Just fundamental (poor)
- N=5: Starting to form edges
- N=50: Nearly perfect (but Gibbs overshoot!)

**Triangle Wave:**
- N=1: Already decent (1/k² converges fast!)
- N=5: Almost perfect
- N=50: Indistinguishable from ideal

**Sawtooth:**
- N=1: Rough approximation
- N=15: Good shape
- N=50: Smooth

**Key Insight:** 1/k² converges MUCH faster than 1/k

---

### **(c) Spectral Analysis with FFT**

#### **FFT Process:**
```matlab
L = length(signal);
Y = fft(signal);             % Complex spectrum
P2 = abs(Y/L);               % Bilateral magnitude (normalized)
P1 = P2(1:floor(L/2)+1);     % Positive frequencies only
P1(2:end-1) = 2*P1(2:end-1); % Double (energy in ±f)
f = Fs*(0:floor(L/2))/L;     % Frequency axis
stem(f, P1);                 % Plot spectrum
```

#### **Expected Spectra:**

**Square Wave:**
- Peaks at: F, 3F, 5F, 7F, ... (20, 60, 100, 140 Hz)
- Heights: 4/π·(1/k) → 1.27, 0.42, 0.25, ...
- NO peaks at even multiples

**Triangle Wave:**
- Peaks at: F, 3F, 5F, 7F, ...
- Heights: 8/π²·(1/k²) → 0.81, 0.09, 0.03, ...
- Decays very fast!

**Sawtooth:**
- Peaks at: F, 2F, 3F, 4F, ... (ALL)
- Heights: 2/π·(1/k) → 0.64, 0.32, 0.21, ...

---

### **(d) Multi-Tone Signal**

**Given:**
```
x(t) = cos(2π·1000t) + 0.5·cos(2π·3000t) +
       0.25·cos(2π·4000t) + cos(2π·5000t)
```

**FFT Result:**
- 4 discrete peaks
- Locations: 1000, 3000, 4000, 5000 Hz
- Heights: 1, 0.5, 0.25, 1

**Interpretation:** FFT perfectly decomposes signal into components!

---

## 🔑 Key Concepts

### **Fourier Series vs FFT**

**Fourier Series (Synthesis):**
- Input: Formula + coefficients
- Output: Time-domain signal
- Manual: Loop adding harmonics

**FFT (Analysis):**
- Input: Time-domain signal
- Output: Frequency spectrum
- Automatic: `fft()` function

---

### **Harmonic Content**

| Waveform | Harmonics | Decay Rate | Convergence |
|----------|-----------|------------|-------------|
| Square | Odd only | 1/k | Slow (Gibbs) |
| Triangle | Odd only | 1/k² | Very fast |
| Sawtooth | All | 1/k | Medium |

---

### **Gibbs Phenomenon**
- ~9% overshoot at discontinuities
- Occurs in square wave
- Does NOT disappear with more terms
- Concentrates in narrower region

---

### **FFT Normalization**

```
Y = fft(x);           % Raw FFT (complex)
P = abs(Y/L);         % Magnitude, normalized by length

Bilateral → Unilateral:
  P_uni = P(1:L/2+1);
  P_uni(2:end-1) *= 2;  % Double (except DC and Nyquist)
```

**Why divide by L?**
- FFT sums over L points
- Division normalizes to per-sample amplitude

**Why multiply by 2?**
- Bilateral: Energy split between ±f
- Unilateral: Combine both sides (except f=0 and f=Fs/2)

---

## ⚠️ Common Mistakes

1. **Wrong harmonic indices**
   ```
   ❌ Square: for k=1:N
   ✅ Square: for k=1:2:(2*N-1)  % Odd only!
   ```

2. **Forgetting alternating signs (triangle)**
   ```
   ❌ Just 1/k²
   ✅ (-1)^((k-1)/2) / k²
   ```

3. **FFT without normalization**
   ```
   ❌ P = abs(fft(x))
   ✅ P = abs(fft(x)/length(x))
   ```

4. **Unilateral conversion errors**
   - Must multiply by 2 (except DC and Nyquist!)

---

## 💡 Exam Tips

### **Memorization Card:**
```
SQUARE:   (4/π)·Σ[sin(2πkFt)/k],        k=ODD
TRIANGLE: (8/π²)·Σ[(-1)^... sin(...)/k²], k=ODD
SAWTOOTH: (2/π)·Σ[sin(2πkFt)/k],        k=ALL
```

### **Synthesis Checklist:**
1. Set up time vector: `t = 0:Ts:num_periods*T`
2. Initialize: `y = zeros(size(t))`
3. Loop correct harmonics (odd vs all)
4. Add term: `y = y + formula`
5. Plot: `plot(t, y)`

### **FFT Checklist:**
1. Get length: `L = length(x)`
2. Compute FFT: `Y = fft(x)`
3. Normalize: `P2 = abs(Y/L)`
4. Get positive half: `P1 = P2(1:floor(L/2)+1)`
5. Double (not DC/Nyquist): `P1(2:end-1) = 2*P1(2:end-1)`
6. Frequency axis: `f = Fs*(0:floor(L/2))/L`
7. Plot: `stem(f, P1)`

### **Quick Identification:**
- See only odd harmonics? → Square or Triangle
- Fast decay (tiny 3rd harmonic)? → Triangle
- All harmonics present? → Sawtooth

---

## 📊 Comparison Table

| Property | Square | Triangle | Sawtooth |
|----------|--------|----------|----------|
| Formula prefix | 4/π | 8/π² | 2/π |
| Harmonics | Odd | Odd | All |
| Decay | 1/k | 1/k² | 1/k |
| Sign pattern | All + | Alternating | All + |
| Convergence | Slow | Fast | Medium |
| Gibbs effect | YES | NO | YES |
| 1st harmonic amp | 1.27 | 0.81 | 0.64 |
| 3rd harmonic amp | 0.42 | -0.09 | 0.21 |

---

## 🔗 Related Topics
- Lab 1: Frequency and periodicity
- Lab 2: Signal addition (used in synthesis)
- Lab 3: H(e^jω) connects to spectrum
- Exam: May ask to synthesize then analyze!
