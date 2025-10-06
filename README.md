# Studying for Signals RA1 Tests

**Complete study repository for Digital Signal Processing RA1 assessment**

---

## 📂 Repository Structure

```
Signal_Studies_RA1/
│
├── 📄 README.md                               # This file - repository overview
├── 📄 CLAUDE.md                               # Instructions for Claude Code assistant
│
├── 📂 Theory_test/                            # Theory exam materials
│   ├── Lista1.pdf                            # 20 theory problems (original)
│   ├── Lista1_Solutions.md                   # ✅ Complete solutions (detailed)
│   └── Topics_To_Study.pdf                   # Official exam topics list
│
├── 📂 Lab_test/                              # Lab exam materials
│   └── Lab_Sinais_Codes/
│       └── Labs/                             # Original lab scripts & utilities
│           ├── lab1_script(1).m             # Lab 1: Discrete sequences
│           ├── lab2_sinais_final.m          # Lab 2: Signal operations
│           ├── lab3_sinais_final.m          # Lab 3: LTI systems
│           ├── lab4_sinais_script.m         # Lab 4: Fourier analysis
│           └── [80+ utility functions]       # impseq, stepseq, sigadd, etc.
│
└── 📂 Signal_Studies_RA1_Exam_Prep/          # 🎯 MAIN STUDY PACKAGE
    │
    ├── 📄 README.md                          # Complete study guide
    ├── 📄 QUICK_START.md                     # MATLAB Online setup
    ├── 📄 setup.m                            # Auto-configure script
    │
    ├── 📂 Utilities/                         # Shared utility functions
    │   ├── impseq.m                         # Impulse sequence δ[n-n0]
    │   ├── stepseq.m                        # Step sequence u[n-n0]
    │   ├── sigadd.m                         # Signal addition
    │   ├── sigmult.m                        # Signal multiplication
    │   ├── sigshift.m                       # Time shifting
    │   ├── sigfold.m                        # Time folding
    │   ├── evenodd.m                        # Even/odd decomposition
    │   └── conv_m.m                         # Modified convolution
    │
    ├── 📂 Lab1_Discrete_Sequences/
    │   ├── lab1_main.m                      # Enhanced lab 1 (detailed comments)
    │   └── Lab1_Guide.md                    # Study guide: sampling, aliasing
    │
    ├── 📂 Lab2_Signal_Operations/
    │   ├── lab2_main.m                      # Enhanced lab 2 (operation theory)
    │   └── Lab2_Guide.md                    # Study guide: shift, fold, combine
    │
    ├── 📂 Lab3_LTI_Systems/
    │   ├── lab3_main.m                      # Enhanced lab 3 (system theory)
    │   ├── lab3_realtime.m                  # Real-time implementation
    │   └── Lab3_Guide.md                    # Study guide: convolution, filter()
    │
    ├── 📂 Lab4_Fourier_Analysis/
    │   ├── lab4_main.m                      # Enhanced lab 4 (Fourier theory)
    │   └── Lab4_Guide.md                    # Study guide: synthesis, FFT
    │
    └── 📂 Exam_Practice/
        └── template.m                        # Problem-solving template
```

---

## 🎯 What's Where

### **📚 Theory Study Materials**

| File | Location | Description |
|------|----------|-------------|
| **Lista1_Solutions.md** | `Theory_test/` | ✅ **YOUR COMPLETE THEORY GUIDE**<br>All 20 problems solved with extreme detail |
| Lista1.pdf | `Theory_test/` | Original problem set |
| Topics_To_Study.pdf | `Theory_test/` | Official exam topics checklist |

### **💻 Lab Study Materials**

| File/Folder | Location | Description |
|-------------|----------|-------------|
| **Signal_Studies_RA1_Exam_Prep/** | Root folder | 🎯 **MAIN STUDY PACKAGE**<br>Everything you need for lab exam |
| README.md | `Exam_Prep/` | Complete study guide with formulas |
| QUICK_START.md | `Exam_Prep/` | MATLAB Online setup instructions |
| lab1_main.m - lab4_main.m | `Exam_Prep/Lab*/` | Enhanced labs with 2-3x more comments |
| Lab1_Guide.md - Lab4_Guide.md | `Exam_Prep/Lab*/` | Focused study guides per lab |
| template.m | `Exam_Prep/Exam_Practice/` | Practice problem template |

### **🔧 Original Lab Files** (Reference Only)

| File | Location | Use |
|------|----------|-----|
| lab1_script(1).m | `Lab_test/.../Labs/` | Original Lab 1 |
| lab2_sinais_final.m | `Lab_test/.../Labs/` | Original Lab 2 |
| lab3_sinais_final.m | `Lab_test/.../Labs/` | Original Lab 3 |
| lab4_sinais_script.m | `Lab_test/.../Labs/` | Original Lab 4 |
| Utility functions | `Lab_test/.../Labs/` | Original utility .m files |

---

## 🚀 Quick Start Guide

### **For Theory Exam:**
```bash
# Read the complete solutions
Open: Theory_test/Lista1_Solutions.md

# This file contains:
✓ All 20 problems solved
✓ Step-by-step detailed explanations
✓ Theory background for each topic
✓ Physical interpretations
```

### **For Lab Exam:**
```bash
# 1. Navigate to exam prep folder
cd Signal_Studies_RA1_Exam_Prep/

# 2. Run setup (adds utilities to path)
# In MATLAB:
setup

# 3. Start with any lab
cd Lab1_Discrete_Sequences
lab1_main

# Or go directly to a lab:
cd Lab2_Signal_Operations; lab2_main
cd Lab3_LTI_Systems; lab3_main
cd Lab4_Fourier_Analysis; lab4_main
```

### **For MATLAB Online:**
1. Upload `Signal_Studies_RA1_Exam_Prep/` folder
2. Follow instructions in `QUICK_START.md`
3. Run `setup.m` to configure paths
4. Execute any lab script

---

## 📖 Study Resources Overview

### **Theory Preparation**
- **Primary:** `Theory_test/Lista1_Solutions.md` - Your complete theory guide
  - 20 problems covering all exam topics
  - Extremely detailed solutions
  - Step-by-step calculations
  - Concept explanations

### **Lab Preparation**
- **Primary:** `Signal_Studies_RA1_Exam_Prep/` - Your complete lab package
  - 4 enhanced lab scripts (with extensive comments)
  - 4 focused study guides (Lab*_Guide.md)
  - Complete formula reference (README.md)
  - Practice templates (template.m)

### **Quick References**
- `Exam_Prep/README.md` - All formulas, function syntax, exam patterns
- `Exam_Prep/Lab*_Guide.md` - Quick concept reviews per lab
- `CLAUDE.md` - Instructions for AI assistant (if using Claude Code)

---

## 🎓 Study Plan Recommendation

### **Week 1: Theory Foundation**
1. Read `Lista1_Solutions.md` problems 1-10 (sampling, periodicity)
2. Practice concepts in MATLAB using Lab 1

### **Week 2: Signal Operations & Systems**
1. Read `Lista1_Solutions.md` problems 11-17 (operations, systems)
2. Work through Labs 2-3
3. Read corresponding Lab Guides

### **Week 3: Fourier & Practice**
1. Read `Lista1_Solutions.md` problems 18-20 (DFT, filters)
2. Complete Lab 4
3. Use `template.m` for practice problems
4. Review all Lab*_Guide.md files

### **Final Review:**
1. Skim `Exam_Prep/README.md` (formulas section)
2. Re-run all 4 labs
3. Check "Common Mistakes" in each Lab Guide

---

## 📝 Important Files Checklist

Before exam, make sure you have access to:

- [x] `Theory_test/Lista1_Solutions.md` - Theory solutions
- [x] `Exam_Prep/README.md` - Complete study guide
- [x] `Exam_Prep/QUICK_START.md` - Setup instructions
- [x] `Exam_Prep/Lab*/lab*_main.m` - Enhanced lab scripts (4 files)
- [x] `Exam_Prep/Lab*/Lab*_Guide.md` - Study guides (4 files)
- [x] `Exam_Prep/Utilities/*.m` - Utility functions (8 files)
- [x] `Exam_Prep/Exam_Practice/template.m` - Practice template

---

## 🔗 Key Topics Covered

### **Theory (Lista1_Solutions.md):**
- Sampling & Aliasing (Problems 1-7)
- Periodicity (Problems 8-10)
- Signal Operations (Problem 11)
- Convolution & LTI Systems (Problems 12-13)
- System Properties (Problems 14-17)
- Filters & DFT (Problems 18-20)

### **Labs (Exam_Prep folder):**
- **Lab 1:** Discrete sequences, sampling, normalized frequency, periodicity
- **Lab 2:** Impulse/step, addition/multiplication, shifting, folding
- **Lab 3:** Convolution, filter(), LTI systems, even/odd decomposition
- **Lab 4:** Fourier synthesis, harmonics, FFT analysis, spectral interpretation

---

## ⚡ Quick Access Commands

```matlab
% Setup environment
cd Signal_Studies_RA1_Exam_Prep
setup

% Run all labs in sequence
cd Lab1_Discrete_Sequences; lab1_main
cd ../Lab2_Signal_Operations; lab2_main
cd ../Lab3_LTI_Systems; lab3_main
cd ../Lab4_Fourier_Analysis; lab4_main

% Practice problems
cd ../Exam_Practice
edit template.m
```

---

## 📞 Need Help?

- **Theory questions:** Refer to `Lista1_Solutions.md`
- **Lab concepts:** Check relevant `Lab*_Guide.md`
- **MATLAB setup:** See `QUICK_START.md`
- **Formula lookup:** Open `Exam_Prep/README.md`
- **Practice structure:** Use `template.m`

---

**Good luck on both exams! 🚀**

*Everything you need is organized and ready to go!*
