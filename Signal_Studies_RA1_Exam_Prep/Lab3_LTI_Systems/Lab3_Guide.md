# Lab 3: LTI Systems & Filtering - Study Guide

## 🎯 Learning Objectives
- Decompose signals into even/odd components
- Understand and compute convolution
- Map difference equations to filter() coefficients
- Implement FIR and IIR filters
- Analyze impulse and step responses

---

## 📋 Key Concepts

### **1. Even/Odd Decomposition**
```matlab
[xe, xo, m] = evenodd(x, n)
```

**Theory:**
```
xe[n] = [x[n] + x[-n]]/2   (even: xe[-n] = xe[n])
xo[n] = [x[n] - x[-n]]/2   (odd:  xo[-n] = -xo[n])

x[n] = xe[n] + xo[n]  (always true for real signals)
```

**Applications:** Symmetry analysis, Fourier decomposition

---

### **2. Convolution**

#### **Standard (conv):**
```matlab
y = conv(x, h)
ny = (nx(1)+nh(1)) : (nx(end)+nh(end))
```
- **Assumes:** Signals start at n=0
- **Length:** `length(y) = length(x) + length(h) - 1`

#### **Modified (conv_m):**
```matlab
[y, ny] = conv_m(x, nx, h, nh)
```
- **For:** Arbitrary time indices
- **Indices:** `ny = [nx(1)+nh(1), nx(end)+nh(end)]`

**Mathematical Definition:**
```
y[n] = x[n] * h[n] = Σ x[k]·h[n-k]
                    k=-∞ to +∞
```

**Properties:**
- Commutative: x*h = h*x
- Associative: (x*h₁)*h₂ = x*(h₁*h₂)
- Distributive: x*(h₁+h₂) = x*h₁ + x*h₂

---

### **3. filter() Function** ⭐

#### **Syntax:**
```matlab
y = filter(b, a, x)
```

#### **Implements:**
```
a(1)·y[n] + a(2)·y[n-1] + a(3)·y[n-2] + ... =
  b(1)·x[n] + b(2)·x[n-1] + b(3)·x[n-2] + ...
```

#### **Critical Mapping Rules:**

**Difference Equation:**
```
y[n] - y[n-1] + 0.9·y[n-2] = x[n]
```

**Rearrange to standard form:**
```
1·y[n] + (-1)·y[n-1] + 0.9·y[n-2] = 1·x[n]
```

**MATLAB coefficients:**
```matlab
a = [1, -1, 0.9]   % Feedback (recursive, y terms)
b = [1]            % Feedforward (direct, x terms)
```

**⚠️ SIGN WARNING:**
```
filter() uses: y[n] = b(1)x[n] - a(2)y[n-1] - a(3)y[n-2]

Equation: y[n] = x[n] + y[n-1] - 0.9·y[n-2]
                       ↑           ↑
                      +1         -0.9

Therefore: a = [1, -1, 0.9]  (signs INVERTED!)
                  ↑   ↑  ↑
                  ÷  -(-1) -(-0.9)
```

---

## 🔧 Exercise Breakdown

### **Ex 1: Even/Odd Decomposition**

**1a:** x[n] = u[n] - u[n-10] (rectangular pulse)
- xe[n]: Symmetric trapezoid
- xo[n]: Antisymmetric sawtooth

**1b:** x[n] = (0.8)ⁿ (exponential)
- xe[n]: Symmetrized exponential
- xo[n]: Antisymmetrized exponential

---

### **Ex 2: Standard Convolution**
```matlab
xn = [3,11,7,0,-1,4,2];  nx = 0:6;  (7 elements)
hn = [2,3,0,-5,2,1];     nh = 0:5;  (6 elements)

y = conv(xn, hn);  % 12 elements
ny = 0:11;         % 0+0 to 6+5
```

**Manual check:**
```
y[0] = x[0]·h[0] = 3·2 = 6
y[1] = x[0]·h[1] + x[1]·h[0] = 3·3 + 11·2 = 31
...
```

---

### **Ex 3: Arbitrary-Index Convolution**
```matlab
xn on [-3:3], hn on [-1:4]

[y,ny] = conv_m(xn, [-3:3], hn, [-1:4])

Result: ny = [-3+(-1), 3+4] = [-4, 7]
```

**Why conv_m?** Standard conv() would give wrong indices!

---

### **Ex 4: System Analysis**

**System:** `y[n] - y[n-1] + 0.9·y[n-2] = x[n]`

#### **4a: Impulse Response h[n]**
```matlab
[x,n] = impseq(0, -20, 120);  % δ[n]
a = [1, -1, 0.9];
b = [1];
h = filter(b, a, x);
```

**Interpretation:** h[n] = system's "signature"

#### **4b: Step Response s[n]**
```matlab
[x,n] = stepseq(0, -20, 120);  % u[n]
s = filter(b, a, x);
```

**Relationship:** s[n] = Σh[k] (cumulative sum)

#### **4c: Real-Time Implementation** (lab3_realtime.m)
```matlab
y1 = 0; y2 = 0;  % Initial conditions
for each sample:
  y = x + y1 - 0.9*y2;  % Compute output
  y2 = y1;              % Update delays
  y1 = y;
```

---

### **Ex 5: Moving Average Filter**
```matlab
M = 10;
b = (1/M) * ones(1,M);  % [0.1, 0.1, ..., 0.1]
a = [1];                % Non-recursive (FIR)

y = filter(b, a, x_noisy);
```

**Properties:**
- Low-pass filter (smooths high-frequency noise)
- Delay: (M-1)/2 samples
- Gain: H(0) = 1 (DC preserved)

---

## 🔑 Key Formulas

### **Convolution Length**
```
length(y) = length(x) + length(h) - 1
```

### **Convolution Index Range**
```
ny_start = nx(1) + nh(1)
ny_end = nx(end) + nh(end)
```

### **filter() Mapping**
```
Equation: y[n] + a₁y[n-1] + a₂y[n-2] = b₀x[n] + b₁x[n-1]

MATLAB:   a = [1, -a₁, -a₂]  (note minus signs!)
          b = [b₀, b₁]

filter([b₀,b₁], [1,-a₁,-a₂], x)
```

### **System Types**
```
FIR (Finite Impulse Response):
  - a = [1]  (no feedback)
  - h[n] has finite length
  - Always stable
  - Example: Moving average

IIR (Infinite Impulse Response):
  - a has multiple elements (feedback)
  - h[n] decays to infinity
  - Can be unstable
  - Example: y[n] = x[n] + 0.8y[n-1]
```

---

## ⚠️ Common Mistakes

1. **Wrong filter() signs**
   ```
   ❌ y[n] + 0.5y[n-1] = x[n]  →  a = [1, 0.5]
   ✅ y[n] + 0.5y[n-1] = x[n]  →  a = [1, -0.5]
   ```
   Remember: filter() SUBTRACTS a(2:end)!

2. **Using conv() with arbitrary indices**
   - Use conv_m() instead
   - conv() assumes starting at n=0

3. **Forgetting length of convolution**
   - Always: len(y) = len(x) + len(h) - 1

4. **Wrong initial conditions in Ex 4c**
   - System at rest: y[-1] = y[-2] = 0

---

## 💡 Exam Tips

### **Difference Equation → filter():**
1. Move all y terms to left, x terms to right
2. Extract coefficients: `a(1)=1, a(2)=..., b(1)=...`
3. **INVERT signs of y[n-k] coefficients for a!**
4. Call `filter(b, a, x)`

### **Quick Coefficient Check:**
```
y[n] = 0.5x[n] + 0.3x[n-1] + 0.8y[n-1]
       ↓        ↓           ↓
b = [0.5, 0.3],  a = [1, -0.8]
                            ↑ negative!
```

### **For Convolution Problems:**
- Start from n=0? → `conv()`
- Arbitrary indices? → `conv_m()`
- Always verify index ranges

---

## 🔗 Related Topics
- Lab 1: Impulse/step (inputs to systems)
- Lab 2: Shifting (key part of convolution)
- Lab 4: H(e^jω) frequency response
