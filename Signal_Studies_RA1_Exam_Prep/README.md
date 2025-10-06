# 📚 Signal Studies RA1 - Exam Preparation Guide

**Preparação Completa para Prova de Laboratório de Processamento Digital de Sinais**

---

## 📋 Índice

1. [Visão Geral](#visão-geral)
2. [Estrutura do Repositório](#estrutura-do-repositório)
3. [Guia Rápido de Uso](#guia-rápido-de-uso)
4. [Referência Rápida de Funções](#referência-rápida-de-funções)
5. [Fórmulas Essenciais](#fórmulas-essenciais)
6. [Mapa de Conceitos](#mapa-de-conceitos)
7. [Padrões Comuns de Exame](#padrões-comuns-de-exame)
8. [Troubleshooting](#troubleshooting)

---

## 🎯 Visão Geral

Este repositório contém **4 laboratórios completamente documentados** para preparação do exame RA1 de Processamento Digital de Sinais. Todos os scripts foram aprimorados com:

- ✅ **Comentários explicativos detalhados** (2-3x mais que originais)
- ✅ **Teoria completa embutida** nos scripts
- ✅ **Interpretação física** de cada operação
- ✅ **Exemplos passo-a-passo** de cálculos
- ✅ **Pronto para MATLAB Online** (drag-and-drop)

---

## 📂 Estrutura do Repositório

```
Signal_Studies_RA1_Exam_Prep/
│
├── 📄 README.md                    # Este arquivo (guia completo)
├── 📄 QUICK_START.md               # Instruções rápidas de setup
│
├── 📂 Utilities/                   # Funções compartilhadas
│   ├── impseq.m                   # Gera impulso δ[n-n0]
│   ├── stepseq.m                  # Gera degrau u[n-n0]
│   ├── sigadd.m                   # Soma sinais
│   ├── sigmult.m                  # Multiplica sinais
│   ├── sigshift.m                 # Desloca no tempo
│   ├── sigfold.m                  # Rebate x[n] → x[-n]
│   ├── evenodd.m                  # Decomposição par/ímpar
│   └── conv_m.m                   # Convolução modificada
│
├── 📂 Lab1_Discrete_Sequences/
│   ├── lab1_main.m                # Representação de sequências
│   └── Lab1_Guide.md              # Guia de estudo do Lab 1
│
├── 📂 Lab2_Signal_Operations/
│   ├── lab2_main.m                # Operações com sinais
│   └── Lab2_Guide.md              # Guia de estudo do Lab 2
│
├── 📂 Lab3_LTI_Systems/
│   ├── lab3_main.m                # Sistemas e convolução
│   ├── lab3_realtime.m            # Implementação em tempo real
│   └── Lab3_Guide.md              # Guia de estudo do Lab 3
│
├── 📂 Lab4_Fourier_Analysis/
│   ├── lab4_main.m                # Análise de Fourier
│   └── Lab4_Guide.md              # Guia de estudo do Lab 4
│
└── 📂 Exam_Practice/
    └── template.m                  # Template para exercícios
```

---

## 🚀 Guia Rápido de Uso

### **Opção 1: MATLAB Desktop**
```matlab
% 1. Navegue até a pasta raiz
cd Signal_Studies_RA1_Exam_Prep

% 2. Adicione Utilities ao path
addpath('Utilities')

% 3. Navegue para qualquer lab e execute
cd Lab1_Discrete_Sequences
lab1_main
```

### **Opção 2: MATLAB Online**
1. Faça upload da pasta `Signal_Studies_RA1_Exam_Prep/` completa
2. Execute `addpath('Utilities')` no Command Window
3. Navegue para qualquer lab e execute o script

**Veja [QUICK_START.md](QUICK_START.md) para instruções detalhadas**

---

## 📖 Referência Rápida de Funções

### **Funções Customizadas (Utilities/)**

| Função | Sintaxe | Descrição | Uso Típico |
|--------|---------|-----------|------------|
| **impseq** | `[x,n] = impseq(n0, n1, n2)` | Gera δ[n-n0] para n∈[n1,n2] | `[x,n] = impseq(4, -20, 20)` → δ[n-4] |
| **stepseq** | `[x,n] = stepseq(n0, n1, n2)` | Gera u[n-n0] para n∈[n1,n2] | `[x,n] = stepseq(0, -20, 20)` → u[n] |
| **sigadd** | `[y,n] = sigadd(x1,n1,x2,n2)` | Soma sinais com suportes diferentes | Alinha e soma automaticamente |
| **sigmult** | `[y,n] = sigmult(x1,n1,x2,n2)` | Multiplica sinais elemento-a-elemento | Janelamento, modulação |
| **sigshift** | `[y,n] = sigshift(x,m,k)` | Desloca: y[n] = x[n-k] | k>0: atraso, k<0: avanço |
| **sigfold** | `[y,n] = sigfold(x,n)` | Rebate: y[n] = x[-n] | Reflexão temporal |
| **evenodd** | `[xe,xo,m] = evenodd(x,n)` | Decompõe em par + ímpar | Análise de simetria |
| **conv_m** | `[y,ny] = conv_m(x,nx,h,nh)` | Convolução com índices arbitrários | Quando sinais não começam em n=0 |

### **Funções MATLAB Built-in Importantes**

| Função | Sintaxe | Uso no Curso |
|--------|---------|--------------|
| **filter** | `y = filter(b,a,x)` | Implementa equações de diferença: `a(1)y[n] + a(2)y[n-1] + ... = b(1)x[n] + ...` |
| **conv** | `y = conv(x,h)` | Convolução (assume n≥0, usa `conv_m` para outros casos) |
| **fft** | `Y = fft(x)` | Transformada rápida de Fourier |
| **abs** | `magnitude = abs(X)` | Magnitude de sinal complexo |
| **angle** | `phase = angle(X)` | Fase de sinal complexo (rad) |

---

## 🧮 Fórmulas Essenciais

### **Lab 1: Fundamentos**

#### **Frequência Normalizada**
```
ω = 2πf/Fs  (rad/amostra)

Faixa útil: 0 ≤ ω ≤ π
Nyquist: ω_N = π → f_N = Fs/2
```

#### **Periodicidade Discreta**
```
x[n] = cos(ωn) é periódico ⟺ ω/(2π) = k/N (racional)

Onde N = período fundamental (amostras)
```

#### **Teorema de Nyquist**
```
Fs ≥ 2·fmax  (para evitar aliasing)
```

### **Lab 2: Operações**

#### **Deslocamento Temporal**
```
y[n] = x[n-k]:  k > 0 → ATRASO (shift direita)
                k < 0 → AVANÇO (shift esquerda)

Com sigshift(x,m,k): n_novo = m + k
```

#### **Rebatimento**
```
y[n] = x[-n]
```

#### **Decomposição Par/Ímpar**
```
xe[n] = [x[n] + x[-n]]/2  (parte par)
xo[n] = [x[n] - x[-n]]/2  (parte ímpar)

x[n] = xe[n] + xo[n]
```

### **Lab 3: Sistemas LTI**

#### **Convolução**
```
y[n] = x[n] * h[n] = Σ x[k]h[n-k]
                    k

Comprimento: length(y) = length(x) + length(h) - 1
```

#### **Equação de Diferença ↔ filter()**
```
Equação: y[n] + a₁y[n-1] + a₂y[n-2] = b₀x[n] + b₁x[n-1]

MATLAB:  filter([b₀,b₁], [1,a₁,a₂], x)

ATENÇÃO: Sinais de 'a' são INVERTIDOS!
```

#### **Média Móvel (M pontos)**
```
y[n] = (1/M)·Σ x[n-k]  (k=0 até M-1)
      k

filter((1/M)*ones(1,M), [1], x)
```

### **Lab 4: Fourier**

#### **Série de Fourier - Onda Quadrada**
```
x(t) = (4/π)·Σ [sin(2πkFt)/k]  para k = 1,3,5,7,... (ÍMPARES)
            k
```

#### **Série de Fourier - Onda Triangular**
```
x(t) = (8/π²)·Σ [(-1)^((k-1)/2)·sin(2πkFt)/k²]  (k ÍMPAR)
             k
```

#### **Série de Fourier - Dente de Serra**
```
x(t) = (2/π)·Σ [sin(2πkFt)/k]  para k = 1,2,3,4,... (TODOS)
            k
```

#### **FFT - Espectro Unilateral**
```matlab
L = length(x);
Y = fft(x);
P2 = abs(Y/L);              % Espectro bilateral
P1 = P2(1:floor(L/2)+1);    % Metade positiva
P1(2:end-1) = 2*P1(2:end-1); % Dobra (exceto DC e Nyquist)
f = Fs*(0:floor(L/2))/L;    % Eixo de frequências
```

---

## 🗺️ Mapa de Conceitos

### **Progressão dos Labs**

```
LAB 1: FUNDAMENTOS
├─ Representação de sinais discretos (x, n)
├─ Amostragem e frequência normalizada
├─ Periodicidade
└─ Aliasing

        ↓

LAB 2: OPERAÇÕES
├─ Impulso e degrau (impseq, stepseq)
├─ Adição e multiplicação (sigadd, sigmult)
├─ Deslocamento temporal (sigshift)
├─ Rebatimento (sigfold)
└─ Operações combinadas

        ↓

LAB 3: SISTEMAS LTI
├─ Decomposição par/ímpar (evenodd)
├─ Convolução (conv, conv_m)
├─ Resposta ao impulso h[n]
├─ filter() e equações de diferença
└─ Filtros FIR e IIR

        ↓

LAB 4: ANÁLISE ESPECTRAL
├─ Série de Fourier (síntese)
├─ Harmônicos e convergência
├─ FFT (análise)
└─ Interpretação de espectros
```

### **Hierarquia de Conceitos**

```
SISTEMAS LTI
├─ Caracterização completa por h[n]
├─ y[n] = x[n] * h[n]  (convolução)
├─ Equações de diferença
│   ├─ FIR: sem feedback (a = [1])
│   └─ IIR: com feedback (a tem mais elementos)
└─ Análise
    ├─ Tempo: h[n], resposta ao impulso
    └─ Frequência: H(e^jω), resposta em frequência
```

---

## 🎯 Padrões Comuns de Exame

### **Tipo 1: Operações Multi-Etapa**

**Exemplo:** *Dado x[n] = {1,2,3} em n∈[0,2], calcule y[n] = 2x[n-1] + x[-n+2]*

**Estratégia:**
1. Calcular x[n-1] usando `sigshift(x, n, 1)`
2. Calcular x[-n] usando `sigfold(x, n)`
3. Calcular x[-n+2] usando `sigshift(x_folded, n_folded, 2)`
4. Multiplicar e somar usando `sigmult` e `sigadd`

### **Tipo 2: Análise de Sistemas**

**Exemplo:** *Sistema h[n] satisfaz y[n] - 0.5y[n-1] = x[n] + x[n-1]. Encontre h[n] e calcule saída para x[n] = δ[n]*

**Estratégia:**
1. Identificar coeficientes: `a = [1, -0.5]`, `b = [1, 1]`
2. Criar impulso: `[x,n] = impseq(0, 0, 50)`
3. Calcular h[n]: `h = filter(b, a, x)`
4. Para qualquer x, calcular y: `y = conv_m(x, nx, h, nh)`

### **Tipo 3: Análise Espectral**

**Exemplo:** *Sintetize onda quadrada F=100Hz com 10 harmônicos, calcule FFT*

**Estratégia:**
1. Definir parâmetros: `F=100`, `Fs=8000`, `t=0:1/Fs:0.1`
2. Loop: `for k=1:2:19, y = y + (4/pi)*(1/k)*sin(2*pi*k*F*t); end`
3. FFT: `Y = fft(y); P = abs(Y/length(y)); plot espectro`

### **Tipo 4: Amostragem e Aliasing**

**Exemplo:** *Sinal cos(2π·300t) amostrado a Fs=500Hz. Qual frequência aparente?*

**Estratégia:**
1. Verificar Nyquist: `fN = Fs/2 = 250Hz` → `300 > 250` (ALIASING!)
2. Calcular alias: `f_alias = |300 - Fs| = |300 - 500| = 200Hz`
3. Ou: `f_alias = Fs - 300 = 200Hz`

### **Tipo 5: Periodicidade**

**Exemplo:** *x[n] = cos(0.3πn) é periódico? Se sim, qual período?*

**Estratégia:**
1. Calcular `ω/(2π) = 0.3π/(2π) = 0.15 = 15/100 = 3/20`
2. Racional! (k=3, N=20)
3. Resposta: Periódico com N=20 amostras

---

## 🔧 Troubleshooting

### **Problema: "Index exceeds array bounds"**

**Causa:** Índices de tempo não alinhados

**Solução:**
```matlab
% ❌ ERRADO
y = x1 + x2  % Não funciona se n1 ≠ n2

% ✅ CORRETO
[y,n] = sigadd(x1, n1, x2, n2)  % Alinha automaticamente
```

### **Problema: Convolução com índices errados**

**Causa:** Usando `conv()` com sinais que não começam em n=0

**Solução:**
```matlab
% Se sinais têm índices arbitrários:
[y, ny] = conv_m(x, nx, h, nh)

% ny_início = nx(1) + nh(1)
% ny_fim = nx(end) + nh(end)
```

### **Problema: filter() dá resultado estranho**

**Causa:** Coeficientes `a` com sinais errados

**Lembre-se:**
```matlab
% Equação: y[n] + 0.5y[n-1] = x[n]
% Reorganizando: y[n] = x[n] - 0.5y[n-1]

% ❌ ERRADO: a = [1, 0.5]
% ✅ CORRETO: a = [1, -0.5]

% filter() faz: y[n] = b(1)*x[n] - a(2)*y[n-1]
```

### **Problema: FFT não mostra picos esperados**

**Causa:** Resolução em frequência insuficiente

**Solução:**
```matlab
% Aumentar duração do sinal (mais períodos)
% Ou fazer zero-padding:
x_padded = [x, zeros(1, 1000)];
```

### **Problema: Espectro tem valores estranhos**

**Causa:** Esqueceu de normalizar ou converter para unilateral

**Solução:** Use a função `plot_spectrum` do Lab 4 (já faz tudo certo)

---

## 📚 Recursos Adicionais

### **Guias Específicos por Lab**
- [Lab1_Guide.md](Lab1_Discrete_Sequences/Lab1_Guide.md) - Sequências discretas
- [Lab2_Guide.md](Lab2_Signal_Operations/Lab2_Guide.md) - Operações com sinais
- [Lab3_Guide.md](Lab3_LTI_Systems/Lab3_Guide.md) - Sistemas LTI
- [Lab4_Guide.md](Lab4_Fourier_Analysis/Lab4_Guide.md) - Análise de Fourier

### **Prática**
- Use `Exam_Practice/template.m` para resolver problemas
- Modifique os labs para testar variações

### **Dicas de Estudo**

1. **Entenda as funções customizadas** - São diferentes das built-in!
2. **Trace operações complexas passo-a-passo** - Ex: Lab 2, Exercício 7c
3. **Decore fórmulas de Fourier** - Quadrada, triangular, dente de serra
4. **Pratique filter()** - Mapear equações ↔ coeficientes
5. **Simule no MATLAB** - Ver é aprender!

---

## ✅ Checklist de Preparação

- [ ] Revisei todos os 4 labs
- [ ] Entendo todas as 8 funções customizadas
- [ ] Sei mapear equação de diferença → filter(b,a,x)
- [ ] Sei calcular convolução (manual e com funções)
- [ ] Decore fórmulas de Fourier (3 formas de onda)
- [ ] Sei interpretar espectro FFT
- [ ] Entendo aliasing e Nyquist
- [ ] Sei testar periodicidade (ω/(2π) racional?)
- [ ] Pratiquei problemas combinados
- [ ] Tenho este repositório no MATLAB Online pronto

---

## 📞 Suporte

Se encontrar problemas:
1. Verifique o guia específico do lab
2. Consulte a seção Troubleshooting acima
3. Releia os comentários nos scripts (têm muita explicação!)

---

**Boa sorte na prova! 🚀**

*Lembre-se: O exame testará sua capacidade de COMBINAR conceitos. Este repositório tem tudo que você precisa!*
