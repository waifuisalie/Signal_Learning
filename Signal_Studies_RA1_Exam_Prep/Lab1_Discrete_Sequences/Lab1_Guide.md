# Lab 1: Discrete Sequences - Study Guide

## 🎯 Learning Objectives
- Represent discrete signals using vectors (x, n)
- Generate and manipulate basic sequences (impulse, step, exponentials)
- Understand sampling, normalized frequency, and aliasing
- Analyze periodicity of discrete sequences

---

## 📋 Key Exercises

### **Ex 1: Basic Representation (1a-1k)**
- Manual vector definition with arbitrary indices
- Impulse δ[n] and step u[n] sequences
- Mathematical functions: n², (0.9)ⁿ, exp(|n/4|)
- Piecewise functions using logical indexing

**Key Skill:** Understand where n=0 is located in the vector

---

### **Ex 2: Real Exponentials (2a-2c)**
- x[n] = k·aⁿ
- **0 < a < 1:** Decay (stable)
- **a > 1:** Growth (unstable)

---

### **Ex 3: Complex Exponentials (3a-3d)**
- x[n] = e^((σ + jω)n)
- **σ > 0:** Growing envelope
- **σ < 0:** Decaying envelope (stable)
- **σ = 0:** Pure oscillation (constant envelope)

**Components:** Real, Imaginary, Magnitude, Phase

---

### **Ex 4: Sampling/Digitization (4a-4d)**
```
ω = 2πf/Fs  (normalized frequency)

Fs = 200 Hz → fN = 100 Hz (Nyquist)
- f = 10 Hz:  ω = π/10 ✓ (well sampled)
- f = 100 Hz: ω = π (Nyquist limit)
```

---

### **Ex 5: Frequency Analysis**
Test ω = {0, π/4, π/2, 3π/4, π, 5π/4, 3π/2, 7π/4, 2π}

**Key Observations:**
- ω = 0: DC (constant)
- ω = π: Maximum oscillation (alternates ±1)
- ω > π: **ALIASING** (folds back)
  - ω = 5π/4 looks like 3π/4
  - ω = 2π looks like 0

---

### **Ex 6: Sinusoid Sum**
x[n] = 5cos(ωn + φ) + 2sin(ωn)

Same frequency → combined into single sinusoid with adjusted amplitude/phase

---

### **Ex 7: Periodicity Test (Critical!)**

**Rule:** x[n] = cos(ωn) is periodic ⟺ ω/(2π) = k/N (rational)

| Signal | ω/(2π) | Periodic? | Period |
|--------|--------|-----------|--------|
| cos(πn/4) | 1/8 | YES | N=8 |
| cos(3πn/8) | 3/16 | YES | N=16 |
| cos(n) | 1/(2π) | NO | ∞ (irrational) |

---

## 🔑 Key Formulas

### Normalized Frequency
```
ω = 2πf/Fs  (rad/sample)

Conversion back: f = ω·Fs/(2π)
```

### Nyquist Theorem
```
Fs ≥ 2·fmax  (avoid aliasing)

fN = Fs/2  (Nyquist frequency)
ωN = π     (Nyquist in normalized)
```

### Aliasing
```
If f > Fs/2:
  f_apparent = |f - k·Fs|  (k chosen to put in [0, Fs/2])
```

### Periodicity
```
cos(ωn) periodic ⟺ ω/(2π) ∈ ℚ (rational)

If ω/(2π) = k/N (reduced form):
  → Period = N samples
```

---

## ⚠️ Common Mistakes

1. **Forgetting where n=0 is**
   - Always track: "4th element corresponds to n=0"

2. **Confusing ω and f**
   - ω is normalized (rad/sample), f is analog (Hz)

3. **Wrong aliasing calculation**
   - Remember: frequencies above π fold back

4. **Periodicity test errors**
   - Must reduce fraction first: 6/16 = 3/8 → N=8 (not 16!)

---

## 💡 Exam Tips

- **Memorize:** ω = 2πf/Fs
- **Remember:** π is the "magic number" (Nyquist in normalized frequency)
- **Practice:** Rationality test for ω/(2π)
- **Understand:** Aliasing = folding around π

---

## 🔗 Related Topics
- Lab 2: Time shifting (builds on Ex 1-2)
- Lab 3: Periodicity affects system response
- Lab 4: Frequency content (connects to Ex 5-6)
