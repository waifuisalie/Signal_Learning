%% ============================================================================
%% LABORATÓRIO 1: REPRESENTAÇÃO DE SEQUÊNCIAS DISCRETAS
%% ============================================================================
% Disciplina: Processamento Digital de Sinais
% Professor: Marcelo E. Pellenz
% Alunos: Francisco e Stefan
%
% OBJETIVO GERAL:
% Compreender como representar e manipular sequências discretas no MATLAB,
% explorar conceitos de frequência normalizada, amostragem, e periodicidade
% de sinais discretos.
%
% CONCEITOS-CHAVE:
% 1. Sinais discretos são sequências de números indexados por inteiros
% 2. Frequência normalizada: ω = 2πf/Fs (rad/amostra)
% 3. Teorema de Nyquist: Fs ≥ 2*fmax para evitar aliasing
% 4. Periodicidade discreta: x[n+N] = x[n] se ω/(2π) = k/N (racional)
%% ============================================================================

%% --- CONFIGURAÇÃO INICIAL ---
clear;          % Limpa todas as variáveis do workspace
clc;            % Limpa a janela de comando
close all;      % Fecha todas as figuras abertas
fig_counter = 1; % Contador para numerar figuras automaticamente

%% ============================================================================
%% EXERCÍCIO 1: REPRESENTAÇÃO DE SEQUÊNCIAS DISCRETAS
%% ============================================================================
% CONCEITO FUNDAMENTAL:
% Em MATLAB, um sinal discreto x[n] é representado por DOIS vetores:
%   - x: vetor com as AMPLITUDES (valores do sinal)
%   - n: vetor com os ÍNDICES DE TEMPO (posições das amostras)
%
% Quando n contém valores negativos, é CRUCIAL saber onde n=0 está localizado!
% Exemplo: x = [3,0,2,1,5], n = [-2,-1,0,1,2]
%          O valor 2 (terceiro elemento de x) corresponde a n=0

%% --- Item 1a: Vetor com Índices Negativos ---
% SEQUÊNCIA: x[n] definida manualmente com n variando de -3 até 7
x = [3,0,2,1,5,7,0,0,1,1,10];
n = -3:7;  % Cria vetor [-3,-2,-1,0,1,2,3,4,5,6,7]

% ANÁLISE:
% - x tem 11 elementos, n tem 11 elementos ✓
% - n=0 está na posição 4 de x (o valor 1)
% - Esta representação permite operações de deslocamento temporal

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled','LineWidth',1.5);
title('Exercício 1a: Sequência Discreta com Índices Arbitrários');
xlabel('n (índice de tempo)');
ylabel('x[n] (amplitude)');
grid on;

%% --- Item 1b: Vetor Iniciando em n=0 ---
x = [-4,-3,-2,-1,0,1,2,3,4];
n = 0:8;  % Sequência começa em zero (mais comum em DSP)

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1b: Sequência Iniciando em n=0');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1c: IMPULSO UNITÁRIO δ[n] ---
% DEFINIÇÃO MATEMÁTICA:
%   δ[n] = 1, se n=0
%   δ[n] = 0, caso contrário
%
% IMPORTÂNCIA: É o sinal mais fundamental em DSP
%   - Resposta ao impulso h[n] caracteriza COMPLETAMENTE um sistema LTI
%   - Qualquer sinal pode ser decomposto como soma de impulsos deslocados

x = [0,0,0,1,0,0,0];
n = -3:3;

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1c: Impulso Unitário \delta[n]');
xlabel('n'); ylabel('\delta[n]'); grid on;

%% --- Item 1d: DEGRAU UNITÁRIO u[n] ---
% DEFINIÇÃO MATEMÁTICA:
%   u[n] = 1, se n ≥ 0
%   u[n] = 0, se n < 0
%
% RELAÇÃO COM IMPULSO:
%   u[n] = δ[n] + δ[n-1] + δ[n-2] + ... (soma acumulada de impulsos)
%   δ[n] = u[n] - u[n-1] (diferença de degraus)

x = ones(1,35);  % Vetor de 35 uns
n = 0:34;

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1d: Degrau Unitário u[n]');
xlabel('n'); ylabel('u[n]'); grid on;

%% --- Item 1e: Função Polinomial x[n] = n^2 ---
% INTERPRETAÇÃO: Sequência crescente parabolicamente
% Operador .^ : Potenciação elemento-por-elemento (operação vetorizada)

n = -10:10;
x = n.^2;  % Cada elemento de n é elevado ao quadrado

% OBSERVAÇÃO: A sequência é SIMÉTRICA (função par)
% Propriedade matemática: (-n)^2 = n^2  →  x[-n] = x[n]

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1e: x[n] = n^2 (Função Par)');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1f: EXPONENCIAL DECRESCENTE x[n] = (0.9)^n ---
% ANÁLISE DO COMPORTAMENTO:
%   - Para 0 < a < 1: sequência DECAI exponencialmente
%   - Para a > 1: sequência CRESCE exponencialmente
%   - Para a < 0: sequência OSCILA entre positivo/negativo
%
% APLICAÇÃO: Modela decaimento em sistemas físicos (RC circuits, reverb, etc.)

n = 0:30;
x = 0.9.^n;  % (0.9)^0 = 1, (0.9)^1 = 0.9, (0.9)^2 = 0.81, ...

% NOTA: Sequência começa em x[0]=1 e decai para ~0.04 em n=30

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1f: x[n] = (0.9)^n - Decaimento Exponencial');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1g: Função Exponencial com Módulo ---
% FUNÇÃO: x[n] = exp(|n|/4) = e^(|n|/4)
% COMPORTAMENTO: Cresce simetricamente para ambos os lados de n=0

n = -20:20;
x = exp(abs(n)/4);  % abs() retorna valor absoluto

% ANÁLISE:
% - Em n=0: x[0] = e^0 = 1
% - Em n=±20: x[±20] = e^5 ≈ 148.4
% - Função PAR: x[-n] = x[n]

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1h: x[n] = exp(|n|/4) - Crescimento Simétrico');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1h: FUNÇÃO SECCIONADA (Piecewise) ---
% DEFINIÇÃO:
%   x[n] = n-1,     se n < 3
%   x[n] = -3,      se 3 ≤ n < 6
%   x[n] = 5-n/3,   se n ≥ 6
%
% TÉCNICA: Usar indexação lógica do MATLAB

n = -15:15;
x = zeros(size(n));  % Inicializa com zeros

% Criar máscaras lógicas (vetores de true/false)
cond1 = (n < 3);           % true onde n < 3
cond2 = (n >= 3 & n < 6);  % true onde 3 ≤ n < 6
cond3 = (n >= 6);          % true onde n ≥ 6

% Atribuir valores usando indexação lógica
x(cond1) = n(cond1) - 1;      % Aplica fórmula onde cond1 é true
x(cond2) = -3;                 % Valor constante
x(cond3) = 5 - (n(cond3)/3);  % Decrescimento linear

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1h: Função Seccionada');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1i: Função Racional ---
% FUNÇÃO: x[n] = (n+1)/(n²+1)
% CUIDADO: Operadores ./ e .^ são essenciais para operações elemento-por-elemento

n = -15:15;
x = (n + 1) ./ (n.^2 + 1);  % ./ divide elemento-por-elemento

% ANÁLISE DO COMPORTAMENTO:
% - Em n=0: x[0] = 1/1 = 1 (máximo)
% - Para |n| grande: x[n] → 0 (denominador cresce mais rápido)
% - Assintoticamente tende a zero

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1i: x[n] = (n+1)/(n^2+1)');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1j: Função Seccionada com n ≥ 0 ---
% DEFINIÇÃO:
%   x[n] = n²-1,  se n ≥ 0
%   x[n] = 0,     caso contrário

n = -15:15;
x = zeros(size(n));
cond1 = n >= 0;
x(cond1) = n(cond1).^2 - 1;

% OBSERVAÇÃO: Função NÃO-CAUSAL (depende apenas de n ≥ 0)

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1j: x[n] = n^2-1 para n \geq 0');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 1k: Função Seccionada Bilateral ---
% DEFINIÇÃO:
%   x[n] = 1/(n+1),  se n ≥ 0
%   x[n] = 1/(1-n),  se n < 0

n = -15:15;
x = zeros(size(n));
cond1 = n >= 0;
cond2 = n < 0;
x(cond1) = 1./(n(cond1) + 1);  % Para n ≥ 0
x(cond2) = 1./(1 - n(cond2));  % Para n < 0

% ANÁLISE: Ambos os ramos decaem conforme |n| aumenta

figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled');
title('Exercício 1k: Função Seccionada Bilateral');
xlabel('n'); ylabel('x[n]'); grid on;


%% ============================================================================
%% EXERCÍCIO 2: SEQUÊNCIAS EXPONENCIAIS REAIS
%% ============================================================================
% FORMA GERAL: x[n] = k * a^n
%
% ANÁLISE DO PARÂMETRO 'a':
%   - Se 0 < a < 1: DECAIMENTO exponencial (estável)
%   - Se a = 1: CONSTANTE
%   - Se a > 1: CRESCIMENTO exponencial (instável)
%   - Se -1 < a < 0: Decaimento OSCILANTE
%   - Se a < -1: Crescimento OSCILANTE

%% --- Item 2a: Decaimento (a = 0.8 < 1) ---
N = 50;
n = 0:N-1;
x = (0.8).^n;

% INTERPRETAÇÃO:
% - Taxa de decaimento: 20% por amostra (multiplica por 0.8)
% - Em n=10: x[10] = 0.8^10 ≈ 0.107 (10.7% do valor inicial)
% - "Tempo de meia-vida": aproximadamente 3.1 amostras

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 2a: x[n] = (0.8)^n - Decaimento');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 2b: Crescimento (a = 1.5 > 1) ---
N = 20;  % Menos amostras para evitar overflow
n = 0:N-1;
x = (1.5).^n;

% INTERPRETAÇÃO:
% - Taxa de crescimento: 50% por amostra
% - Em n=10: x[10] = 1.5^10 ≈ 57.7
% - Sistema INSTÁVEL (cresce sem limite)

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 2b: x[n] = (1.5)^n - Crescimento Exponencial');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 2c: Crescimento Rápido (a = 2) ---
N = 200;
n = 0:N-1;
x = 0.5 * (2.^n);

% ATENÇÃO: Valores crescem MUITO rapidamente!
% - Em n=10: x[10] = 0.5 * 2^10 = 512
% - Em n=20: x[20] = 0.5 * 2^20 = 524,288
% - MATLAB pode ter overflow para n > ~50

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 2c: x[n] = 0.5 \cdot 2^n');
xlabel('n'); ylabel('x[n]'); grid on;

%% ============================================================================
%% EXERCÍCIO 3: SEQUÊNCIAS EXPONENCIAIS COMPLEXAS
%% ============================================================================
% FORMA GERAL: x[n] = e^((σ + jω)n) = e^(σn) * e^(jωn)
%                                    = e^(σn) * [cos(ωn) + j*sin(ωn)]
%
% COMPONENTES:
%   σ (sigma): Controla CRESCIMENTO/DECAIMENTO da amplitude
%   ω (omega): Controla FREQUÊNCIA de oscilação
%
% PROPRIEDADES:
%   - Parte Real: e^(σn) * cos(ωn)
%   - Parte Imaginária: e^(σn) * sin(ωn)
%   - Módulo: e^(σn) (envelope exponencial)
%   - Fase: ωn (crescimento linear)

%% --- Item 3a: σ=0.5, ω=π/6 (Crescimento Oscilante) ---
sigma = 0.5;
omega = pi/6;
N = 50;
n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);

% ANÁLISE:
% - σ > 0 → envelope CRESCE exponencialmente
% - ω = π/6 ≈ 0.524 rad/amostra → oscilação moderada
% - Período aproximado: 2π/ω = 12 amostras

figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3a: \sigma=0.5, \omega=\pi/6 (Crescimento Oscilante)')
subplot(2,2,1); stem(n,real(x),'filled');
title('Parte Real: e^{0.5n}cos(\pi n/6)');
xlabel('n'); ylabel('Re\{x[n]\}'); grid on;

subplot(2,2,2); stem(n,imag(x),'filled');
title('Parte Imaginária: e^{0.5n}sin(\pi n/6)');
xlabel('n'); ylabel('Im\{x[n]\}'); grid on;

subplot(2,2,3); stem(n,abs(x),'filled');
title('Módulo: e^{0.5n} (Envelope)');
xlabel('n'); ylabel('|x[n]|'); grid on;

subplot(2,2,4); stem(n,angle(x),'filled');
title('Fase: \omega n (rad)');
xlabel('n'); ylabel('\angle x[n]'); grid on;

%% --- Item 3b: σ=-0.5, ω=π/4 (Decaimento Oscilante) ---
sigma = -0.5;
omega = pi/4;
N = 30;
n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);

% ANÁLISE:
% - σ < 0 → envelope DECAI exponencialmente (ESTÁVEL)
% - ω = π/4 → oscilação mais rápida que 3a
% - Período: 2π/(π/4) = 8 amostras
% - Comportamento típico de sistemas amortecidos

figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3b: \sigma=-0.5, \omega=\pi/4 (Decaimento Oscilante)')
subplot(2,2,1); stem(n,real(x),'filled');
title('Parte Real'); xlabel('n'); ylabel('Re\{x[n]\}'); grid on;

subplot(2,2,2); stem(n,imag(x),'filled');
title('Parte Imaginária'); xlabel('n'); ylabel('Im\{x[n]\}'); grid on;

subplot(2,2,3); stem(n,abs(x),'filled');
title('Módulo (Decai)'); xlabel('n'); ylabel('|x[n]|'); grid on;

subplot(2,2,4); stem(n,angle(x),'filled');
title('Fase'); xlabel('n'); ylabel('\angle x[n]'); grid on;

%% --- Item 3c: σ=1, ω=π/4 (Crescimento Rápido) ---
sigma = 1;
omega = pi/4;
N = 100;
n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);

% ANÁLISE:
% - σ = 1 → crescimento MUITO rápido (e^n)
% - Envelope dobra a cada ~0.7 amostras
% - Sistema ALTAMENTE INSTÁVEL

figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3c: \sigma=1, \omega=\pi/4 (Crescimento Rápido)');
subplot(2,2,1); stem(n,real(x),'filled');
title('Parte Real'); xlabel('n'); ylabel('Re\{x[n]\}'); grid on;

subplot(2,2,2); stem(n,imag(x),'filled');
title('Parte Imaginária'); xlabel('n'); ylabel('Im\{x[n]\}'); grid on;

subplot(2,2,3); stem(n,abs(x),'filled');
title('Módulo (Cresce Rápido)'); xlabel('n'); ylabel('|x[n]|'); grid on;

subplot(2,2,4); stem(n,angle(x),'filled');
title('Fase'); xlabel('n'); ylabel('\angle x[n]'); grid on;

%% --- Item 3d: σ=0, ω=π/6 (Oscilação Pura - Senoidal) ---
sigma = 0;
omega = pi/6;
N = 60;
n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);

% ANÁLISE ESPECIAL:
% - σ = 0 → SEM crescimento/decaimento (envelope constante = 1)
% - x[n] = e^(jωn) = cos(ωn) + j*sin(ωn) (SENOIDE PURA)
% - Módulo CONSTANTE = 1 (movimento circular no plano complexo)
% - Este é o caso mais comum em análise de frequência!

figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3d: \sigma=0, \omega=\pi/6 (Senoide Pura)');
subplot(2,2,1); stem(n,real(x),'filled');
title('Parte Real: cos(\pi n/6)'); xlabel('n'); ylabel('Re\{x[n]\}'); grid on;

subplot(2,2,2); stem(n,imag(x),'filled');
title('Parte Imaginária: sin(\pi n/6)'); xlabel('n'); ylabel('Im\{x[n]\}'); grid on;

subplot(2,2,3); stem(n,abs(x),'filled');
title('Módulo = 1 (Constante!)'); xlabel('n'); ylabel('|x[n]|'); grid on;

subplot(2,2,4); stem(n,angle(x),'filled');
title('Fase: Rampa Linear'); xlabel('n'); ylabel('\angle x[n]'); grid on;


%% ============================================================================
%% EXERCÍCIO 4: DIGITALIZAÇÃO (AMOSTRAGEM) DE SINAIS ANALÓGICOS
%% ============================================================================
% PROCESSO DE AMOSTRAGEM:
%   Sinal analógico: x_a(t) = cos(2π f t)
%   Sinal amostrado:  x[n] = x_a(nT_s) = cos(2π f n/F_s) = cos(ω n)
%
% FREQUÊNCIA NORMALIZADA:
%   ω = 2πf/F_s  (rad/amostra)
%   - Elimina dependência de F_s nas equações
%   - Faixa útil: 0 ≤ ω ≤ π (acima de π ocorre aliasing)
%
% TEOREMA DE NYQUIST:
%   F_s ≥ 2*f_max  (para evitar aliasing)
%   - Frequência de Nyquist: f_N = F_s/2
%   - ω de Nyquist: ω_N = π rad/amostra

Fs = 200;  % Frequência de amostragem = 200 Hz
n = 0:20;  % 21 amostras

%% --- Item 4a: f = 10 Hz (Bem Abaixo de Nyquist) ---
f = 10;
omega = 2*pi*f / Fs;  % ω = 2π(10)/200 = π/10 rad/amostra
x = cos(omega * n);

% ANÁLISE:
% - f = 10 Hz << f_N = 100 Hz ✓ (sem aliasing)
% - ω = π/10 ≈ 0.314 rad/amostra (frequência BAIXA)
% - Período: N ≈ 20 amostras (bem amostrado)

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 4a: f = 10 Hz, \omega = \pi/10 (Bem Amostrado)');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 4b: f = 20 Hz ---
f = 20;
omega = 2*pi*f / Fs;  % ω = 2π(20)/200 = π/5 rad/amostra
x = cos(omega * n);

% ANÁLISE:
% - f = 20 Hz < f_N = 100 Hz ✓
% - ω = π/5 ≈ 0.628 rad/amostra
% - Período: N = 10 amostras

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 4b: f = 20 Hz, \omega = \pi/5');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 4c: f = 50 Hz (Metade de Nyquist) ---
f = 50;
omega = 2*pi*f / Fs;  % ω = 2π(50)/200 = π/2 rad/amostra
x = cos(omega * n);

% ANÁLISE:
% - f = 50 Hz = F_s/4 (ainda seguro)
% - ω = π/2 (frequência MÉDIA)
% - Período: N = 4 amostras

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 4c: f = 50 Hz, \omega = \pi/2');
xlabel('n'); ylabel('x[n]'); grid on;

%% --- Item 4d: f = 100 Hz (FREQUÊNCIA DE NYQUIST!) ---
f = 100;
omega = 2*pi*f / Fs;  % ω = 2π(100)/200 = π rad/amostra
x = cos(omega * n);

% ANÁLISE CRÍTICA:
% - f = 100 Hz = F_s/2 = f_N (LIMITE de Nyquist!)
% - ω = π rad/amostra (FREQUÊNCIA MÁXIMA representável)
% - Comportamento: alterna entre +1 e -1
% - cos(πn) = (-1)^n
% - Na prática: EVITAR amostrar exatamente em Nyquist (ambíguo)

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled');
title('Exercício 4d: f = 100 Hz (Nyquist), \omega = \pi');
xlabel('n'); ylabel('x[n]'); grid on;

%% ============================================================================
%% EXERCÍCIO 5: EXPLORAÇÃO DE FREQUÊNCIAS NORMALIZADAS E ALIASING
%% ============================================================================
% OBJETIVO: Visualizar o efeito de diferentes valores de ω
%
% PROPRIEDADES IMPORTANTES:
%   1. cos(ωn) é periódico se ω/(2π) = k/N (racional)
%   2. Frequências ω e ω+2πk produzem o MESMO sinal discreto (aliasing)
%   3. Faixa única: -π ≤ ω ≤ π (fora disso há redundância)
%   4. cos(ωn) = cos((2π-ω)n) (simetria em torno de π)

n = 0:40;
omega_values = [0, pi/4, 2*pi/4, 3*pi/4, 4*pi/4, 5*pi/4, 6*pi/4, 7*pi/4, 8*pi/4];

for omega = omega_values
    x = cos(omega * n);
    figure(fig_counter); fig_counter = fig_counter+1;
    stem(n, x, 'filled'); grid on;
    title(['\omega = ', num2str(omega/pi), '\pi rad/amostra']);
    xlabel('n'); ylabel('x[n]');

    % INTERPRETAÇÃO AUTOMÁTICA:
    if omega == 0
        disp('ω=0: SINAL CONSTANTE (DC, frequência zero)');
    elseif omega == pi
        disp('ω=π: OSCILAÇÃO MÁXIMA (alterna entre +1 e -1)');
    elseif omega > pi
        equiv = 2*pi - omega;
        fprintf('ω=%.2fπ: ALIASING! Equivalente a ω=%.2fπ\n', omega/pi, equiv/pi);
    end
end

%% --- Análise Detalhada do Exercício 5 ---
% CONCEITO DE FREQUÊNCIAS ALTAS/BAIXAS EM SINAIS DISCRETOS:
%
% • FREQUÊNCIA BAIXA (ω ≈ 0):
%   - Sequência varia LENTAMENTE
%   - Muitas amostras por ciclo
%   - Exemplo: ω = π/4 → período N = 8 amostras
%
% • FREQUÊNCIA ALTA (ω ≈ π):
%   - Sequência varia RAPIDAMENTE
%   - Poucas amostras por ciclo (mínimo: 2 amostras/ciclo)
%   - Exemplo: ω = 3π/4 → período N ≈ 2.67 amostras
%
% • ALIASING (REBATIMENTO):
%   - Frequências acima de π são INDISTINGUÍVEIS de frequências abaixo de π
%   - ω = 5π/4 PARECE ω = 3π/4  (rebate em torno de π)
%   - ω = 6π/4 PARECE ω = 2π/4  (mesmo sinal!)
%   - ω = 2π PARECE ω = 0      (volta ao DC!)
%
% TABELA DE CONVERSÃO PARA FREQUÊNCIA ANALÓGICA (Hz):
% Fórmula: f = (ω * Fs) / (2π)
%
% Para Fs = 8000 Hz:
%   ω = 0.25π  →  f = 1000 Hz
%   ω = 0.50π  →  f = 2000 Hz
%   ω = 0.75π  →  f = 3000 Hz
%   ω = 1.00π  →  f = 4000 Hz (Nyquist)
%   ω = 1.25π  →  f = 5000 Hz → ALIASING para 3000 Hz
%
% Para Fs = 16000 Hz:
%   ω = 0.25π  →  f = 2000 Hz
%   ω = 0.50π  →  f = 4000 Hz
%   ω = 0.75π  →  f = 6000 Hz
%   ω = 1.00π  →  f = 8000 Hz (Nyquist)
%   ω = 1.25π  →  f = 10000 Hz → ALIASING para 6000 Hz

%% ============================================================================
%% EXERCÍCIO 6: SOMA DE SENOIDES
%% ============================================================================
% SINAL: x[n] = 5*cos(0.5*π*n + π/4) + 2*sin(0.5*π*n)
%
% ANÁLISE DA COMPOSIÇÃO:
%   Termo 1: 5*cos(ωn + φ) com ω=π/2, φ=π/4, amplitude=5
%   Termo 2: 2*sin(ωn) com ω=π/2, amplitude=2
%
% FREQUÊNCIA COMUM: ω = π/2 rad/amostra
% - Período: N = 2π/ω = 4 amostras
% - Ambos os termos têm a MESMA frequência, mas fases diferentes
%
% IDENTIDADE ÚTIL: sin(x) = cos(x - π/2)
%   Então: 2*sin(π/2*n) = 2*cos(π/2*n - π/2)
%
% RESULTADO: Soma de cossenos com mesma frequência → outro cosseno!
%   (com amplitude e fase ajustadas)

n = -20:20;
termo_cos = 5 * cos(0.5 * pi * n + pi/4);
termo_sin = 2 * sin(0.5 * pi * n);
x = termo_cos + termo_sin;

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); grid on;
title('Exercício 6: Soma de Senoides com Mesma Frequência');
xlabel('n'); ylabel('x[n]');

% OBSERVAÇÃO: O resultado é periódico com período N=4 amostras

%% ============================================================================
%% EXERCÍCIO 7: ANÁLISE DE PERIODICIDADE EM SINAIS DISCRETOS
%% ============================================================================
% CRITÉRIO DE PERIODICIDADE:
%   x[n] = cos(ωn) é periódico SE E SOMENTE SE:
%
%   ω/(2π) = k/N  (k e N inteiros, k e N primos entre si)
%
%   Onde N é o período fundamental (menor N > 0 que satisfaz x[n+N] = x[n])
%
% TESTE PRÁTICO:
%   1. Calcular ω/(2π)
%   2. Verificar se resulta em fração RACIONAL (k/N)
%   3. Se SIM → periódico com período N
%   4. Se NÃO (irracional) → NÃO periódico

n = 0:30;

%% --- Item 7a: x[n] = cos(π/4 * n) ---
x_a = cos((pi/4) * n);

% TESTE DE PERIODICIDADE:
%   ω = π/4
%   ω/(2π) = (π/4)/(2π) = 1/8  ← RACIONAL! (k=1, N=8)
%
% CONCLUSÃO: PERIÓDICO com período N = 8 amostras
%   Verificação: x[0]=1, x[8]=cos(2π)=1 ✓

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x_a, 'filled'); grid on;
title('Exercício 7a: cos(\pi n/4) - PERIÓDICO (N=8)');
xlabel('n'); ylabel('x[n]');

%% --- Item 7b: x[n] = cos(3π/8 * n) ---
x_b = cos((3*pi/8) * n);

% TESTE DE PERIODICIDADE:
%   ω = 3π/8
%   ω/(2π) = (3π/8)/(2π) = 3/16  ← RACIONAL! (k=3, N=16)
%
% CONCLUSÃO: PERIÓDICO com período N = 16 amostras
%   Verificação: Em n=16, fase = 3π/8 * 16 = 6π = 3*(2π) ✓

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x_b, 'filled'); grid on;
title('Exercício 7b: cos(3\pi n/8) - PERIÓDICO (N=16)');
xlabel('n'); ylabel('x[n]');

%% --- Item 7c: x[n] = cos(n) ---
x_c = cos(n);

% TESTE DE PERIODICIDADE:
%   ω = 1 rad/amostra
%   ω/(2π) = 1/(2π) ≈ 0.159155...  ← IRRACIONAL!
%
% CONCLUSÃO: NÃO PERIÓDICO
%   - O sinal NUNCA se repete exatamente
%   - Valores aparecem quase-periódicos (mas não exatamente)
%   - Este é um exemplo de sequência APERIÓDICA

figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x_c, 'filled'); grid on;
title('Exercício 7c: cos(n) - NÃO PERIÓDICO (1/2\pi irracional)');
xlabel('n'); ylabel('x[n]');

%% --- RESUMO DA ANÁLISE DE PERIODICIDADE ---
fprintf('\n=== RESUMO: PERIODICIDADE EM SINAIS DISCRETOS ===\n');
fprintf('7a: ω/(2π) = 1/8 (racional)   → PERIÓDICO, N=8\n');
fprintf('7b: ω/(2π) = 3/16 (racional)  → PERIÓDICO, N=16\n');
fprintf('7c: ω/(2π) = 1/2π (irracional) → NÃO PERIÓDICO\n');
fprintf('================================================\n\n');

%% ============================================================================
%% FIM DO LABORATÓRIO 1
%% ============================================================================
% CONCEITOS APRENDIDOS:
% ✓ Representação de sequências discretas (vetores x e n)
% ✓ Impulso δ[n] e degrau u[n]
% ✓ Exponenciais reais e complexas
% ✓ Amostragem e frequência normalizada ω = 2πf/Fs
% ✓ Teorema de Nyquist e aliasing
% ✓ Periodicidade em sinais discretos (teste ω/(2π) racional)
%
% PRÓXIMOS PASSOS:
% → Lab 2: Operações com sinais (shift, fold, add, multiply)
% → Lab 3: Sistemas LTI e convolução
% → Lab 4: Análise espectral com Fourier
%% ============================================================================
