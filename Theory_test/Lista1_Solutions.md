# Lista de Exercícios 1 - Soluções Detalhadas
## Processamento Digital de Sinais - Prof. Marcelo E. Pellenz

This document contains comprehensive solutions to all 20 exercises with detailed explanations of the theory and step-by-step calculations.

---

## PART 1: SAMPLING, ALIASING, AND FREQUENCY NORMALIZATION (Problems 1-7)

### **Fundamental Theory: Sampling and the Nyquist Theorem**

When we convert an analog signal x(t) to a discrete signal x[n], we sample it at regular intervals determined by the sampling frequency Fs (in Hz) or sampling period Ts = 1/Fs (in seconds).

**Key Concepts:**
1. **Sampling relationship**: x[n] = x(nTs) = x(n/Fs)
2. **Nyquist Theorem**: To avoid aliasing, we need Fs ≥ 2·Fmax (where Fmax is the highest frequency in the signal)
3. **Frequency Normalization**: f = F/Fs converts analog frequency F (Hz) to normalized frequency f (dimensionless)
4. **Digital frequency**: ω = 2πf = 2πF/Fs (radians per sample)

**What is Aliasing?**
When Fs < 2·Fmax, higher frequencies appear as false lower frequencies in the discrete signal. The reconstructed signal will have a different frequency than the original.

**Aliasing Formula:**
When aliasing occurs, the apparent (alias) frequency is:
- F_alias = |F - k·Fs| where k is chosen such that F_alias < Fs/2

---

### **PROBLEM 1**

**Problem Statement:** Consider the following analog signals x(t). If these signals are digitized by an A/D converter using sampling frequency Fs = 400 Hz, write the equations of the respective discrete-time signals x[n]. Identify if any signal will have aliasing problems and what false frequency would be reconstructed.

a) x₁(t) = cos(2π·100t)
b) x₂(t) = cos(2π·200t)
c) x₃(t) = cos(2π·300t)

---

#### **Solution 1a: x₁(t) = cos(2π·100t)**

**Step 1: Identify the analog frequency**
Comparing with the standard form x(t) = cos(2πFt), we see:
- F₁ = 100 Hz

**Step 2: Check Nyquist criterion**
- Nyquist frequency = Fs/2 = 400/2 = 200 Hz
- Since F₁ = 100 Hz < 200 Hz, **NO ALIASING** occurs

**Step 3: Apply frequency normalization**
The normalized frequency is:
- f₁ = F₁/Fs = 100/400 = 0.25

**Step 4: Write the discrete-time signal**
Using the formula x[n] = x(nTs) = x(n/Fs):
- x₁[n] = cos(2π·100·n/400)
- x₁[n] = cos(2π·n/4)
- **x₁[n] = cos(0.5πn)**

Or equivalently using normalized frequency:
- **x₁[n] = cos(2πf₁n) = cos(0.5πn)**

**Conclusion:** No aliasing. The signal is sampled correctly.

---

#### **Solution 1b: x₂(t) = cos(2π·200t)**

**Step 1: Identify the analog frequency**
- F₂ = 200 Hz

**Step 2: Check Nyquist criterion**
- Nyquist frequency = Fs/2 = 200 Hz
- Since F₂ = 200 Hz = Fs/2, we are **exactly at the Nyquist limit**

**Important:** This is a critical case. Theoretically, Fs must be strictly greater than 2F (Fs > 2F), so this is borderline. In practice, sampling exactly at the Nyquist frequency can cause issues depending on the phase of sampling, but mathematically we can proceed.

**Step 3: Apply frequency normalization**
- f₂ = F₂/Fs = 200/400 = 0.5

**Step 4: Write the discrete-time signal**
- x₂[n] = cos(2π·200·n/400)
- x₂[n] = cos(πn)
- **x₂[n] = cos(πn)**

**Step 5: Interpret this signal**
cos(πn) alternates: cos(0) = 1, cos(π) = -1, cos(2π) = 1, cos(3π) = -1, ...
So x₂[n] = {1, -1, 1, -1, 1, -1, ...} - this is the highest frequency possible in discrete time.

**Conclusion:** No aliasing technically, but we're at the critical Nyquist frequency. The discrete signal represents the maximum frequency.

---

#### **Solution 1c: x₃(t) = cos(2π·300t)**

**Step 1: Identify the analog frequency**
- F₃ = 300 Hz

**Step 2: Check Nyquist criterion**
- Nyquist frequency = Fs/2 = 200 Hz
- Since F₃ = 300 Hz > 200 Hz, **ALIASING OCCURS!**

**Step 3: Calculate the alias frequency**
When F > Fs/2, the signal will be aliased. The aliased frequency is:
- F_alias = Fs - F (for Fs/2 < F < Fs)
- F_alias = 400 - 300 = 100 Hz

**Why does this work?** In the discrete domain, frequencies are periodic with period Fs. A frequency of 300 Hz is indistinguishable from (400 - 300) = 100 Hz after sampling.

**Step 4: Write the discrete-time signal**
Even though the original frequency is 300 Hz, the discrete signal will look like:
- f₃ = F_alias/Fs = 100/400 = 0.25
- x₃[n] = cos(2π·300·n/400)
- x₃[n] = cos(1.5πn)

But this is **equivalent to**:
- x₃[n] = cos(1.5πn) = cos(2πn - 0.5πn) = cos(-0.5πn) = cos(0.5πn)

(using the fact that cosine is even: cos(-θ) = cos(θ))

**Step 5: Identify the reconstructed (false) frequency**
If we reconstruct this signal with a D/A converter at Fs = 400 Hz:
- **Reconstructed frequency: 100 Hz** (NOT the original 300 Hz!)

**Conclusion:** YES, aliasing occurs! The 300 Hz signal appears as a false 100 Hz signal after sampling.

---

### **PROBLEM 2**

**Problem Statement:** Consider the analog signal x(t) = 3·cos(100πt):

a) Determine the minimum sampling rate necessary to avoid aliasing (Nyquist Rate).
b) Consider that the signal is sampled at rate Fs = 200 Hz. What is the discrete signal x[n] obtained after sampling?
c) If the signal is sampled with Fs = 75 Hz, what is the discrete signal x[n] obtained after sampling?
d) If the signal x[n] from item (c) is converted back to analog in the D/A, what is the reconstructed signal x̃(t)?

---

#### **Solution 2a: Minimum sampling rate**

**Step 1: Identify the analog frequency**
Given: x(t) = 3·cos(100πt)
Comparing with standard form A·cos(2πFt):
- 100π = 2πF
- F = 100π/(2π) = 50 Hz

**Step 2: Apply Nyquist Theorem**
The Nyquist theorem states: **Fs ≥ 2·Fmax**

For our signal with F = 50 Hz:
- **Fs_min = 2·F = 2·50 = 100 Hz**

**Answer:** The minimum sampling rate (Nyquist rate) is **100 Hz**.

---

#### **Solution 2b: Sampling at Fs = 200 Hz**

**Step 1: Check for aliasing**
- F = 50 Hz
- Fs = 200 Hz
- Nyquist frequency = Fs/2 = 100 Hz
- Since F = 50 Hz < 100 Hz, **NO ALIASING**

**Step 2: Substitute t = n/Fs in the analog signal**
- x(t) = 3·cos(100πt)
- x[n] = 3·cos(100π·n/Fs)
- x[n] = 3·cos(100π·n/200)
- x[n] = 3·cos(πn/2)
- **x[n] = 3·cos(0.5πn)**

**Verification using normalized frequency:**
- f = F/Fs = 50/200 = 0.25
- ω = 2πf = 2π·0.25 = 0.5π ✓

**Answer:** **x[n] = 3·cos(0.5πn)** or **x[n] = 3·cos(πn/2)**

---

#### **Solution 2c: Sampling at Fs = 75 Hz**

**Step 1: Check for aliasing**
- F = 50 Hz
- Fs = 75 Hz
- Nyquist frequency = Fs/2 = 37.5 Hz
- Since F = 50 Hz > 37.5 Hz, **ALIASING OCCURS!**

**Step 2: Calculate the alias frequency**
For Fs/2 < F < Fs:
- F_alias = Fs - F = 75 - 50 = 25 Hz

**Step 3: Write the discrete signal**
Method 1 - Direct substitution:
- x[n] = 3·cos(100π·n/75)
- x[n] = 3·cos(4πn/3)

Method 2 - Using alias frequency:
- f_alias = F_alias/Fs = 25/75 = 1/3
- ω = 2πf = 2π/3
- x[n] = 3·cos(2πn/3)

**Step 4: Verify these are equivalent**
- 4πn/3 = 2πn - 2πn/3 = -2πn/3 (mod 2π)
- Since cos is even: cos(4πn/3) = cos(-2πn/3) = cos(2πn/3) ✓

**Answer:** **x[n] = 3·cos(4πn/3)** or equivalently **x[n] = 3·cos(2πn/3)**

---

#### **Solution 2d: Reconstructing x̃(t) from x[n] in part (c)**

**Theory: D/A Reconstruction**
When a D/A converter reconstructs a signal from x[n], it assumes the signal was properly sampled (no aliasing). It will reconstruct a signal with frequency F_reconstructed where:
- f = F_reconstructed/Fs
- F_reconstructed = f·Fs

**Step 1: Find the normalized frequency in the discrete signal**
From part (c): x[n] = 3·cos(2πn/3)
Comparing with x[n] = A·cos(2πfn):
- 2πf = 2π/3
- f = 1/3

**Step 2: Calculate reconstructed analog frequency**
- F_reconstructed = f·Fs = (1/3)·75 = 25 Hz

**Step 3: Write the reconstructed analog signal**
- x̃(t) = 3·cos(2π·25·t)
- **x̃(t) = 3·cos(50πt)**

**Important observation:** The original signal was x(t) = 3·cos(100πt) with F = 50 Hz, but due to aliasing during sampling at Fs = 75 Hz, the reconstructed signal is x̃(t) = 3·cos(50πt) with F = 25 Hz.

**The amplitude is preserved, but the frequency is wrong!** This demonstrates the danger of aliasing.

**Answer:** **x̃(t) = 3·cos(50πt)** (frequency = 25 Hz, NOT the original 50 Hz)

---

### **PROBLEM 3**

**Problem Statement:** Consider the digitization and reconstruction of the following analog signals x(t). If these signals are digitized by an A/D using sampling frequency Fs = 40 Hz, and immediately reconstructed by the D/A, what are the frequencies in Hertz of the reconstructed signals?

a) x₁(t) = cos(2π·10t)
b) x₂(t) = cos(2π·50t)
c) x₃(t) = cos(2π·90t)
d) x₄(t) = cos(2π·130t)

---

**Theory for this problem:**
After sampling and reconstruction, if aliasing occurs, the reconstructed frequency will be different from the original. We need to find what frequency the D/A will produce.

The key is: frequencies in discrete time are periodic with period Fs. So we need to find the equivalent frequency in the range [0, Fs/2] (or sometimes we use [-Fs/2, Fs/2]).

**Aliasing formula for reconstruction:**
If F is the original frequency and Fs is the sampling rate:
1. If F ≤ Fs/2: No aliasing, F_reconstructed = F
2. If Fs/2 < F < Fs: F_reconstructed = Fs - F
3. If F ≥ Fs: Reduce F modulo Fs, then apply rules 1-2

---

#### **Solution 3a: x₁(t) = cos(2π·10t)**

- F = 10 Hz
- Fs = 40 Hz
- Nyquist frequency = 20 Hz
- Since 10 Hz < 20 Hz: **No aliasing**
- **F_reconstructed = 10 Hz**

---

#### **Solution 3b: x₂(t) = cos(2π·50t)**

- F = 50 Hz
- Fs = 40 Hz
- Nyquist frequency = 20 Hz
- Since 50 Hz > 40 Hz, we first reduce modulo Fs:
  - 50 mod 40 = 10 Hz (this means 50 Hz is equivalent to 10 Hz in discrete time)
- Since 10 Hz < 20 Hz: **No aliasing after reduction**
- **F_reconstructed = 10 Hz**

**Detailed explanation:**
50 Hz = 1·Fs + 10 Hz = 1·40 + 10
In discrete time, frequencies separated by multiples of Fs are indistinguishable.

---

#### **Solution 3c: x₃(t) = cos(2π·90t)**

- F = 90 Hz
- Fs = 40 Hz
- Nyquist frequency = 20 Hz
- Reduce modulo Fs: 90 = 2·40 + 10, so F_equiv = 10 Hz
- Since 10 Hz < 20 Hz: **No aliasing after reduction**
- **F_reconstructed = 10 Hz**

---

#### **Solution 3d: x₄(t) = cos(2π·130t)**

- F = 130 Hz
- Fs = 40 Hz
- Nyquist frequency = 20 Hz
- Reduce modulo Fs: 130 = 3·40 + 10, so F_equiv = 10 Hz
- Since 10 Hz < 20 Hz: **No aliasing after reduction**
- **F_reconstructed = 10 Hz**

---

**Summary for Problem 3:**
All four signals, despite having different original frequencies, will be reconstructed as **10 Hz** after sampling at Fs = 40 Hz! This demonstrates how different high frequencies can alias to the same low frequency.

---

### **PROBLEM 4**

**Problem Statement:** Consider the analog signal xa(t) = 3·cos(50πt) + 10·sin(300πt) - cos(100πt). Determine what should be the minimum sampling rate so that the signal can be digitized in the A/D and reconstructed in the D/A without losing components or generating aliasing. Demonstrate by performing the conversion xa(t) → x[n] → x̃a(t).

---

#### **Solution:**

**Step 1: Identify all frequency components**

The signal has three components:
- Component 1: 3·cos(50πt) → comparing with cos(2πFt): 50π = 2πF₁ → F₁ = 25 Hz
- Component 2: 10·sin(300πt) → comparing with sin(2πFt): 300π = 2πF₂ → F₂ = 150 Hz
- Component 3: -cos(100πt) → 100π = 2πF₃ → F₃ = 50 Hz

**Step 2: Find the maximum frequency**
- Fmax = max(25, 150, 50) = 150 Hz

**Step 3: Apply Nyquist Theorem**
- **Fs_min = 2·Fmax = 2·150 = 300 Hz**

**Step 4: Demonstrate the conversion using Fs = 300 Hz**

**xa(t) → x[n] (A/D conversion):**
Substitute t = n/Fs = n/300:

- Component 1: 3·cos(50π·n/300) = 3·cos(πn/6)
- Component 2: 10·sin(300π·n/300) = 10·sin(πn)
- Component 3: -cos(100π·n/300) = -cos(πn/3)

**x[n] = 3·cos(πn/6) + 10·sin(πn) - cos(πn/3)**

**Step 5: Verify normalized frequencies**
- f₁ = F₁/Fs = 25/300 = 1/12 → ω₁ = 2π/12 = π/6 ✓
- f₂ = F₂/Fs = 150/300 = 1/2 → ω₂ = π ✓
- f₃ = F₃/Fs = 50/300 = 1/6 → ω₃ = 2π/6 = π/3 ✓

All frequencies are ≤ Fs/2, so no aliasing!

**Step 6: x[n] → x̃a(t) (D/A conversion)**

To reconstruct, we denormalize: t = n/Fs, or equivalently, replace n with Fs·t = 300t:

- Component 1: 3·cos(π·300t/6) = 3·cos(50πt)
- Component 2: 10·sin(π·300t) = 10·sin(300πt)
- Component 3: -cos(π·300t/3) = -cos(100πt)

**x̃a(t) = 3·cos(50πt) + 10·sin(300πt) - cos(100πt)**

**Conclusion:** With Fs = 300 Hz, we get **x̃a(t) = xa(t)** - perfect reconstruction! ✓

**Answer:** **Minimum sampling rate = 300 Hz**

---

### **PROBLEM 5**

**Problem Statement:** Consider the analog signal xa(t) = 3·cos(2000πt) + 5·sin(6000πt) + 10·cos(12000πt):

a) Determine the minimum sampling frequency, Fs.
b) If the sampling frequency is Fs = 5 kHz, determine the expression of the sequence x[n].
c) Determine the reconstructed sequence x̃a(t) from the sequence x[n] in part (b), assuming sampling frequency Fs = 5 kHz.

---

#### **Solution 5a: Minimum sampling frequency**

**Step 1: Extract all frequencies**
- Component 1: 3·cos(2000πt) → 2000π = 2πF₁ → F₁ = 1000 Hz
- Component 2: 5·sin(6000πt) → 6000π = 2πF₂ → F₂ = 3000 Hz
- Component 3: 10·cos(12000πt) → 12000π = 2πF₃ → F₃ = 6000 Hz

**Step 2: Find maximum frequency**
- Fmax = 6000 Hz

**Step 3: Apply Nyquist Theorem**
- **Fs_min = 2·Fmax = 12000 Hz = 12 kHz**

**Answer:** **Fs_min = 12 kHz**

---

#### **Solution 5b: x[n] with Fs = 5 kHz**

**Important:** Fs = 5 kHz < 12 kHz (the minimum required), so **aliasing will occur!**

**Step 1: Check each component for aliasing**

Nyquist frequency = Fs/2 = 2500 Hz

- F₁ = 1000 Hz < 2500 Hz → No aliasing
- F₂ = 3000 Hz > 2500 Hz → Aliasing!
- F₃ = 6000 Hz > 2500 Hz → Aliasing!

**Step 2: Calculate alias frequencies**

For F₂ = 3000 Hz:
- Since 3000 < Fs = 5000, use: F_alias = Fs - F = 5000 - 3000 = 2000 Hz

For F₃ = 6000 Hz:
- Since 6000 > Fs = 5000, first reduce: 6000 = 1·5000 + 1000 Hz
- So F₃ is equivalent to 1000 Hz (< 2500 Hz, no further aliasing)

**Step 3: Write x[n] by substitution t = n/Fs = n/5000**

- Component 1: 3·cos(2000π·n/5000) = 3·cos(2πn/5)
- Component 2: 5·sin(6000π·n/5000) = 5·sin(6πn/5)
- Component 3: 10·cos(12000π·n/5000) = 10·cos(12πn/5)

**Step 4: Simplify using aliasing**

For component 2: sin(6πn/5)
- 6π/5 = (10π - 4π)/5 = 2π - 4π/5
- sin(2π - 4π/5) = sin(-4π/5) = -sin(4π/5)
- So: 5·sin(6πn/5) = -5·sin(4πn/5)

For component 3: cos(12πn/5)
- 12π/5 = (10π + 2π)/5 = 2π + 2π/5
- cos(2π + 2π/5) = cos(2π/5)
- So: 10·cos(12πn/5) = 10·cos(2πn/5)

**Final expression:**
**x[n] = 3·cos(2πn/5) - 5·sin(4πn/5) + 10·cos(2πn/5)**
**x[n] = 13·cos(2πn/5) - 5·sin(4πn/5)**

(combining the two cosine terms with the same frequency)

---

#### **Solution 5c: Reconstructed signal x̃a(t)**

**Step 1: Identify the normalized frequencies in x[n]**

From x[n] = 13·cos(2πn/5) - 5·sin(4πn/5):
- ω₁ = 2π/5 → f₁ = 1/5 → F₁ = f₁·Fs = (1/5)·5000 = 1000 Hz
- ω₂ = 4π/5 → f₂ = 2/5 → F₂ = f₂·Fs = (2/5)·5000 = 2000 Hz

**Step 2: Reconstruct analog signal**
- **x̃a(t) = 13·cos(2π·1000·t) - 5·sin(2π·2000·t)**
- **x̃a(t) = 13·cos(2000πt) - 5·sin(4000πt)**

**Observation:** This is NOT the original signal!
- Original: xa(t) = 3·cos(2000πt) + 5·sin(6000πt) + 10·cos(12000πt)
- Reconstructed: x̃a(t) = 13·cos(2000πt) - 5·sin(4000πt)

The aliasing caused components to mix and create a completely different signal!

**Answer:** **x̃a(t) = 13·cos(2000πt) - 5·sin(4000πt)**

---

### **PROBLEM 6**

**Problem Statement:** Consider the analog signal xa(t) = 10·cos(200πt) - 5·sin(1000πt) + 20·cos(3000πt). If this signal is digitized by an A/D using sampling frequency Fs = 1000 Hz and then converted back to analog by the D/A, what will be the reconstructed analog signal x̃a(t)?

---

#### **Solution:**

**Step 1: Identify frequency components**
- Component 1: 10·cos(200πt) → F₁ = 100 Hz
- Component 2: -5·sin(1000πt) → F₂ = 500 Hz
- Component 3: 20·cos(3000πt) → F₃ = 1500 Hz

**Step 2: Check for aliasing**
- Fs = 1000 Hz
- Nyquist frequency = 500 Hz
- F₁ = 100 Hz < 500 Hz → No aliasing
- F₂ = 500 Hz = 500 Hz → At Nyquist limit (borderline)
- F₃ = 1500 Hz > 500 Hz → Aliasing!

**Step 3: Calculate alias for F₃**
- 1500 = 1·1000 + 500 Hz
- So F₃ aliases to 500 Hz

**Step 4: Write discrete signal x[n]**
Substitute t = n/1000:
- Component 1: 10·cos(200π·n/1000) = 10·cos(πn/5)
- Component 2: -5·sin(1000π·n/1000) = -5·sin(πn)
- Component 3: 20·cos(3000π·n/1000) = 20·cos(3πn)

**Step 5: Simplify aliased terms**
- cos(3πn) = cos(3πn - 2πn) = cos(πn)
- So component 3 becomes: 20·cos(πn)

**Step 6: Combine terms with same frequency**
x[n] = 10·cos(πn/5) - 5·sin(πn) + 20·cos(πn)

**Step 7: Reconstruct x̃a(t)**
Replace n with Fs·t = 1000t:
- Component 1: 10·cos(π·1000t/5) = 10·cos(200πt)
- Component 2: -5·sin(π·1000t) = -5·sin(1000πt)
- Component 3: 20·cos(π·1000t) = 20·cos(1000πt)

**Final reconstructed signal:**
**x̃a(t) = 10·cos(200πt) - 5·sin(1000πt) + 20·cos(1000πt)**

Note: The 1500 Hz component was aliased to 500 Hz (1000πt in the cosine term).

**Answer:** **x̃a(t) = 10·cos(200πt) - 5·sin(1000πt) + 20·cos(1000πt)**

---

### **PROBLEM 7**

**Problem Statement:** Consider the analog signal xa(t) = 10·cos(200πt) - 5·sin(1200πt) + 20·cos(1800πt). If this signal is digitized by an A/D using sampling frequency Fs = 500 Hz and then converted back to analog by the D/A, what will be the reconstructed analog signal x̃a(t)?

---

#### **Solution:**

**Step 1: Identify frequency components**
- Component 1: 10·cos(200πt) → F₁ = 100 Hz
- Component 2: -5·sin(1200πt) → F₂ = 600 Hz
- Component 3: 20·cos(1800πt) → F₃ = 900 Hz

**Step 2: Check for aliasing**
- Fs = 500 Hz
- Nyquist frequency = 250 Hz
- F₁ = 100 Hz < 250 Hz → No aliasing
- F₂ = 600 Hz > 250 Hz → Aliasing!
- F₃ = 900 Hz > 250 Hz → Aliasing!

**Step 3: Calculate alias frequencies**

For F₂ = 600 Hz:
- 600 = 1·500 + 100 Hz
- So F₂ aliases to 100 Hz

For F₃ = 900 Hz:
- 900 = 1·500 + 400 Hz
- 400 Hz > 250 Hz, so we need: F_alias = 500 - 400 = 100 Hz

**Step 4: Write discrete signal x[n]**
Substitute t = n/500:
- Component 1: 10·cos(200π·n/500) = 10·cos(2πn/5)
- Component 2: -5·sin(1200π·n/500) = -5·sin(12πn/5)
- Component 3: 20·cos(1800π·n/500) = 20·cos(18πn/5)

**Step 5: Simplify aliased terms**

For component 2: sin(12πn/5)
- 12π/5 = (10π + 2π)/5 = 2π + 2π/5
- sin(2π + 2π/5) = sin(2π/5)

For component 3: cos(18πn/5)
- 18π/5 = (20π - 2π)/5 = 4π - 2π/5
- cos(4π - 2π/5) = cos(-2π/5) = cos(2π/5)

**Step 6: Combine all terms**
x[n] = 10·cos(2πn/5) - 5·sin(2πn/5) + 20·cos(2πn/5)
x[n] = 30·cos(2πn/5) - 5·sin(2πn/5)

**Step 7: Reconstruct x̃a(t)**
- f = 1/5 → F = f·Fs = (1/5)·500 = 100 Hz
- **x̃a(t) = 30·cos(2π·100·t) - 5·sin(2π·100·t)**
- **x̃a(t) = 30·cos(200πt) - 5·sin(200πt)**

**Alternative form:** We can combine these using trigonometric identity:
- A·cos(θ) - B·sin(θ) = R·cos(θ + φ) where R = √(A² + B²), tan(φ) = B/A
- R = √(30² + 5²) = √(900 + 25) = √925 = 5√37
- tan(φ) = 5/30 = 1/6, so φ = arctan(1/6)

**Answer:** **x̃a(t) = 30·cos(200πt) - 5·sin(200πt)**

All three components aliased to 100 Hz and combined!

---

## PART 2: PERIODICITY OF DISCRETE SEQUENCES (Problems 8-10)

### **Fundamental Theory: Periodicity in Discrete Time**

A discrete-time sequence x[n] is **periodic** with period N if:
- x[n + N] = x[n] for all n
- N is the smallest positive integer for which this is true

**For sinusoidal sequences:**
- x[n] = A·cos(ωn + φ) or x[n] = A·sin(ωn + φ)
- The sequence is periodic if and only if ω/(2π) is a **rational number**

**If ω/(2π) = k/N** (in lowest terms where k and N are integers with no common factors):
- The sequence IS periodic
- The period is N samples
- k represents the number of complete cycles in N samples

**If ω/(2π) is irrational:**
- The sequence is NOT periodic (it never exactly repeats)

**Normalized frequency interpretation:**
- f = ω/(2π) = F/Fs = k/N
- k = number of cycles in N samples
- N = period in samples
- F = analog frequency (Hz)
- Fs = sampling frequency (Hz)

---

### **PROBLEM 8**

**Problem Statement:** Consider the analog signal x(t) = cos(2π·200t). If this signal is digitized by an A/D using sampling frequency Fs = 500 Hz, determine if the signal x[n] will be periodic and what is its period in samples.

---

#### **Solution:**

**Step 1: Find the analog frequency**
- x(t) = cos(2π·200t)
- F = 200 Hz

**Step 2: Calculate normalized frequency**
- f = F/Fs = 200/500 = 2/5

**Step 3: Write the discrete signal**
- x[n] = cos(2π·200·n/500)
- x[n] = cos(4πn/5)
- ω = 4π/5

**Step 4: Check periodicity condition**
- ω/(2π) = (4π/5)/(2π) = 4/(5·2) = 2/5

Since 2/5 is rational (already in lowest terms with k = 2, N = 5), the sequence IS periodic.

**Step 5: Determine the period**
From f = k/N = 2/5:
- k = 2 (number of complete cycles)
- **N = 5 samples** (period)

**Verification:**
Let's check x[n + 5] = x[n]:
- x[n + 5] = cos(4π(n + 5)/5) = cos(4πn/5 + 4π) = cos(4πn/5) = x[n] ✓

(since cosine has period 2π, adding 4π doesn't change the value)

**Answer:** YES, the signal is periodic with **period N = 5 samples**.

**Interpretation:** In 5 samples, the signal completes exactly 2 full cycles.

---

### **PROBLEM 9**

**Problem Statement:** Consider that the continuous-time analog signal x(t) = 10·cos(2π·3000·t) is digitized using sampling frequency Fs = 50 kHz. Explain if the sampled signal x[n] is or is not a periodic discrete-time sequence (justify) and interpret the values of k and N of the normalized frequency of this signal (f = k/N).

---

#### **Solution:**

**Step 1: Identify parameters**
- Analog frequency: F = 3000 Hz
- Sampling frequency: Fs = 50000 Hz = 50 kHz

**Step 2: Calculate normalized frequency**
- f = F/Fs = 3000/50000 = 3/50

**Step 3: Write the discrete signal**
- x[n] = 10·cos(2π·3000·n/50000)
- x[n] = 10·cos(6000π·n/50000)
- x[n] = 10·cos(3πn/25)
- ω = 3π/25

**Step 4: Check periodicity**
- ω/(2π) = (3π/25)/(2π) = 3/50

Since f = 3/50 is a rational number, **YES, the sequence IS periodic**.

**Step 5: Identify k and N**
From f = k/N = 3/50 (already in lowest terms):
- **k = 3** (number of complete cycles in the period)
- **N = 50 samples** (period)

**Step 6: Interpretation of k and N**

**N = 50** means:
- The signal repeats every 50 samples
- After 50 samples, the sequence returns to its starting value
- This is the fundamental period

**k = 3** means:
- In those 50 samples, the cosine completes exactly 3 full cycles (3 complete oscillations)
- The signal goes through 3·360° = 1080° of phase in 50 samples

**Physical interpretation:**
- Time for one period: T_period = N/Fs = 50/50000 = 0.001 s = 1 ms
- In 1 ms, the signal completes 3 cycles
- This matches the analog frequency: F = 3 cycles/1 ms = 3000 cycles/s = 3000 Hz ✓

**Answer:**
- **YES, the signal is periodic**
- **Period: N = 50 samples**
- **k = 3** represents the number of complete oscillations within one period
- **N = 50** represents the period in number of samples

---

### **PROBLEM 10**

**Problem Statement:** Determine if the following discrete sequences are periodic and what is the period:

a) x₁[n] = cos(0.01πn)
b) x₂[n] = cos(30πn/105)
c) x₃[n] = cos(3πn)
d) x₄[n] = sin(3n)
e) x₅[n] = sin(62πn/10)

---

#### **Solution 10a: x₁[n] = cos(0.01πn)**

**Step 1: Identify ω**
- ω = 0.01π = π/100

**Step 2: Calculate ω/(2π)**
- ω/(2π) = (π/100)/(2π) = 1/200

**Step 3: Express as k/N in lowest terms**
- 1/200 is already in lowest terms
- k = 1, N = 200

**Answer:** **Periodic with period N = 200 samples**

---

#### **Solution 10b: x₂[n] = cos(30πn/105)**

**Step 1: Simplify the argument**
- 30/105 = 6/21 = 2/7 (reducing to lowest terms)
- So: x₂[n] = cos(2πn/7)

**Step 2: Identify ω**
- ω = 2π/7

**Step 3: Calculate ω/(2π)**
- ω/(2π) = (2π/7)/(2π) = 1/7

**Step 4: Express as k/N**
- k = 1, N = 7

**Answer:** **Periodic with period N = 7 samples**

---

#### **Solution 10c: x₃[n] = cos(3πn)**

**Step 1: Identify ω**
- ω = 3π

**Step 2: Calculate ω/(2π)**
- ω/(2π) = 3π/(2π) = 3/2

**Step 3: Express as k/N in lowest terms**
- 3/2 is already in lowest terms
- k = 3, N = 2

**Step 4: Verify**
- x₃[n + 2] = cos(3π(n + 2)) = cos(3πn + 6π) = cos(3πn) = x₃[n] ✓

**Answer:** **Periodic with period N = 2 samples**

**Note:** This sequence alternates: cos(0) = 1, cos(3π) = -1, cos(6π) = 1, cos(9π) = -1, ...

---

#### **Solution 10d: x₄[n] = sin(3n)**

**Important:** Note that the argument is 3n, NOT 3πn!

**Step 1: Identify ω**
- ω = 3 (radians per sample, not in terms of π)

**Step 2: Calculate ω/(2π)**
- ω/(2π) = 3/(2π)

**Step 3: Check if rational**
- 3/(2π) is **irrational** (because π is irrational)

**Answer:** **NOT periodic**

**Explanation:** Since ω/(2π) is irrational, there is no integer N such that x[n + N] = x[n] for all n. The sequence never exactly repeats.

---

#### **Solution 10e: x₅[n] = sin(62πn/10)**

**Step 1: Simplify the argument**
- 62π/10 = 31π/5

**Step 2: Reduce to fundamental range [0, 2π)**
For periodicity, we only care about the argument modulo 2π:
- 31π/5 = (30π + π)/5 = 6π + π/5
- sin(6π + π/5) = sin(π/5) (since sin has period 2π)

So we can write: x₅[n] = sin(πn/5)

**Step 3: Identify ω**
- ω = π/5 (simplified form)

**Step 4: Calculate ω/(2π)**
- ω/(2π) = (π/5)/(2π) = 1/10

**Step 5: Express as k/N**
- k = 1, N = 10

**Answer:** **Periodic with period N = 10 samples**

**Note:** Even though the original expression had 62π, this is equivalent to π/5 modulo 2π for periodicity purposes.

---

## PART 3: SIGNAL OPERATIONS (Problem 11)

### **Fundamental Theory: Discrete Signal Operations**

**Basic Signals:**
- **Unit impulse:** δ[n] = 1 at n=0, 0 elsewhere
- **Unit step:** u[n] = 1 for n≥0, 0 for n<0

**Operations:**
1. **Time shift:** δ[n - k] shifts the impulse to position k
2. **Scaling:** A·δ[n] has amplitude A at n=0
3. **Windowing:** x[n]·(u[n] - u[n-N]) keeps x[n] only for 0 ≤ n < N
4. **Addition:** Signals add point-by-point

---

### **PROBLEM 11**

**Problem Statement:** Considering the discrete signal x[n] shown in the figure below, draw the following discrete sequence:
y[n] = x[n]·(u[n] - u[n - 4]) + 2δ[n + 2] - 4δ[n - 2]

Where x[n] is shown as:
- x[-2] = 2
- x[-1] = 0
- x[0] = 1
- x[1] = 2
- x[2] = 1
- x[3] = -2

---

#### **Solution:**

**Step 1: Understand each term**

**Term 1: x[n]·(u[n] - u[n - 4])**
- (u[n] - u[n - 4]) is a rectangular window
- u[n] = 1 for n ≥ 0
- u[n - 4] = 1 for n ≥ 4
- (u[n] - u[n - 4]) = 1 for 0 ≤ n < 4, and 0 elsewhere

This term "windows" x[n] to keep only samples from n = 0 to n = 3:
- For n < 0: (u[n] - u[n - 4]) = 0, so this term = 0
- For 0 ≤ n < 4: (u[n] - u[n - 4]) = 1, so this term = x[n]
- For n ≥ 4: (u[n] - u[n - 4]) = 0, so this term = 0

**Term 2: 2δ[n + 2]**
- Impulse of amplitude 2 at n = -2

**Term 3: -4δ[n - 2]**
- Impulse of amplitude -4 at n = 2

**Step 2: Calculate y[n] for each n**

Let's build a table:

| n | x[n] | x[n]·(u[n]-u[n-4]) | 2δ[n+2] | -4δ[n-2] | y[n] |
|---|------|-------------------|---------|----------|------|
| -3 | 0 | 0 | 0 | 0 | 0 |
| -2 | 2 | 0 | 2 | 0 | 2 |
| -1 | 0 | 0 | 0 | 0 | 0 |
| 0 | 1 | 1 | 0 | 0 | 1 |
| 1 | 2 | 2 | 0 | 0 | 2 |
| 2 | 1 | 1 | 0 | -4 | -3 |
| 3 | -2 | -2 | 0 | 0 | -2 |
| 4 | 0 | 0 | 0 | 0 | 0 |

**Step 3: Detailed calculation for key points**

**At n = -2:**
- x[-2]·(u[-2] - u[-6]) = 2·(0 - 0) = 0
- 2δ[-2 + 2] = 2δ[0] = 2
- -4δ[-2 - 2] = -4δ[-4] = 0
- y[-2] = 0 + 2 + 0 = 2 ✓

**At n = 2:**
- x[2]·(u[2] - u[-2]) = 1·(1 - 0) = 1
- 2δ[2 + 2] = 2δ[4] = 0
- -4δ[2 - 2] = -4δ[0] = -4
- y[2] = 1 + 0 - 4 = -3 ✓

**Step 4: Draw the result**

The sequence y[n] is:
```
y[n] = {..., 0, 2, 0, 1, 2, -3, -2, 0, ...}
        at n: ...-3,-2,-1, 0, 1,  2,  3, 4,...
```

**Graphically (stem plot):**
```
  3|
  2|     •           •
  1|                     •
  0|  •     •                   •
 -1|
 -2|                         •
 -3|                     •
 -4|
   |--|--|--|--|--|--|--|--|--
     -3 -2 -1  0  1  2  3  4  n
```

**Answer:** The sequence y[n] has non-zero values:
- y[-2] = 2
- y[0] = 1
- y[1] = 2
- y[2] = -3
- y[3] = -2

---

## PART 4: CONVOLUTION AND LTI SYSTEMS (Problems 12-13)

### **Fundamental Theory: LTI Systems and Convolution**

**Linear Time-Invariant (LTI) Systems:**
- **Linear:** If input ax₁[n] + bx₂[n] produces output ay₁[n] + by₂[n]
- **Time-Invariant:** If x[n] → y[n], then x[n - k] → y[n - k]

**Impulse Response h[n]:**
- The output when input is δ[n]
- Completely characterizes an LTI system
- Any output can be computed from h[n] using convolution

**Convolution:**
- y[n] = x[n] * h[n] = Σ(k=-∞ to ∞) x[k]·h[n - k]
- Also: y[n] = Σ(k=-∞ to ∞) h[k]·x[n - k]

**Difference Equation:**
- General form: Σ(k=0 to N) aₖ·y[n - k] = Σ(m=0 to M) bₘ·x[n - m]
- Relates input x[n] and output y[n]
- Can be derived from h[n] and vice versa

**Frequency Response:**
- H(e^jω) = Σ(n=-∞ to ∞) h[n]·e^(-jωn)
- Describes how the system responds to different frequencies
- If input is x[n] = e^(jωn), output is y[n] = H(e^jω)·e^(jωn)

---

### **PROBLEM 12**

**Problem Statement:** A discrete-time linear time-invariant system is characterized by the impulse response h[n].

From the figure:
- x[n]: values {2, 1, -1} at positions {0, 2, 3}
- h[n]: values {2, -1, 1, 1} at positions {0, 1, 2, 3}

a) Determine the system response y[n] for input signal x[n].
b) Write the difference equation that relates input and output for this system.

---

#### **Solution 12a: Convolution y[n] = x[n] * h[n]**

**Step 1: Write sequences explicitly**
- x[n] = {2, 0, 1, -1} for n = {0, 1, 2, 3}, zero elsewhere
- h[n] = {2, -1, 1, 1} for n = {0, 1, 2, 3}, zero elsewhere

**Step 2: Use convolution formula**
y[n] = Σ(k=-∞ to ∞) x[k]·h[n - k]

**Method: Tabular Convolution**

Let's compute y[n] for each value of n:

**y[0]:**
y[0] = x[0]·h[0] = 2·2 = 4

**y[1]:**
y[1] = x[0]·h[1] + x[1]·h[0] = 2·(-1) + 0·2 = -2

**y[2]:**
y[2] = x[0]·h[2] + x[1]·h[1] + x[2]·h[0] = 2·1 + 0·(-1) + 1·2 = 2 + 0 + 2 = 4

**y[3]:**
y[3] = x[0]·h[3] + x[1]·h[2] + x[2]·h[1] + x[3]·h[0]
     = 2·1 + 0·1 + 1·(-1) + (-1)·2
     = 2 + 0 - 1 - 2 = -1

**y[4]:**
y[4] = x[1]·h[3] + x[2]·h[2] + x[3]·h[1]
     = 0·1 + 1·1 + (-1)·(-1)
     = 0 + 1 + 1 = 2

**y[5]:**
y[5] = x[2]·h[3] + x[3]·h[2]
     = 1·1 + (-1)·1
     = 1 - 1 = 0

**y[6]:**
y[6] = x[3]·h[3] = (-1)·1 = -1

**Answer for part a:**
**y[n] = {4, -2, 4, -1, 2, 0, -1} for n = {0, 1, 2, 3, 4, 5, 6}**

---

#### **Solution 12b: Difference Equation**

**Theory:** If h[n] has finite length and starts at n = 0, we can write:
- h[n] = {h[0], h[1], h[2], ..., h[M]}
- The difference equation (FIR system) is:
  y[n] = Σ(k=0 to M) h[k]·x[n - k]

**Step 1: Identify impulse response values**
- h[0] = 2
- h[1] = -1
- h[2] = 1
- h[3] = 1

**Step 2: Write the difference equation**
y[n] = h[0]·x[n] + h[1]·x[n-1] + h[2]·x[n-2] + h[3]·x[n-3]

**Answer:**
**y[n] = 2·x[n] - x[n-1] + x[n-2] + x[n-3]**

This is a **non-recursive** (FIR) difference equation because y[n] depends only on current and past inputs, not on past outputs.

---

### **PROBLEM 13**

**Problem Statement:** Consider a discrete-time LTI system whose impulse response is given by:
h[n] = {5, -2, 0, 0, 4, -1, 0, 0, 1}
(arrow indicates n = 0 at the first element)

a) Express the impulse response h[n] as a sum of scaled and shifted impulse functions. Present the equation of h[n] in terms of δ[n].
b) Write the system's difference equation that relates x[n] with y[n].
c) Draw the block diagram that represents this system.
d) Calculate the system's frequency response H(e^jω).
e) Determine the output signal of this system y[n], given the input signal x[n] = {1, 0, 2, -1}.

---

#### **Solution 13a: Express h[n] as sum of impulses**

**Theory:** Any discrete signal can be written as:
x[n] = Σ(k=-∞ to ∞) x[k]·δ[n - k]

This expresses the signal as a sum of scaled, shifted impulses.

**Step 1: Identify non-zero values of h[n]**
From h[n] = {5, -2, 0, 0, 4, -1, 0, 0, 1} starting at n = 0:
- h[0] = 5
- h[1] = -2
- h[2] = 0
- h[3] = 0
- h[4] = 4
- h[5] = -1
- h[6] = 0
- h[7] = 0
- h[8] = 1

**Step 2: Write as sum (skipping zero terms)**

**Answer:**
**h[n] = 5δ[n] - 2δ[n-1] + 4δ[n-4] - δ[n-5] + δ[n-8]**

---

#### **Solution 13b: Difference Equation**

Using the same approach as Problem 12b:

**Answer:**
**y[n] = 5x[n] - 2x[n-1] + 4x[n-4] - x[n-5] + x[n-8]**

This is a non-recursive FIR system with coefficients from the impulse response.

---

#### **Solution 13c: Block Diagram**

**Theory:** A block diagram uses three basic elements:
- **Delay:** z⁻¹ (delays signal by 1 sample)
- **Multiplier:** Circle with coefficient (scales signal)
- **Adder:** Circle with + (adds signals)

**For the difference equation:**
y[n] = 5x[n] - 2x[n-1] + 4x[n-4] - x[n-5] + x[n-8]

**Block Diagram:**
```
x[n] ────┬─────────────→ [×5] ───┐
         │                        │
         ├──→ [z⁻¹] ──→ [×-2] ───┤
         │                        │
         ├──→ [z⁻¹] ──→ [z⁻¹] ─  │
         │            ↓           ├──→ [+] ──→ y[n]
         ├──→ [z⁻¹] ──→ [z⁻¹] ─  │
         │            ↓      [×4]─┤
         ├──→ [z⁻¹] ──→ [×-1] ───┤
         │                        │
         └──→ [z⁻¹]──[z⁻¹]──[z⁻¹]│
                     ↓      [×1]──┘
```

**Description:**
1. Input x[n] is split into 5 paths
2. First path: multiply by 5
3. Second path: delay 1 sample, multiply by -2
4. Third path: delay 4 samples, multiply by 4
5. Fourth path: delay 5 samples, multiply by -1
6. Fifth path: delay 8 samples, multiply by 1
7. All paths sum at the output to produce y[n]

---

#### **Solution 13d: Frequency Response H(e^jω)**

**Theory:** The frequency response is the DTFT (Discrete-Time Fourier Transform) of the impulse response:

H(e^jω) = Σ(n=-∞ to ∞) h[n]·e^(-jωn)

**Step 1: Apply the formula with our h[n]**
H(e^jω) = Σ(n=0 to 8) h[n]·e^(-jωn)

H(e^jω) = 5e^(-jω·0) - 2e^(-jω·1) + 0 + 0 + 4e^(-jω·4) - e^(-jω·5) + 0 + 0 + e^(-jω·8)

**Answer:**
**H(e^jω) = 5 - 2e^(-jω) + 4e^(-j4ω) - e^(-j5ω) + e^(-j8ω)**

This can also be written in magnitude-phase form, but the above is the standard representation.

---

#### **Solution 13e: Output y[n] for x[n] = {1, 0, 2, -1}**

**Step 1: Setup for convolution**
- x[n] = {1, 0, 2, -1} for n = {0, 1, 2, 3}
- h[n] = {5, -2, 0, 0, 4, -1, 0, 0, 1} for n = {0, 1, 2, 3, 4, 5, 6, 7, 8}

**Step 2: Use convolution y[n] = x[n] * h[n]**

The output will extend from n = 0 to n = 3 + 8 = 11.

**Computing each value:**

**y[0]** = x[0]·h[0] = 1·5 = **5**

**y[1]** = x[0]·h[1] + x[1]·h[0] = 1·(-2) + 0·5 = **-2**

**y[2]** = x[0]·h[2] + x[1]·h[1] + x[2]·h[0] = 1·0 + 0·(-2) + 2·5 = **10**

**y[3]** = x[0]·h[3] + x[1]·h[2] + x[2]·h[1] + x[3]·h[0]
        = 1·0 + 0·0 + 2·(-2) + (-1)·5
        = 0 + 0 - 4 - 5 = **-9**

**y[4]** = x[0]·h[4] + x[1]·h[3] + x[2]·h[2] + x[3]·h[1]
        = 1·4 + 0·0 + 2·0 + (-1)·(-2)
        = 4 + 0 + 0 + 2 = **6**

**y[5]** = x[0]·h[5] + x[1]·h[4] + x[2]·h[3] + x[3]·h[2]
        = 1·(-1) + 0·4 + 2·0 + (-1)·0
        = -1 + 0 + 0 + 0 = **-1**

**y[6]** = x[0]·h[6] + x[1]·h[5] + x[2]·h[4] + x[3]·h[3]
        = 1·0 + 0·(-1) + 2·4 + (-1)·0
        = 0 + 0 + 8 + 0 = **8**

**y[7]** = x[0]·h[7] + x[1]·h[6] + x[2]·h[5] + x[3]·h[4]
        = 1·0 + 0·0 + 2·(-1) + (-1)·4
        = 0 + 0 - 2 - 4 = **-6**

**y[8]** = x[0]·h[8] + x[1]·h[7] + x[2]·h[6] + x[3]·h[5]
        = 1·1 + 0·0 + 2·0 + (-1)·(-1)
        = 1 + 0 + 0 + 1 = **2**

**y[9]** = x[1]·h[8] + x[2]·h[7] + x[3]·h[6]
        = 0·1 + 2·0 + (-1)·0 = **0**

**y[10]** = x[2]·h[8] + x[3]·h[7]
         = 2·1 + (-1)·0 = **2**

**y[11]** = x[3]·h[8] = (-1)·1 = **-1**

**Answer:**
**y[n] = {5, -2, 10, -9, 6, -1, 8, -6, 2, 0, 2, -1}** for n = 0 to 11

---

## PART 5: SYSTEM PROPERTIES (Problems 14-17)

### **Fundamental Theory: System Properties**

**Causality:**
- Causal: Output at time n depends only on inputs at time n and earlier
- Non-causal: Output depends on future inputs

**Memory:**
- Memoryless: Output depends only on current input
- With memory: Output depends on past (and possibly future) inputs

**Time-Invariance:**
- Test: If x[n] → y[n], then x[n - k] → y[n - k] for all k
- Invariant: Time shift in input causes same time shift in output
- Variant: System behavior changes with time

**Linearity:**
- Test: If x₁[n] → y₁[n] and x₂[n] → y₂[n], then a₁x₁[n] + a₂x₂[n] → a₁y₁[n] + a₂y₂[n]
- Linear: Satisfies superposition
- Nonlinear: Does not satisfy superposition

---

### **PROBLEM 14**

**Problem Statement:** A discrete-time LTI system is represented by the following difference equation:
y[n] = (1/2)x[n] - (1/4)x[n-1] - (1/3)y[n-1] - (1/6)y[n-2]

Considering the system operation starting at instant n = 0 (causal system), determine the value of the first five (5) output samples of this system, considering the input signal x[n] = {4, -2, 3, 1, 0}.
(Arrow indicates n = 0)

---

#### **Solution:**

**Theory:** This is a recursive (IIR) difference equation. We need to compute y[n] iteratively.

**Initial conditions (causal system starting at n = 0):**
- For n < 0: y[n] = 0 and x[n] = 0
- This means: y[-1] = 0, y[-2] = 0, x[-1] = 0

**Input values:**
- x[0] = 4
- x[1] = -2
- x[2] = 3
- x[3] = 1
- x[4] = 0

**Rearranging the equation to solve for y[n]:**
y[n] = (1/2)x[n] - (1/4)x[n-1] - (1/3)y[n-1] - (1/6)y[n-2]

---

**Computing y[0]:**
y[0] = (1/2)x[0] - (1/4)x[-1] - (1/3)y[-1] - (1/6)y[-2]
     = (1/2)·4 - (1/4)·0 - (1/3)·0 - (1/6)·0
     = 2 - 0 - 0 - 0
     = **2**

---

**Computing y[1]:**
y[1] = (1/2)x[1] - (1/4)x[0] - (1/3)y[0] - (1/6)y[-1]
     = (1/2)·(-2) - (1/4)·4 - (1/3)·2 - (1/6)·0
     = -1 - 1 - 2/3 - 0
     = -2 - 2/3
     = **-8/3** ≈ -2.667

---

**Computing y[2]:**
y[2] = (1/2)x[2] - (1/4)x[1] - (1/3)y[1] - (1/6)y[0]
     = (1/2)·3 - (1/4)·(-2) - (1/3)·(-8/3) - (1/6)·2
     = 3/2 + 1/2 + 8/9 - 1/3
     = 2 + 8/9 - 3/9
     = 2 + 5/9
     = **23/9** ≈ 2.556

---

**Computing y[3]:**
y[3] = (1/2)x[3] - (1/4)x[2] - (1/3)y[2] - (1/6)y[1]
     = (1/2)·1 - (1/4)·3 - (1/3)·(23/9) - (1/6)·(-8/3)
     = 1/2 - 3/4 - 23/27 + 8/18
     = 1/2 - 3/4 - 23/27 + 4/9

Converting to common denominator (108):
     = 54/108 - 81/108 - 92/108 + 48/108
     = (54 - 81 - 92 + 48)/108
     = -71/108
     = **-71/108** ≈ -0.657

---

**Computing y[4]:**
y[4] = (1/2)x[4] - (1/4)x[3] - (1/3)y[3] - (1/6)y[2]
     = (1/2)·0 - (1/4)·1 - (1/3)·(-71/108) - (1/6)·(23/9)
     = 0 - 1/4 + 71/324 - 23/54

Converting to common denominator (324):
     = -81/324 + 71/324 - 138/324
     = -148/324
     = **-37/81** ≈ -0.457

---

**Answer:**
The first 5 output samples are:
- y[0] = 2
- y[1] = -8/3 ≈ -2.667
- y[2] = 23/9 ≈ 2.556
- y[3] = -71/108 ≈ -0.657
- y[4] = -37/81 ≈ -0.457

Or in decimal form: **{2, -2.667, 2.556, -0.657, -0.457}**

---

### **PROBLEMS 15-17: System Property Analysis**

These problems are already solved in the PDF with detailed explanations. Let me summarize the key points:

---

### **PROBLEM 15: Time-Invariance Test**

**System:** y[n] = x[n] - x[n-1] (Differentiator)

**Test procedure:**
1. Delay input by k: x[n] → x[n - k]
2. Pass delayed input through system: y₁[n] = x[n - k] - x[n - k - 1]
3. Delay original output: y₂[n] = y[n - k] = x[n - k] - x[n - k - 1]
4. Compare: y₁[n] = y₂[n] ✓

**Conclusion:** The system is **TIME-INVARIANT**

---

### **PROBLEM 16: Time-Invariance Test**

**System:** y[n] = n·x[n] (Multiplier)

**Test procedure:**
1. Delay input: x[n] → x[n - k]
2. Pass through system: y₁[n] = n·x[n - k]
3. Delay original output: y₂[n] = y[n - k] = (n - k)·x[n - k]
4. Compare: y₁[n] ≠ y₂[n] ✗

**Conclusion:** The system is **TIME-VARIANT**

**Why?** The system's behavior depends explicitly on the time index n, not just on the time difference.

---

### **PROBLEM 17: Linearity Test**

**a) System:** y[n] = n·x[n]

**Test:**
- For x₁[n]: y₁[n] = n·x₁[n]
- For x₂[n]: y₂[n] = n·x₂[n]
- For a₁x₁[n] + a₂x₂[n]: y₃[n] = n·(a₁x₁[n] + a₂x₂[n]) = a₁n·x₁[n] + a₂n·x₂[n]
- Compare: y₃[n] = a₁y₁[n] + a₂y₂[n] ✓

**Conclusion:** The system is **LINEAR**

---

**b) System:** y[n] = x²[n]

**Test:**
- For x₁[n]: y₁[n] = x₁²[n]
- For x₂[n]: y₂[n] = x₂²[n]
- For a₁x₁[n] + a₂x₂[n]: y₃[n] = (a₁x₁[n] + a₂x₂[n])² = a₁²x₁²[n] + 2a₁a₂x₁[n]x₂[n] + a₂²x₂²[n]
- Compare with a₁y₁[n] + a₂y₂[n] = a₁x₁²[n] + a₂x₂²[n]
- These are NOT equal ✗

**Conclusion:** The system is **NONLINEAR**

**Why?** The squaring operation creates cross-terms (2a₁a₂x₁[n]x₂[n]) that violate superposition.

---

## PART 6: RECURSIVE SYSTEMS AND DFT (Problems 18-20)

### **PROBLEM 18**

**Problem Statement:** Consider the discrete system (moving average filter) described by the difference equation below. Write the system's difference equation in recursive form and then represent the system using a block diagram.

y[n] = (1/5)·Σ(k=0 to 4) x[n - k]

---

#### **Solution:**

**Step 1: Expand the non-recursive form**
y[n] = (1/5)[x[n] + x[n-1] + x[n-2] + x[n-3] + x[n-4]]

**Step 2: Convert to recursive form**

**Theory:** A moving average filter can be made recursive by noting:
y[n] = (1/5)[x[n] + x[n-1] + x[n-2] + x[n-3] + x[n-4]]
y[n-1] = (1/5)[x[n-1] + x[n-2] + x[n-3] + x[n-4] + x[n-5]]

Multiplying the second equation by 5:
5y[n-1] = x[n-1] + x[n-2] + x[n-3] + x[n-4] + x[n-5]

So: x[n-1] + x[n-2] + x[n-3] + x[n-4] = 5y[n-1] - x[n-5]

Substituting back:
y[n] = (1/5)[x[n] + 5y[n-1] - x[n-5]]

**Recursive form:**
**y[n] = (1/5)·x[n] + y[n-1] - (1/5)·x[n-5]**

Or equivalently:
**y[n] = y[n-1] + (1/5)·(x[n] - x[n-5])**

---

**Step 3: Block Diagram**

```
x[n] ────┬──────────→ [×1/5] ───┐
         │                       │
         │                       ├──→ [+] ───┬──→ y[n]
         │                       │           │
         └──→ [z⁻⁵] ─→ [×-1/5] ──┘           │
                                             │
         ┌───────────────────────────────────┘
         │
         └──→ [z⁻¹] ──→ [×1] ────────────────┘
```

**Description:**
1. Current input x[n] is multiplied by 1/5
2. Input delayed by 5 samples x[n-5] is multiplied by -1/5
3. These two are summed with previous output y[n-1]
4. Result is y[n], which feeds back through a delay

**Advantage of recursive form:** Only 2 delays (z⁻¹ and z⁻⁴ in cascade) instead of 4 separate delays!

---

### **PROBLEM 19**

**Problem Statement:** A discrete-time LTI system is represented by the following difference equation:
y[n] = x[n] - (1/2)x[n-2] - (1/6)y[n-1]

Considering the system operation starting at instant n = 0 (causal system), determine the value of the first four (4) output samples of this system, considering the input signal x[n] = {1, -1, 2, 0}.

---

#### **Solution:**

**Initial conditions:**
- y[-1] = 0 (causal system)
- x[-1] = 0, x[-2] = 0

**Input:**
- x[0] = 1
- x[1] = -1
- x[2] = 2
- x[3] = 0

---

**Computing y[0]:**
y[0] = x[0] - (1/2)x[-2] - (1/6)y[-1]
     = 1 - (1/2)·0 - (1/6)·0
     = **1**

---

**Computing y[1]:**
y[1] = x[1] - (1/2)x[-1] - (1/6)y[0]
     = -1 - (1/2)·0 - (1/6)·1
     = -1 - 1/6
     = **-7/6** ≈ -1.167

---

**Computing y[2]:**
y[2] = x[2] - (1/2)x[0] - (1/6)y[1]
     = 2 - (1/2)·1 - (1/6)·(-7/6)
     = 2 - 1/2 + 7/36
     = 3/2 + 7/36
     = 54/36 + 7/36
     = **61/36** ≈ 1.694

---

**Computing y[3]:**
y[3] = x[3] - (1/2)x[1] - (1/6)y[2]
     = 0 - (1/2)·(-1) - (1/6)·(61/36)
     = 1/2 - 61/216
     = 108/216 - 61/216
     = **47/216** ≈ 0.218

---

**Answer:**
The first 4 output samples are:
- y[0] = 1
- y[1] = -7/6 ≈ -1.167
- y[2] = 61/36 ≈ 1.694
- y[3] = 47/216 ≈ 0.218

Or: **{1, -1.167, 1.694, 0.218}**

---

### **PROBLEM 20**

**Problem Statement:** Consider that the discrete sequence x[n] = {2, 1, 0, 2} was sampled with sampling frequency Fs = 10 kHz. Calculate the N = 4 point DFT for the sequence x[n] and plot the spectrum (magnitude only) with the frequency scale in hertz and symmetry around the origin of the axes.
(Arrow indicates n = 0)

---

#### **Solution:**

**Theory: N-point DFT**
X[k] = Σ(n=0 to N-1) x[n]·e^(-j2πkn/N) for k = 0, 1, ..., N-1

For N = 4:
X[k] = Σ(n=0 to 3) x[n]·e^(-j2πkn/4) = Σ(n=0 to 3) x[n]·e^(-jπkn/2)

---

**Step 1: Calculate X[0]**
X[0] = Σ(n=0 to 3) x[n]·e^0 = x[0] + x[1] + x[2] + x[3]
     = 2 + 1 + 0 + 2
     = **5**

---

**Step 2: Calculate X[1]**
X[1] = Σ(n=0 to 3) x[n]·e^(-jπn/2)
     = x[0]·e^0 + x[1]·e^(-jπ/2) + x[2]·e^(-jπ) + x[3]·e^(-j3π/2)
     = 2·1 + 1·(-j) + 0·(-1) + 2·(j)
     = 2 - j + 0 + 2j
     = **2 + j**

Magnitude: |X[1]| = √(2² + 1²) = √5 ≈ 2.236

---

**Step 3: Calculate X[2]**
X[2] = Σ(n=0 to 3) x[n]·e^(-jπn)
     = x[0]·1 + x[1]·(-1) + x[2]·1 + x[3]·(-1)
     = 2·1 + 1·(-1) + 0·1 + 2·(-1)
     = 2 - 1 + 0 - 2
     = **-1**

Magnitude: |X[2]| = 1

---

**Step 4: Calculate X[3]**
X[3] = Σ(n=0 to 3) x[n]·e^(-j3πn/2)
     = x[0]·e^0 + x[1]·e^(-j3π/2) + x[2]·e^(-j3π) + x[3]·e^(-j9π/2)
     = 2·1 + 1·(j) + 0·(-1) + 2·(-j)
     = 2 + j + 0 - 2j
     = **2 - j**

Magnitude: |X[3]| = √(2² + 1²) = √5 ≈ 2.236

---

**Step 5: Frequency mapping**

For N = 4 and Fs = 10 kHz:
- k = 0 → F = 0 Hz
- k = 1 → F = k·Fs/N = 1·10000/4 = 2500 Hz
- k = 2 → F = 2·10000/4 = 5000 Hz
- k = 3 → F = 3·10000/4 = 7500 Hz

**For symmetric plot around origin:**
We can also represent negative frequencies:
- k = 3 → F = -2500 Hz (since 7500 - 10000 = -2500)
- k = 2 → F = ±5000 Hz (Nyquist frequency)
- k = 1 → F = +2500 Hz
- k = 0 → F = 0 Hz

---

**Step 6: Magnitude Spectrum**

**Symmetric representation:**
| Frequency (Hz) | k | |X[k]| |
|----------------|---|--------|
| -2500 | 3 | 2.236 |
| 0 | 0 | 5.000 |
| +2500 | 1 | 2.236 |
| ±5000 | 2 | 1.000 |

---

**Step 7: Plot**

```
|X(F)|
  5 |     •
    |
  4 |
    |
  3 |
    |
  2 |  •           •
    |
  1 |                    •
    |
  0 |__|__|__|__|__|__|__|__
    -5k  -2.5k  0  2.5k  5k  F(Hz)
```

**Answer:**
DFT coefficients:
- X[0] = 5
- X[1] = 2 + j, |X[1]| = √5
- X[2] = -1, |X[2]| = 1
- X[3] = 2 - j, |X[3]| = √5

Magnitude spectrum shows peaks at DC (0 Hz), ±2.5 kHz, and Nyquist frequency (±5 kHz).

---

## SUMMARY

All 20 problems have been solved with detailed explanations covering:

1. **Sampling & Aliasing** - Understanding frequency normalization and Nyquist theorem
2. **Periodicity** - Determining if discrete sequences repeat
3. **Signal Operations** - Manipulating impulses and steps
4. **Convolution** - Computing LTI system outputs
5. **System Properties** - Testing linearity and time-invariance
6. **Difference Equations** - Both non-recursive and recursive forms
7. **DFT** - Spectral analysis of discrete signals

Each solution includes:
- Theoretical background
- Step-by-step calculations
- Physical interpretation
- Final answers

Good luck with your exam preparation!
