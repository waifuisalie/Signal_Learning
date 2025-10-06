%% ============================================================================
%% LABORATÓRIO 3: SINAIS E SISTEMAS DISCRETOS (LTI)
%% ============================================================================
% Disciplina: Processamento Digital de Sinais
% Professor: Marcelo Eduardo Pellenz
% Alunos: Francisco Bley e Stefan Rodrigues
%
% OBJETIVO GERAL:
% Compreender sistemas LTI (Lineares e Invariantes no Tempo), convolução,
% decomposição par/ímpar, e implementação de filtros digitais.
%
% CONCEITOS-CHAVE:
% 1. SISTEMAS LTI são completamente caracterizados por h[n] (resposta ao impulso)
% 2. CONVOLUÇÃO: y[n] = x[n] * h[n] = Σ x[k]h[n-k]
% 3. EQUAÇÕES DE DIFERENÇA ↔ Função filter() do MATLAB
% 4. DECOMPOSIÇÃO PAR/ÍMPAR: x[n] = xe[n] + xo[n]
% 5. FILTROS: FIR (não-recursivo) vs IIR (recursivo)
%
% TEORIA FUNDAMENTAL:
% Sistema LTI: y[n] = T{x[n]}
%   - Linear: T{a*x1 + b*x2} = a*T{x1} + b*T{x2}
%   - Invariante: T{x[n-k]} = y[n-k]
%   - Completamente descrito por h[n] = T{δ[n]}
%   - Saída: y[n] = x[n] * h[n] (convolução)
%% ============================================================================

%% --- CONFIGURAÇÃO INICIAL ---
clear; clc; close all;

% Adicionar pasta Utilities ao path
addpath('../Utilities');

%% ============================================================================
%% EXERCÍCIO 1a: DECOMPOSIÇÃO PAR/ÍMPAR DE u[n] - u[n-10]
%% ============================================================================
% TEORIA: Qualquer sinal REAL pode ser decomposto em:
%   x[n] = xe[n] + xo[n]
%   onde:
%     xe[n] = [x[n] + x[-n]]/2  (Parte PAR: xe[-n] = xe[n])
%     xo[n] = [x[n] - x[-n]]/2  (Parte ÍMPAR: xo[-n] = -xo[n])
%
% FUNÇÃO: [xe, xo, m] = evenodd(x, n)
%   - Expande x[n] para incluir valores negativos (espelha)
%   - Calcula componentes par e ímpar
%   - Retorna suporte expandido m

%% --- Construção do Sinal: x[n] = u[n] - u[n-10] ---
% Este é um "pulso retangular" de duração 10 amostras

[x1, n1] = stepseq(0, -20, 20);      % u[n]
[x2_temp, n2] = stepseq(10, -20, 20); % u[n-10]
x2 = -x2_temp;                        % -u[n-10]

[x, n] = sigadd(x1, n1, x2, n2);      % x = u[n] - u[n-10]

% RESULTADO: x[n] = 1 para 0 ≤ n < 10, x[n] = 0 caso contrário

%% --- Decomposição ---
[xe, xo, m] = evenodd(x, n);

% INTERPRETAÇÃO:
% - xe[n]: componente simétrica em torno de n=0
% - xo[n]: componente antissimétrica em torno de n=0
% - Verificação: xe[n] + xo[n] = x[n] ✓

figure;
subplot(3,1,1);
stem(n, x);
title('Ex. 1a: Sinal x[n] = u[n] - u[n-10] (Pulso Retangular)');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
stem(m, xe);
title('Parte Par xe[n] = [x[n] + x[-n]]/2');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
stem(m, xo);
title('Parte Ímpar xo[n] = [x[n] - x[-n]]/2');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 1b: DECOMPOSIÇÃO PAR/ÍMPAR DE (0.8)^n
%% ============================================================================
% SINAL EXPONENCIAL DECRESCENTE

n = 0:20;
xn = (0.8).^n;

[xe, xo, m] = evenodd(xn, n);

% OBSERVAÇÃO:
% - Sinal original só existe para n ≥ 0
% - evenodd() espelha para n < 0 automaticamente
% - xe[n] é simétrico, xo[n] é antissimétrico

figure;
subplot(3,1,1);
stem(n, xn);
title('Ex. 1b: Sinal x[n] = (0.8)^n (Exponencial Decrescente)');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
stem(m, xe);
title('Parte Par xe[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
stem(m, xo);
title('Parte Ímpar xo[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 2c: CONVOLUÇÃO COM ÍNDICES COMEÇANDO EM ZERO
%% ============================================================================
% CONVOLUÇÃO MATEMÁTICA:
%   y[n] = x[n] * h[n] = Σ(k=-∞ a +∞) x[k] h[n-k]
%
% PROPRIEDADES:
%   1. Comutativa: x*h = h*x
%   2. Associativa: (x*h1)*h2 = x*(h1*h2)
%   3. Distributiva: x*(h1+h2) = x*h1 + x*h2
%   4. Comprimento: length(y) = length(x) + length(h) - 1
%
% INTERPRETAÇÃO FÍSICA:
%   - h[n] = resposta ao impulso do sistema
%   - x[n] = entrada
%   - y[n] = saída (soma ponderada de h's deslocados)
%
% MATLAB conv():
%   - Assume sinais começando em n=0
%   - Resultado também começa em n=0
%   - CUIDADO: Não preserva índices negativos!

%% --- Definição dos Sinais (ambos começam em n=0) ---
xn = [3, 11, 7, 0, -1, 4, 2];   % 7 elementos
N_xn = 0:6;

hn = [2, 3, 0, -5, 2, 1];       % 6 elementos
N_hn = 0:5;

%% --- Convolução usando conv() do MATLAB ---
yn = conv(xn, hn);

% CÁLCULO DOS ÍNDICES DE SAÍDA:
%   - Primeiro índice: N_xn(1) + N_hn(1) = 0 + 0 = 0
%   - Último índice: N_xn(end) + N_hn(end) = 6 + 5 = 11
%   - Duração: 7 + 6 - 1 = 12 amostras

ny = (N_xn(1)+N_hn(1)) : (N_xn(end)+N_hn(end));  % 0:11

% INTERPRETAÇÃO:
% y[0] = x[0]*h[0] = 3*2 = 6
% y[1] = x[0]*h[1] + x[1]*h[0] = 3*3 + 11*2 = 9 + 22 = 31
% y[2] = x[0]*h[2] + x[1]*h[1] + x[2]*h[0] = ...
% (e assim por diante)

figure;
subplot(3,1,1);
stem(N_xn, xn);
title('Ex. 2c: Entrada x[n] (7 amostras)');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
stem(N_hn, hn);
title('Resposta ao Impulso h[n] (6 amostras)');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
stem(ny, yn);
title('Saída y[n] = x[n]*h[n] (12 amostras)');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 3c: CONVOLUÇÃO COM ÍNDICES ARBITRÁRIOS
%% ============================================================================
% PROBLEMA: E se os sinais não começam em n=0?
%   Exemplo: x em [-3,3], h em [-1,4]
%   conv() do MATLAB não funciona corretamente!
%
% SOLUÇÃO: conv_m() - Convolução Modificada
%   [y, ny] = conv_m(x, nx, h, nh)
%
% CÁLCULO DOS ÍNDICES:
%   ny_início = nx(1) + nh(1)
%   ny_fim = nx(end) + nh(end)
%
% IMPLEMENTAÇÃO INTERNA:
%   y = conv(x, h)  (usa conv padrão)
%   ny = [nx(1)+nh(1) : nx(end)+nh(end)]  (ajusta índices)

%% --- Sinais com Índices Arbitrários ---
xn = [3, 11, 7, 0, -1, 4, 2];  % Mesmo vetor de amplitude
N_xn = -3:3;                    % MAS agora n vai de -3 a 3!

hn = [2, 3, 0, -5, 2, 1];
N_hn = -1:4;                    % h vai de -1 a 4

%% --- Convolução com conv_m() ---
[y, ny] = conv_m(xn, N_xn, hn, N_hn);

% CÁLCULO:
%   ny_início = (-3) + (-1) = -4
%   ny_fim = 3 + 4 = 7
%   ny = [-4 : 7]  (12 amostras)

% VERIFICAÇÃO:
% y[-4] = x[-3]*h[-1] = 3*2 = 6
% y[-3] = x[-3]*h[0] + x[-2]*h[-1] = 3*3 + 11*2 = 31
% (mesmo resultado que Ex 2c, mas com índices corretos!)

figure;
subplot(3,1,1);
stem(N_xn, xn);
title('Ex. 3c: Entrada x[n] com n \in [-3,3]');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
stem(N_hn, hn);
title('Resposta ao Impulso h[n] com n \in [-1,4]');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3,1,3);
stem(ny, y);
title('Saída y[n] com n \in [-4,7] (índices preservados!)');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 4a: RESPOSTA AO IMPULSO DE UM SISTEMA RECURSIVO
%% ============================================================================
% EQUAÇÃO DE DIFERENÇA:
%   y[n] - y[n-1] + 0.9*y[n-2] = x[n]
%
% REORGANIZANDO (forma explícita):
%   y[n] = x[n] + y[n-1] - 0.9*y[n-2]
%
% FUNÇÃO filter() DO MATLAB:
%   y = filter(b, a, x)
%
%   Implementa: a(1)*y[n] + a(2)*y[n-1] + ... = b(1)*x[n] + b(2)*x[n-1] + ...
%
% MAPEAMENTO PARA NOSSA EQUAÇÃO:
%   a(1)*y[n] + a(2)*y[n-1] + a(3)*y[n-2] = b(1)*x[n]
%   1*y[n] + (-1)*y[n-1] + 0.9*y[n-2] = 1*x[n]
%
%   Portanto:
%     a = [1, -1, 0.9]   (coeficientes do denominador / feedback)
%     b = [1]            (coeficientes do numerador / feedforward)
%
% ATENÇÃO: Sinais de a são INVERTIDOS na equação!
%   filter() faz: y[n] = b(1)*x[n] - a(2)*y[n-1] - a(3)*y[n-2]
%   Com a=[1,-1,0.9]: y[n] = x[n] - (-1)*y[n-1] - 0.9*y[n-2]
%                           = x[n] + y[n-1] - 0.9*y[n-2] ✓

%% --- Entrada: Impulso Unitário ---
[x, n] = impseq(0, -20, 120);  % δ[n]

%% --- Coeficientes do Sistema ---
a = [1, -1, 0.9];  % Denominador (feedback/recursivo)
b = [1];           % Numerador (feedforward/direto)

%% --- Calcular h[n] = Resposta ao Impulso ---
h = filter(b, a, x);

% INTERPRETAÇÃO:
%   h[n] é a "assinatura" do sistema
%   Qualquer saída y[n] pode ser calculada por: y = x * h

% ANÁLISE DO COMPORTAMENTO:
%   - Sistema de 2ª ordem (usa y[n-1] e y[n-2])
%   - IIR (Infinite Impulse Response) - h[n] não vai a zero rapidamente
%   - Pólos em z: 1 ± j√0.9 → oscilação amortecida

figure;
stem(n, h);
title('Ex. 4a: Resposta ao Impulso h[n] do Sistema Recursivo');
xlabel('n'); ylabel('h[n]'); grid on;

%% ============================================================================
%% EXERCÍCIO 4b: RESPOSTA AO DEGRAU DO SISTEMA
%% ============================================================================
% RESPOSTA AO DEGRAU s[n]: Saída quando x[n] = u[n]
%
% RELAÇÃO: s[n] = Σ(k=0 a n) h[k]  (soma acumulada de h[n])
%
% INTERPRETAÇÃO:
%   - h[n]: Resposta transitória
%   - s[n]: Comportamento em regime permanente
%   - lim(n→∞) s[n] = ganho DC do sistema

%% --- Entrada: Degrau Unitário ---
[x, n] = stepseq(0, -20, 120);  % u[n]

%% --- Coeficientes (mesmo sistema) ---
a = [1, -1, 0.9];
b = [1];

%% --- Calcular s[n] = Resposta ao Degrau ---
s = filter(b, a, x);

% ANÁLISE:
%   - s[0] = h[0] (primeiro valor)
%   - s[∞] → valor de regime (se sistema estável)
%   - Para este sistema: s[∞] ≈ 10 (valor final)

figure;
stem(n, s);
title('Ex. 4b: Resposta ao Degrau s[n] do Sistema');
xlabel('n'); ylabel('s[n]'); grid on;

%% ============================================================================
%% EXERCÍCIO 5: FILTRO DE MÉDIA MÓVEL (MOVING AVERAGE)
%% ============================================================================
% FILTRO FIR (NON-RECURSIVE):
%   y[n] = (1/M) * [x[n] + x[n-1] + ... + x[n-M+1]]
%
% COM M=10:
%   y[n] = (1/10) * Σ(k=0 a 9) x[n-k]
%
% COEFICIENTES:
%   b = [1/10, 1/10, ..., 1/10]  (10 elementos)
%   a = [1]                       (não-recursivo!)
%
% PROPRIEDADES:
%   - Filtro PASSA-BAIXAS (suaviza oscilações rápidas)
%   - Atraso de grupo: (M-1)/2 = 4.5 amostras
%   - Reduz ruído por média local
%   - Não tem feedback (FIR)

%% --- Geração do Sinal com Ruído ---
n = 0:100;
x_clean = 2*cos((pi/8).*n);      % Sinal limpo (cosseno)
noise = randn(1, length(n));     % Ruído branco gaussiano
x_noisy = x_clean + noise;       % Sinal + Ruído

%% --- Projeto do Filtro de Média Móvel ---
M = 10;                          % Janela de 10 amostras
b = (1/M) * ones(1, M);          % [0.1, 0.1, ..., 0.1]
a = [1];                         % Não-recursivo

%% --- Filtragem ---
y_filtered = filter(b, a, x_noisy);

% RESULTADO:
%   - Ruído reduzido (variação diminui)
%   - Sinal suavizado
%   - Pequeno atraso (deslocamento temporal)

figure;
plot(n, x_noisy, 'b-', 'DisplayName', 'Sinal Ruidoso'); hold on;
plot(n, y_filtered, 'r-', 'LineWidth', 2, 'DisplayName', 'Sinal Filtrado (M=10)');
plot(n, x_clean, 'g--', 'LineWidth', 1.5, 'DisplayName', 'Sinal Original (sem ruído)');
hold off;
title('Ex. 5: Filtro de Média Móvel (Redução de Ruído)');
xlabel('n'); ylabel('Amplitude'); legend; grid on;

%% ANÁLISE DA RESPOSTA EM FREQUÊNCIA:
% - Corta frequências altas (ruído)
% - Preserva frequências baixas (sinal útil)
% - Ganho DC: H(0) = 1 (passa componente constante)
% - Primeiro zero: f = Fs/M (rejeita essa frequência)

%% ============================================================================
%% DIAGRAMA DE BLOCOS DO SISTEMA (ASCII ART)
%% ============================================================================
% Para y[n] = x[n] + y[n-1] - 0.9*y[n-2]:
%
%        x[n] ──┬─────────────────────────(+)──> y[n]
%               │                          ↑
%               │                          │
%               │      ┌────┐    ┌────┐   │
%               └─────>│ +1 │───>│ z⁻¹│───┤
%                      └────┘    └────┘   │
%                                         │
%                      ┌─────┐  ┌────┐   │
%                      │-0.9 │<─│ z⁻¹│<──┘
%                      └─────┘  └────┘
%                         │
%                         └──────────────>(+)
%
% Legenda:
%   z⁻¹ = atraso de 1 amostra
%   (+) = somador
%   Ramos com ganhos: multiplicação

%% ============================================================================
%% RESUMO DO LABORATÓRIO 3
%% ============================================================================
fprintf('\n=== RESUMO: SISTEMAS LTI E CONVOLUÇÃO ===\n');
fprintf('CONCEITOS PRINCIPAIS:\n');
fprintf('  • Decomposição: x[n] = xe[n] + xo[n]\n');
fprintf('  • Convolução: y = x*h (comprimento = len(x)+len(h)-1)\n');
fprintf('  • conv(): Para sinais em n≥0\n');
fprintf('  • conv_m(): Para índices arbitrários\n');
fprintf('\n');
fprintf('FUNÇÃO filter(b,a,x):\n');
fprintf('  • b: coeficientes do numerador (feedforward)\n');
fprintf('  • a: coeficientes do denominador (feedback)\n');
fprintf('  • a(1) sempre = 1 (normalizado)\n');
fprintf('  • Sinais de a são INVERTIDOS na equação!\n');
fprintf('\n');
fprintf('TIPOS DE FILTRO:\n');
fprintf('  • FIR: a=[1], sem feedback, resposta finita\n');
fprintf('  • IIR: a com mais elementos, recursivo, resposta infinita\n');
fprintf('\n');
fprintf('RESPOSTA AO IMPULSO h[n]:\n');
fprintf('  • Caracteriza COMPLETAMENTE o sistema LTI\n');
fprintf('  • y[n] = x[n] * h[n] (convolução)\n');
fprintf('================================================\n\n');

%% ============================================================================
%% FIM DO LABORATÓRIO 3
%% ============================================================================
% NOTA: O exercício 4c (implementação em tempo real) está em arquivo separado:
%       lab3_realtime.m (usa input() interativo)
%
% PRÓXIMO PASSO:
% → Lab 4: Análise de Fourier e síntese de sinais periódicos
%% ============================================================================
