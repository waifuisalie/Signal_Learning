# Lab 2: Signal Operations - Study Guide

## 🎯 Learning Objectives
- Master impulse and step generation with shifts
- Perform signal addition/multiplication with different time supports
- Apply time shifting and folding operations
- Combine multiple operations in sequence

---

## 📋 Key Operations

### **1. Impulse Generation: impseq(n0, n1, n2)**
```matlab
[x,n] = impseq(4, -20, 20)  % δ[n-4]
```
- **n0:** Where impulse occurs (n0=4 → impulse at n=4)
- **[n1,n2]:** Time range

**Memory Aid:** δ[n-k] → impulse at n=k

---

### **2. Step Generation: stepseq(n0, n1, n2)**
```matlab
[x,n] = stepseq(-5, -20, 20)  % u[n+5]
```
- **n0:** Where step activates
- u[n-k] → activates at n=k
- u[n+k] → activates at n=-k

---

### **3. Signal Addition: sigadd(x1,n1,x2,n2)**
```matlab
[y,n] = sigadd(x1, [-3:7], x2, [0:8])
```
- Automatically aligns different time supports
- **Result range:** [min(n1,n2), max(n1,n2)]
- Values outside overlap preserved

---

### **4. Signal Multiplication: sigmult(x1,n1,x2,n2)**
```matlab
[y,n] = sigmult(x1, n1, x2, n2)
```
- Element-wise multiplication
- **Zeros outside overlap** (unlike addition!)
- Used for windowing/modulation

---

### **5. Time Shifting: sigshift(x,m,k)**
```matlab
[y,n] = sigshift(x, m, 4)   % y[n] = x[n-4] (delay)
[y,n] = sigshift(x, m, -3)  % y[n] = x[n+3] (advance)
```

**Critical Rules:**
- **k > 0:** DELAY (shift RIGHT) → y[n] = x[n-k]
- **k < 0:** ADVANCE (shift LEFT) → y[n] = x[n+k]
- New indices: `n = m + k`

**Memory Aid:** "To get y now, look at x from k steps AGO" → shift right

---

### **6. Time Folding: sigfold(x,n)**
```matlab
[y,n_out] = sigfold(x, n)  % y[n] = x[-n]
```
- Flips signal around n=0
- `y = fliplr(x)`, `n_out = -fliplr(n)`

---

## 🔧 Exercise Breakdown

### **Ex 1-2: Basic Generation**
- Practice with shifts: δ[n], δ[n-4], δ[n+8]
- Same for steps: u[n], u[n-4], u[n+5]

### **Ex 3-4: Addition vs Multiplication**
Same signals:
- **Addition:** Sum everywhere (zeros fill gaps)
- **Multiplication:** Product only in overlap (zeros elsewhere)

### **Ex 5: Shifting Practice**
x on [-3:7]
- x[n-4]: Shift to [1:11] (moved right 4)
- x[n+4]: Shift to [-7:3] (moved left 4)

### **Ex 6: Folding**
x on [-3:7] → x[-n] on [-7:3] (reversed and negated indices)

### **Ex 7: COMPLEX COMBINATIONS** ⭐

#### **7a: Linear Combination**
```
x1[n] = 3x[n+2] + x[n-4] - 2x[n]
```
1. Shift x by -2: `sigshift(x, n, -2)` → x[n+2]
2. Shift x by +4: `sigshift(x, n, 4)` → x[n-4]
3. Add: `sigadd(3*term1, ..., term2, ...)`
4. Subtract: `sigadd(temp, ..., -2*x, n)`

#### **7c: MOST COMPLEX** 🔥
```
x3[n] = x[n+4]·x[n-1] + x[2-n]·x[n]
```

**Part A:** x[n+4]·x[n-1]
1. x[n+4]: `sigshift(x, n, -4)`
2. x[n-1]: `sigshift(x, n, 1)`
3. Multiply: `sigmult(...)`

**Part B:** x[2-n]·x[n]
1. x[-n]: `sigfold(x, n)` → x_folded
2. x[2-n] = x[-n+2]: `sigshift(x_folded, n_folded, 2)`
3. Multiply with x[n]: `sigmult(x_2mn, n_2mn, x, n)`

**Final:** `sigadd(partA, nA, partB, nB)`

---

## 🔑 Key Rules

### **Time Shift Direction**
```
y[n] = x[n-k]:
  k > 0 → DELAY → shift RIGHT → indices INCREASE
  k < 0 → ADVANCE → shift LEFT → indices DECREASE

sigshift(x,m,k): n_new = m + k
```

### **Signal Combination**
```
Addition:
  - Expands to union of supports
  - Preserves values outside overlap

Multiplication:
  - Expands to union of supports
  - ZEROS outside overlap
```

### **Index Arithmetic**
```
Original: n ∈ [a, b]

x[n-k]:   n ∈ [a+k, b+k]  (shift by +k)
x[n+k]:   n ∈ [a-k, b-k]  (shift by -k)
x[-n]:    n ∈ [-b, -a]    (reverse and negate)
```

---

## ⚠️ Common Mistakes

1. **Wrong shift direction**
   - x[n-4] means delay (shift RIGHT), not left!
   - Use sigshift with k=+4 for x[n-4]

2. **Forgetting to track indices**
   - Always keep (x, n) paired
   - Never just manipulate x alone

3. **Using built-in ops incorrectly**
   - `x1 + x2` FAILS if n1 ≠ n2
   - Must use `sigadd()`

4. **Order of operations in Ex 7c**
   - Fold FIRST, then shift: x[2-n] = shift(fold(x))

---

## 💡 Exam Tips

### **For Time Shifts:**
1. Identify k in x[n±k]
2. Determine direction (- is right, + is left)
3. Use `sigshift(x, n, ±k)` with correct sign

### **For Complex Operations:**
1. Break into sub-expressions
2. Compute each term separately
3. Combine using sigadd/sigmult
4. **Track indices at each step!**

### **Quick Reference Card:**
```
δ[n-k] → impseq(k, ...)     k=where impulse is
u[n-k] → stepseq(k, ...)    k=where step starts
x[n-k] → sigshift(x,n,+k)   +k for delay
x[n+k] → sigshift(x,n,-k)   -k for advance
x[-n]  → sigfold(x,n)       flip around 0
```

---

## 🔗 Related Topics
- Lab 1: Impulse/step basics
- Lab 3: Convolution uses shifting
- Exam: Often combines 3-4 operations!
