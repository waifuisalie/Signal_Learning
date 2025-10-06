# 🚀 Quick Start Guide - MATLAB Online Setup

**Get your exam prep environment running in 5 minutes!**

---

## 📋 Prerequisites

- Access to [MATLAB Online](https://matlab.mathworks.com/) (free with MathWorks account)
- This `Signal_Studies_RA1_Exam_Prep` folder downloaded

---

## 🏃 Step-by-Step Setup

### **Step 1: Upload to MATLAB Online**

1. Go to [matlab.mathworks.com](https://matlab.mathworks.com/)
2. Log in with your MathWorks account
3. Click the **Upload** button (top-left, folder with arrow icon)
4. Select the **entire** `Signal_Studies_RA1_Exam_Prep` folder
5. Wait for upload to complete (~2-3 minutes)

**Result:** You should see the folder appear in your MATLAB Online file browser

---

### **Step 2: Add Utilities to Path**

In the MATLAB Command Window, type:

```matlab
addpath('Signal_Studies_RA1_Exam_Prep/Utilities')
```

Press **Enter**.

**Expected output:**
```
>>
```
(No error = success!)

**Alternative (permanent):** Add this line to your `startup.m` file

---

### **Step 3: Test the Setup**

Run a quick test to verify everything works:

```matlab
% Navigate to Lab 1
cd Signal_Studies_RA1_Exam_Prep/Lab1_Discrete_Sequences

% Test utility function
[x, n] = impseq(0, -5, 5);
stem(n, x, 'filled')
title('Test: Impulse Function')
```

**Expected result:** A plot showing an impulse at n=0

---

### **Step 4: Run Your First Lab**

```matlab
% Run Lab 1 (will generate multiple figures)
lab1_main
```

**What to expect:**
- Multiple figure windows will appear (MATLAB Online shows them in tabs)
- Script execution takes ~5-10 seconds
- Console will show progress messages

---

## 🎯 Daily Workflow

### **Starting a Study Session**

```matlab
% 1. Set up path (if not permanent)
addpath('Signal_Studies_RA1_Exam_Prep/Utilities')

% 2. Navigate to desired lab
cd Signal_Studies_RA1_Exam_Prep/Lab2_Signal_Operations

% 3. Run the lab
lab2_main
```

### **Switching Between Labs**

```matlab
% From any location:
cd ~/Signal_Studies_RA1_Exam_Prep/Lab3_LTI_Systems
lab3_main

% Or use absolute path:
cd('/MATLAB Drive/Signal_Studies_RA1_Exam_Prep/Lab4_Fourier_Analysis')
lab4_main
```

### **Running Lab 3 Real-Time Exercise**

```matlab
cd Signal_Studies_RA1_Exam_Prep/Lab3_LTI_Systems
lab3_realtime  % Interactive - enter values when prompted
```

---

## 📁 Understanding the Structure

```
Signal_Studies_RA1_Exam_Prep/
│
├── Utilities/          ← MUST be in path (shared functions)
│
├── Lab1_../            ← Independent lab folders
├── Lab2_../
├── Lab3_../
└── Lab4_../
```

**Key Point:** Each lab folder is self-contained EXCEPT for Utilities/

---

## 🔧 Common Tasks

### **Clear Everything Before Running a Lab**

```matlab
clear; clc; close all;
lab1_main  % Starts fresh
```

### **View All Figures from a Lab**

```matlab
% After running a lab:
shg  % Show graphics (brings figures to front)

% Or manually:
figure(1)  % Shows figure 1
figure(5)  % Shows figure 5
```

### **Save Figures**

```matlab
% After generating a plot:
saveas(gcf, 'my_plot.png')  % Saves current figure
```

### **Run Only Part of a Lab**

Open the `.m` file and run sections using **Run Section** button (Ctrl+Enter)

---

## 🛠️ Troubleshooting

### **Problem: "Undefined function 'impseq'"**

**Cause:** Utilities folder not in path

**Solution:**
```matlab
addpath('Signal_Studies_RA1_Exam_Prep/Utilities')
% Or navigate to root and:
addpath('Utilities')
```

---

### **Problem: "Cannot cd to Signal_Studies_RA1_Exam_Prep/"**

**Cause:** Wrong working directory

**Solution:**
```matlab
% Check where you are:
pwd

% Go to MATLAB Drive root:
cd ~

% Or:
cd('/MATLAB Drive')

% Then navigate:
cd Signal_Studies_RA1_Exam_Prep
```

---

### **Problem: Script runs but no plots appear**

**Cause:** Figures are in background tabs

**Solution:**
- Look for **Figure** tabs at the top of MATLAB Online
- Or run: `shg` to bring figures forward

---

### **Problem: "Too many output arguments"**

**Cause:** Calling utility function incorrectly

**Solution:** Check syntax in [README.md](README.md) or function help:
```matlab
help impseq
```

---

## 📝 Best Practices for MATLAB Online

### **Before Each Study Session:**
1. ✅ Verify Utilities is in path: `which impseq`
2. ✅ Clear workspace: `clear; clc; close all`
3. ✅ Navigate to correct lab folder

### **During Study:**
1. ✅ Read script comments (embedded theory!)
2. ✅ Run sections separately (Ctrl+Enter)
3. ✅ Modify values and re-run to experiment

### **After Each Lab:**
1. ✅ Review figures (understand what they show)
2. ✅ Check console output (summaries and tables)
3. ✅ Read corresponding `LabN_Guide.md`

---

## 🎯 Recommended Study Order

### **Week 1: Foundations**
```matlab
% Day 1-2: Basics
cd Lab1_Discrete_Sequences
lab1_main
% Read Lab1_Guide.md

% Day 3-4: Operations
cd ../Lab2_Signal_Operations
lab2_main
% Read Lab2_Guide.md
```

### **Week 2: Systems & Fourier**
```matlab
% Day 1-3: Systems
cd ../Lab3_LTI_Systems
lab3_main
lab3_realtime
% Read Lab3_Guide.md

% Day 4-5: Fourier
cd ../Lab4_Fourier_Analysis
lab4_main
% Read Lab4_Guide.md
```

### **Week 3: Practice**
```matlab
% Use Exam_Practice/template.m
% Solve sample problems
% Review all labs
```

---

## 📱 Mobile Access

MATLAB Online works on tablets/phones (limited):
1. Use landscape mode
2. Zoom in for better readability
3. Desktop recommended for exam prep

---

## 💾 Saving Your Work

MATLAB Online auto-saves to **MATLAB Drive**
- All files persist between sessions
- Access from any device
- 5 GB free storage

**To download work:**
1. Right-click file/folder
2. Select **Download**

---

## ✅ Setup Verification Checklist

Run this verification script:

```matlab
% === SETUP VERIFICATION ===
fprintf('\n=== Verifying Setup ===\n');

% Test 1: Utilities in path
if ~isempty(which('impseq'))
    fprintf('✓ Utilities folder is in path\n');
else
    fprintf('✗ Utilities NOT in path - run: addpath(''Utilities'')\n');
end

% Test 2: All labs present
labs = {'Lab1_Discrete_Sequences', 'Lab2_Signal_Operations', ...
        'Lab3_LTI_Systems', 'Lab4_Fourier_Analysis'};
for i = 1:length(labs)
    if isfolder(labs{i})
        fprintf('✓ %s found\n', labs{i});
    else
        fprintf('✗ %s NOT found\n', labs{i});
    end
end

% Test 3: Utility functions work
try
    [x,n] = impseq(0,-5,5);
    fprintf('✓ impseq() works\n');
catch
    fprintf('✗ impseq() failed\n');
end

fprintf('\n=== Setup Complete! ===\n\n');
```

**Expected output:**
```
=== Verifying Setup ===
✓ Utilities folder is in path
✓ Lab1_Discrete_Sequences found
✓ Lab2_Signal_Operations found
✓ Lab3_LTI_Systems found
✓ Lab4_Fourier_Analysis found
✓ impseq() works

=== Setup Complete! ===
```

---

## 🎓 Ready to Start!

You're all set! Begin with:

```matlab
cd Signal_Studies_RA1_Exam_Prep/Lab1_Discrete_Sequences
lab1_main
```

**Pro Tip:** Keep [README.md](README.md) open in a browser while coding - it has all formulas and references!

---

**Happy Studying! 📚✨**
