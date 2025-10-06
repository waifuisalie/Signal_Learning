%% ============================================================================
%% LABORATÓRIO 2: OPERAÇÕES COM SEQUÊNCIAS DISCRETAS
%% ============================================================================
% Disciplina: Processamento Digital de Sinais
% Professor: Marcelo Eduardo Pellenz
% Alunos: Francisco Bley e Stefan Rodrigues
%
% OBJETIVO GERAL:
% Dominar operações fundamentais em sinais discretos usando funções
% customizadas que preservam índices de tempo arbitrários.
%
% OPERAÇÕES PRINCIPAIS:
% 1. Geração de impulsos e degraus (impseq, stepseq)
% 2. Adição de sinais (sigadd)
% 3. Multiplicação de sinais (sigmult)
% 4. Deslocamento temporal (sigshift)
% 5. Rebatimento/reflexão (sigfold)
% 6. Combinações complexas de operações
%
% POR QUE FUNÇÕES CUSTOMIZADAS?
% - MATLAB built-in assume índices começando em 1
% - DSP usa índices arbitrários (negativos, zero, positivos)
% - Operações de shift/fold requerem controle preciso dos índices
% - Nossas funções preservam o suporte temporal correto
%% ============================================================================

%% --- CONFIGURAÇÃO INICIAL ---
clear; clc; close all;

% IMPORTANTE: Adicionar pasta Utilities ao path do MATLAB
% Se você estiver na pasta Lab2_Signal_Operations:
addpath('../Utilities');

%% ============================================================================
%% EXERCÍCIO 1: GERAÇÃO DA FUNÇÃO IMPULSO UNITÁRIO
%% ============================================================================
% FUNÇÃO: [x,n] = impseq(n0, n1, n2)
%
% SINTAXE:
%   n0 = posição do impulso (onde δ[n-n0] = 1)
%   n1 = início do intervalo de tempo
%   n2 = fim do intervalo de tempo
%
% RETORNA:
%   x = vetor com 1 na posição correspondente a n=n0, resto zeros
%   n = vetor de índices de n1 até n2
%
% IMPLEMENTAÇÃO INTERNA: x = [(n-n0) == 0]
%   Cria vetor lógico: true onde n=n0, false caso contrário
%   Convertido para 1 e 0 automaticamente

%% --- Item 1a: δ[n] (Impulso na Origem) ---
[x_a, n_a] = impseq(0, -20, 20);

% INTERPRETAÇÃO:
% - Impulso posicionado em n=0
% - Intervalo: -20 ≤ n ≤ 20 (41 amostras)
% - Apenas x[0] = 1, resto = 0

figure;
stem(n_a, x_a, 'filled');
title('1(a): Impulso Unitário x[n] = \delta[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% --- Item 1b: δ[n-4] (Impulso Deslocado à Direita) ---
[x_b, n_b] = impseq(4, -20, 20);

% INTERPRETAÇÃO:
% - δ[n-4] significa: "impulso que ocorre quando n-4=0, ou seja, em n=4"
% - REGRA MENTAL: δ[n-k] → impulso em n=k (atraso)
% - Apenas x[4] = 1, resto = 0

figure;
stem(n_b, x_b, 'filled');
title('1(b): Impulso Unitário x[n] = \delta[n-4] (Atraso de 4)');
xlabel('n'); ylabel('Amplitude'); grid on;

%% --- Item 1c: δ[n+8] (Impulso Deslocado à Esquerda) ---
[x_c, n_c] = impseq(-8, -20, 20);

% INTERPRETAÇÃO:
% - δ[n+8] = δ[n-(-8)] → impulso em n=-8
% - REGRA MENTAL: δ[n+k] → impulso em n=-k (avanço)
% - Apenas x[-8] = 1, resto = 0

figure;
stem(n_c, x_c, 'filled');
title('1(c): Impulso Unitário x[n] = \delta[n+8] (Avanço de 8)');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 2: GERAÇÃO DA FUNÇÃO DEGRAU UNITÁRIO
%% ============================================================================
% FUNÇÃO: [x,n] = stepseq(n0, n1, n2)
%
% SINTAXE: Similar a impseq, mas gera degrau u[n-n0]
%
% IMPLEMENTAÇÃO INTERNA: x = [(n-n0) >= 0]
%   Retorna 1 onde n ≥ n0, 0 caso contrário

%% --- Item 2a: u[n] (Degrau na Origem) ---
[x_a, n_a] = stepseq(0, -20, 20);

% INTERPRETAÇÃO:
% - u[n] = 0 para n < 0
% - u[n] = 1 para n ≥ 0
% - Transição em n=0

figure;
stem(n_a, x_a, 'filled');
title('2(a): Degrau Unitário x[n] = u[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% --- Item 2b: u[n-4] (Degrau Atrasado) ---
[x_b, n_b] = stepseq(4, -20, 20);

% INTERPRETAÇÃO:
% - u[n-4] = 0 para n < 4
% - u[n-4] = 1 para n ≥ 4
% - REGRA: u[n-k] ativa em n=k (mesma lógica do impulso)

figure;
stem(n_b, x_b, 'filled');
title('2(b): Degrau Unitário x[n] = u[n-4] (Ativa em n=4)');
xlabel('n'); ylabel('Amplitude'); grid on;

%% --- Item 2c: u[n+5] (Degrau Avançado) ---
[x_c, n_c] = stepseq(-5, -20, 20);

% INTERPRETAÇÃO:
% - u[n+5] = u[n-(-5)] → ativa em n=-5
% - Degrau "começa mais cedo"

figure;
stem(n_c, x_c, 'filled');
title('2(c): Degrau Unitário x[n] = u[n+5] (Ativa em n=-5)');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 3: ADIÇÃO DE SINAIS
%% ============================================================================
% FUNÇÃO: [y,n] = sigadd(x1, n1, x2, n2)
%
% DESAFIO: Sinais podem ter SUPORTES TEMPORAIS DIFERENTES!
%   x1 definido em n1 = [-3, 7]
%   x2 definido em n2 = [0, 8]
%   Como somá-los?
%
% SOLUÇÃO DA FUNÇÃO:
%   1. Cria nova base temporal: n = [min(n1,n2), max(n1,n2)]
%   2. Expande x1 e x2 para essa base (preenche com zeros)
%   3. Soma elemento-por-elemento
%
% EXEMPLO: Se x1 existe em n∈[-3,7] e x2 em n∈[0,8]
%   → y existirá em n∈[-3,8] (união dos intervalos)

%% --- Definição dos Sinais ---
x1 = [3, 0, 2, 1, 5, 7, 0, 0, 1, 1, 10];
n1 = -3:7;  % 11 elementos: de -3 até 7

x2 = [-4, -3, -2, -1, 0, 1, 2, 3, 4];
n2 = 0:8;   % 9 elementos: de 0 até 8

% OBSERVAÇÃO IMPORTANTE:
% - x1 tem valores em n∈[-3,-2,-1,0,1,2,3,4,5,6,7]
% - x2 tem valores em n∈[0,1,2,3,4,5,6,7,8]
% - Região de sobreposição: n∈[0,7] (ambos têm valores)
% - Fora da sobreposição: só um sinal contribui

%% --- Adição dos Sinais ---
[y, n] = sigadd(x1, n1, x2, n2);

% RESULTADO:
% - y definido em n∈[-3,8] (12 elementos)
% - Em n∈[-3,-1]: y = x1 (x2 não existe lá, assume 0)
% - Em n∈[0,7]: y = x1 + x2 (sobreposição)
% - Em n=8: y = x2 (x1 terminou em n=7)

%% --- Visualização ---
figure;
subplot(3, 1, 1);
stem(n1, x1, 'filled');
title('Sinal x_1[n] (suporte: n \in [-3,7])');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3, 1, 2);
stem(n2, x2, 'filled');
title('Sinal x_2[n] (suporte: n \in [0,8])');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3, 1, 3);
stem(n, y, 'filled', 'r');
title('Sinal Resultante y[n] = x_1[n] + x_2[n] (suporte: n \in [-3,8])');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 4: MULTIPLICAÇÃO DE SINAIS
%% ============================================================================
% FUNÇÃO: [y,n] = sigmult(x1, n1, x2, n2)
%
% LÓGICA: Idêntica a sigadd, mas usa multiplicação elemento-por-elemento
%
% DIFERENÇA IMPORTANTE:
%   - Adição: y = x1 + x2 (fora da sobreposição: y = x1 ou x2)
%   - Multiplicação: y = x1 .* x2 (fora da sobreposição: y = 0!)
%
% INTERPRETAÇÃO: Multiplicação é como "mascaramento" ou "janelamento"
%   - Só há saída onde AMBOS os sinais existem
%   - Usado em modulação, windowing, etc.

%% --- Multiplicação dos Mesmos Sinais do Exercício 3 ---
[y, n] = sigmult(x1, n1, x2, n2);

% ANÁLISE:
% - y definido em n∈[-3,8] (mesmo suporte da adição)
% - MAS: y=0 em n∈[-3,-1] (x2 não existe, multiplica por 0)
% - y=0 em n=8 (x1 não existe, multiplica por 0)
% - Valores não-zero APENAS em n∈[0,7] (região de sobreposição)

%% --- Visualização ---
figure;
subplot(3, 1, 1);
stem(n1, x1, 'filled');
title('Sinal x_1[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3, 1, 2);
stem(n2, x2, 'filled');
title('Sinal x_2[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

subplot(3, 1, 3);
stem(n, y, 'filled', 'r');
title('Sinal Resultante y[n] = x_1[n] \cdot x_2[n] (zeros fora de [0,7])');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% EXERCÍCIO 5: DESLOCAMENTO NO TEMPO (TIME SHIFTING)
%% ============================================================================
% FUNÇÃO: [y,n] = sigshift(x, m, k)
%
% SINTAXE:
%   x = sinal original (amplitudes)
%   m = índices originais de x
%   k = quantidade de deslocamento
%
% OPERAÇÃO: y[n] = x[n-k]
%   - k > 0 → ATRASO (shift para DIREITA)
%   - k < 0 → AVANÇO (shift para ESQUERDA)
%
% IMPLEMENTAÇÃO: n = m + k
%   - Não altera amplitudes! Só desloca os índices
%   - Exemplo: se m=[-3:7] e k=4 → n=[1:11]
%
% MNEMÔNICA IMPORTANTE:
%   y[n] = x[n-4] significa: "para calcular y agora (n), use x de 4 passos ATRÁS"
%   → O sinal APARECE MAIS TARDE → shift para DIREITA

%% --- Sinal Base ---
x_base = [3, 0, 2, 1, 5, 7, 0, 0, 1, 1, 10];
m = -3:7;  % Índices originais

%% --- Item 5a: y[n] = x[n-4] (ATRASO de 4 Amostras) ---
[ya, na] = sigshift(x_base, m, 4);

% ANÁLISE:
%   - Índices originais: m = [-3,-2,...,7]
%   - k = 4 (positivo)
%   - Novos índices: na = m+4 = [1,2,...,11]
%   - O sinal "se move para a direita" 4 posições
%   - Exemplo: valor que estava em n=-3 agora está em n=1

figure;
subplot(3, 1, 1);
stem(m, x_base, 'filled');
title('Sinal Original x[n]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

subplot(3, 1, 2);
stem(na, ya, 'filled', 'r');
title('Sinal Deslocado à Direita y_a[n] = x[n-4] (ATRASO)');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

subplot(3, 1, 3);
stem(m, x_base, 'filled'); hold on;
stem(na, ya, 'filled', 'r'); hold off; legend('Original', 'Atrasado');
title('Comparação: Shift de 4 para Direita');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

%% --- Item 5b: y[n] = x[n+4] (AVANÇO de 4 Amostras) ---
[yb, nb] = sigshift(x_base, m, -4);

% ANÁLISE:
%   - k = -4 (negativo)
%   - Novos índices: nb = m-4 = [-7,-6,...,3]
%   - O sinal "se move para a esquerda" 4 posições
%   - Exemplo: valor que estava em n=7 agora está em n=3

figure;
subplot(3, 1, 1);
stem(m, x_base, 'filled');
title('Sinal Original x[n]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

subplot(3, 1, 2);
stem(nb, yb, 'filled', 'g');
title('Sinal Deslocado à Esquerda y_b[n] = x[n+4] (AVANÇO)');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

subplot(3, 1, 3);
stem(m, x_base, 'filled'); hold on;
stem(nb, yb, 'filled', 'g'); hold off; legend('Original', 'Avançado');
title('Comparação: Shift de 4 para Esquerda');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

%% ============================================================================
%% EXERCÍCIO 6: REBATIMENTO (FOLDING / TIME REVERSAL)
%% ============================================================================
% FUNÇÃO: [y,n] = sigfold(x, n)
%
% OPERAÇÃO: y[n] = x[-n]
%   - Inverte a sequência em torno de n=0
%   - "Espelha" o sinal
%
% IMPLEMENTAÇÃO:
%   y = fliplr(x)    → inverte ordem dos elementos
%   n_out = -fliplr(n) → inverte e nega os índices
%
% EXEMPLO:
%   Original: x = [3,0,2,1,5], n = [-2,-1,0,1,2]
%   Rebatido: y = [5,1,2,0,3], n = [-2,-1,0,1,2]
%   → O valor que estava em n=2 (5) agora está em n=-2
%   → O valor que estava em n=-2 (3) agora está em n=2

%% --- Rebatimento do Sinal Base ---
[y, n_out] = sigfold(x_base, m);

% VERIFICAÇÃO:
% Original: x_base[7] = 10 (último valor, em n=7)
% Rebatido: y[-7] = 10 (mesmo valor, em n=-7)

figure;
subplot(2, 1, 1);
stem(m, x_base, 'filled');
title('Sinal Original x[n]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 8]);

subplot(2, 1, 2);
stem(n_out, y, 'filled', 'm');
title('Sinal Rebatido y[n] = x[-n] (Reflexão em n=0)');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 8]);

% APLICAÇÃO: Usado em convolução, análise de simetria, autocorrelação

%% ============================================================================
%% EXERCÍCIO 7: COMBINAÇÃO DE OPERAÇÕES (O MAIS IMPORTANTE!)
%% ============================================================================
% SINAL BASE: x = {1, -2, 4, 6, -5, 8, 10} com n=-4:2
%   - x[-4]=1, x[-3]=-2, x[-2]=4, x[-1]=6, x[0]=-5, x[1]=8, x[2]=10

x = [1, -2, 4, 6, -5, 8, 10];
n = -4:2;

%% ============================================================================
%% Item 7a: x1[n] = 3*x[n+2] + x[n-4] - 2*x[n]
%% ============================================================================
% ESTRATÉGIA: Calcular cada termo separadamente, depois somar
%
% ORDEM DE OPERAÇÕES:
%   1. Calcular x[n+2] (shift de -2)
%   2. Multiplicar por 3
%   3. Calcular x[n-4] (shift de +4)
%   4. Calcular -2*x[n]
%   5. Somar os três termos

%% Termo 1: 3*x[n+2]
[x_p2, n_p2] = sigshift(x, n, -2);  % x[n+2] → shift esquerda 2
% n_p2 = n+(-2) = [-4:2]+(-2) = [-6:0]
termo1 = 3*x_p2;

%% Termo 2: x[n-4]
[x_m4, n_m4] = sigshift(x, n, 4);   % x[n-4] → shift direita 4
% n_m4 = n+4 = [-4:2]+4 = [0:6]
termo2 = x_m4;

%% Termo 3: -2*x[n]
termo3 = -2*x;
n3 = n;  % [-4:2]

%% Soma dos Termos
% Primeiro soma termo1 + termo2
[temp, n_temp] = sigadd(termo1, n_p2, termo2, n_m4);
% Depois soma resultado com termo3
[x1, n1] = sigadd(temp, n_temp, termo3, n3);

% ANÁLISE DO RESULTADO:
% - Suporte final: n1 = [min(-6,-4,0), max(0,6,2)] = [-6,6]
% - Cada ponto é a combinação dos três termos (quando existem)

figure;
stem(n1, x1, 'filled');
title('7(a): x_1[n] = 3x[n+2] + x[n-4] - 2x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% Item 7b: x2[n] = 5*x[n+5] + 4*x[n+4] + 3*x[n]
%% ============================================================================

%% Termo 1: 5*x[n+5]
[x_p5, n_p5] = sigshift(x, n, -5);  % shift esquerda 5
% n_p5 = [-4:2]+(-5) = [-9:(-3)]

%% Termo 2: 4*x[n+4]
[x_p4, n_p4] = sigshift(x, n, -4);  % shift esquerda 4
% n_p4 = [-4:2]+(-4) = [-8:(-2)]

%% Termo 3: 3*x[n]
termo3 = 3*x;

%% Soma
[temp, n_temp] = sigadd(5*x_p5, n_p5, 4*x_p4, n_p4);
[x2, n2] = sigadd(temp, n_temp, termo3, n);

% RESULTADO: Suporte em [-9, 2] (12 posições)

figure;
stem(n2, x2, 'filled');
title('7(b): x_2[n] = 5x[n+5] + 4x[n+4] + 3x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% Item 7c: x3[n] = x[n+4]*x[n-1] + x[2-n]*x[n]  (EXERCÍCIO MAIS COMPLEXO!)
%% ============================================================================
% DOIS TERMOS PRINCIPAIS:
%   A: x[n+4] * x[n-1]     → produto de dois shifts
%   B: x[2-n] * x[n]       → produto de folding+shift com original
%
% PASSO A PASSO:

%% TERMO A: x[n+4] * x[n-1]
%   Subpasso 1: x[n+4]
[x_p4, n_p4] = sigshift(x, n, -4);
% n_p4 = [-4:2]+(-4) = [-8:(-2)]

%   Subpasso 2: x[n-1]
[x_m1, n_m1] = sigshift(x, n, 1);
% n_m1 = [-4:2]+1 = [-3:3]

%   Subpasso 3: Multiplicação
[term_A, n_A] = sigmult(x_p4, n_p4, x_m1, n_m1);
% Sobreposição: [-3,-2] (apenas 2 pontos!)

%% TERMO B: x[2-n] * x[n]
%   Conceito: x[2-n] = x[-(n-2)]
%   Passo 1: Gerar x[-n] (rebatimento)
[x_folded, n_folded] = sigfold(x, n);
% x_folded tem mesmo conteúdo de x, mas espelhado
% n_folded = -[2,1,0,-1,-2,-3,-4] = [-2,-1,0,1,2,3,4]

%   Passo 2: Gerar x[2-n] = x[-n+2] (shift do rebatido)
[x_2mn, n_2mn] = sigshift(x_folded, n_folded, 2);
% n_2mn = n_folded+2 = [-2:4]+2 = [0:6]

%   Passo 3: Multiplicar x[2-n] * x[n]
[term_B, n_B] = sigmult(x_2mn, n_2mn, x, n);
% Sobreposição: [0,2] (3 pontos)

%% SOMA FINAL: term_A + term_B
[x3, n3] = sigadd(term_A, n_A, term_B, n_B);

% INTERPRETAÇÃO:
% - Esta operação combina autocorrelação (termo B) com produto de shifts (termo A)
% - Muito usado em análise de sistemas e casamento de padrões

figure;
stem(n3, x3, 'filled');
title('7(c): x_3[n] = x[n+4]x[n-1] + x[2-n]x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% ============================================================================
%% RESUMO DO LABORATÓRIO 2
%% ============================================================================
fprintf('\n=== RESUMO: OPERAÇÕES COM SINAIS DISCRETOS ===\n');
fprintf('FUNÇÕES APRENDIDAS:\n');
fprintf('  • impseq(n0,n1,n2): Gera δ[n-n0]\n');
fprintf('  • stepseq(n0,n1,n2): Gera u[n-n0]\n');
fprintf('  • sigadd(x1,n1,x2,n2): Soma com suportes diferentes\n');
fprintf('  • sigmult(x1,n1,x2,n2): Multiplica com suportes diferentes\n');
fprintf('  • sigshift(x,m,k): Desloca x[n] → y[n]=x[n-k]\n');
fprintf('  • sigfold(x,n): Rebate x[n] → y[n]=x[-n]\n');
fprintf('\n');
fprintf('REGRAS IMPORTANTES:\n');
fprintf('  • x[n-k]: k>0 → atraso (shift direita)\n');
fprintf('  • x[n+k]: k>0 → avanço (shift esquerda)\n');
fprintf('  • sigshift usa k positivo para atraso!\n');
fprintf('  • Sempre combine operações passo-a-passo\n');
fprintf('  • Adição: preserva valores fora da sobreposição\n');
fprintf('  • Multiplicação: zera fora da sobreposição\n');
fprintf('================================================\n\n');

%% ============================================================================
%% FIM DO LABORATÓRIO 2
%% ============================================================================
% PRÓXIMOS PASSOS:
% → Lab 3: Convolução e sistemas LTI
% → Lab 4: Análise de Fourier
%% ============================================================================
