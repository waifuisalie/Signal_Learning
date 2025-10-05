%% Laboratório 2 - Operações com Sequências Discretas
% *Disciplina:* Processamento Digital de Sinais
% *Professor:* Marcelo Eduardo Pellenz
% *Alunos:* Francisco Bley e Stefan Rodrigues
% ---------------------------------------------------
clear; clc; close all;

%% Exercício 1 - Geração da Função Impulso Unitário
% Usando a função [x,n] = impseq(n0, n1, n2)

% a) x[n] = delta[n]
[x_a, n_a] = impseq(0, -20, 20);
figure;
stem(n_a, x_a, 'filled');
title('1(a): Impulso Unitário x[n] = \delta[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% b) x[n] = delta[n - 4]
[x_b, n_b] = impseq(4, -20, 20);
figure;
stem(n_b, x_b, 'filled');
title('1(b): Impulso Unitário x[n] = \delta[n-4]');
xlabel('n');
ylabel('Amplitude');
grid on;

% c) x[n] = delta[n + 8]
[x_c, n_c] = impseq(-8, -20, 20);
figure;
stem(n_c, x_c, 'filled');
title('1(c): Impulso Unitário x[n] = \delta[n+8]');
xlabel('n');
ylabel('Amplitude');
grid on;

%% Exercício 2 - Geração da Função Degrau Unitário
% Usando a função [x,n] = stepseq(n0, n1, n2)

% a) x[n] = u[n]
[x_a, n_a] = stepseq(0, -20, 20);
figure;
stem(n_a, x_a, 'filled');
title('2(a): Degrau Unitário x[n] = u[n]');
xlabel('n');
ylabel('Amplitude');
grid on;

% b) x[n] = u[n - 4]
[x_b, n_b] = stepseq(4, -20, 20);
figure;
stem(n_b, x_b, 'filled');
title('2(b): Degrau Unitário x[n] = u[n-4]');
xlabel('n');
ylabel('Amplitude');
grid on;

% c) x[n] = u[n + 5]
[x_c, n_c] = stepseq(-5, -20, 20);
figure;
stem(n_c, x_c, 'filled');
title('2(c): Degrau Unitário x[n] = u[n+5]');
xlabel('n');
ylabel('Amplitude');
grid on;

%% Exercício 3 - Adição de Sinais
% y[n] = x1[n] + x2[n]

% Definição do sinal x1[n], com n=0 no quarto elemento
x1 = [3, 0, 2, 1, 5, 7, 0, 0, 1, 1, 10];
n1 = -3:7;

% Definição do sinal x2[n], com n=0 no primeiro elemento
x2 = [-4, -3, -2, -1, 0, 1, 2, 3, 4];
n2 = 0:8;

% Adição dos sinais usando a função sigadd
[y, n] = sigadd(x1, n1, x2, n2);

% Visualização dos resultados
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
title('Sinal Resultante y[n] = x_1[n] + x_2[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 4 - Multiplicação de Sinais
% y[n] = x1[n] * x2[n]

% Multiplicação dos mesmos sinais do exercício anterior
[y, n] = sigmult(x1, n1, x2, n2);

% Visualização dos resultados
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
title('Sinal Resultante y[n] = x_1[n] * x_2[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 5 - Deslocamento no Tempo
% Sinal base para os exercícios 5 e 6
x_base = [3, 0, 2, 1, 5, 7, 0, 0, 1, 1, 10];
m = -3:7;

% a) y[n] = x[n-4] (Atraso de 4 amostras)
[ya, na] = sigshift(x_base, m, 4);

% b) y[n] = x[n+4] (Avanço de 4 amostras)
[yb, nb] = sigshift(x_base, m, -4);

% Visualização dos resultados
figure;
subplot(3, 1, 1);
stem(m, x_base, 'filled');
title('Sinal Original x[n]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

subplot(3, 1, 2);
stem(na, ya, 'filled', 'r');
title('Sinal Deslocado à Direita y_a[n] = x[n-4]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

subplot(3, 1, 3);
stem(nb, yb, 'filled', 'g');
title('Sinal Deslocado à Esquerda y_b[n] = x[n+4]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 12]);

%% Exercício 6 - Rebatimento (Folding)
% y[n] = x[-n]

[y, n_out] = sigfold(x_base, m);

% Visualização dos resultados
figure;
subplot(2, 1, 1);
stem(m, x_base, 'filled');
title('Sinal Original x[n]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 8]);

subplot(2, 1, 2);
stem(n_out, y, 'filled', 'm');
title('Sinal Rebatido y[n] = x[-n]');
xlabel('n'); ylabel('Amplitude'); grid on; xlim([-8 8]);

%% Exercício 7 - Combinação de Operações
% Sinal base: x = {1, -2, 4, 6, -5, 8, 10}, com n=0 no primeiro elemento
x = [1, -2, 4, 6, -5, 8, 10];
n = -4:2;

%% a) x1[n] = 3*x[n+2] + x[n-4] - 2*x[n]
[x_p2, n_p2] = sigshift(x, n, -2); % Componente x[n+2]
[x_m4, n_m4] = sigshift(x, n, 4);  % Componente x[n-4]
[temp, n_temp] = sigadd(3*x_p2, n_p2, x_m4, n_m4);
[x1, n1] = sigadd(temp, n_temp, -2*x, n);

figure;
stem(n1, x1, 'filled');
title('7(a): x_1[n] = 3x[n+2] + x[n-4] - 2x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% b) x2[n] = 5*x[n+5] + 4*x[n+4] + 3*x[n]
[x_p5, n_p5] = sigshift(x, n, -5); % Componente x[n+5]
[x_p4, n_p4] = sigshift(x, n, -4); % Componente x[n+4]
[temp, n_temp] = sigadd(5*x_p5, n_p5, 4*x_p4, n_p4);
[x2, n2] = sigadd(temp, n_temp, 3*x, n);

figure;
stem(n2, x2, 'filled');
title('7(b): x_2[n] = 5x[n+5] + 4x[n+4] + 3x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% c) x3[n] = x[n+4]*x[n-1] + x[2-n]*x[n]
% Primeiro termo: x[n+4]*x[n-1]
[x_p4, n_p4] = sigshift(x, n, -4);
[x_m1, n_m1] = sigshift(x, n, 1);
[term_A, n_A] = sigmult(x_p4, n_p4, x_m1, n_m1);

% Segundo termo: x[2-n]*x[n]
[x_folded, n_folded] = sigfold(x, n); % Gera x[-n]
[x_2mn, n_2mn] = sigshift(x_folded, n_folded, 2); % Gera x[2-n]
[term_B, n_B] = sigmult(x_2mn, n_2mn, x, n);

% Soma final
[x3, n3] = sigadd(term_A, n_A, term_B, n_B);

figure;
stem(n3, x3, 'filled');
title('7(c): x_3[n] = x[n+4]x[n-1] + x[2-n]x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;