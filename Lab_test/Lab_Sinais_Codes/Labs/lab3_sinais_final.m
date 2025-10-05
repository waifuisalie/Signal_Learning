%% Laboratório 3 - Sinais e Sistemas Discretos
% *Disciplina:* Processamento Digital de Sinais
% *Professor:* Marcelo Eduardo Pellenz
% *Alunos:* Francisco Bley e Stefan Rodrigues
% ---------------------------------------------------

clear; clc; close all;

%% Exercício 1a
% Decomposição de x[n] = u[n] - u[n-10] em parte par e ímpar

[x1, n1] = stepseq(0, -20, 20);
[x2_temp, n2] = stepseq(10, -20, 20);
x2 = -x2_temp;

[x, n] = sigadd(x1, n1, x2, n2);
[xe, xo, m] = evenodd(x, n);

figure;
subplot(3,1,1); stem(n, x); title('Ex. 1a: Sinal x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,2); stem(m, xe); title('Parte Par xe[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,3); stem(m, xo); title('Parte Ímpar xo[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 1b
% Decomposição de x[n] = (0.8)^n em parte par e ímpar

n = 0:20;
xn = (0.8).^n;
[xe, xo, m] = evenodd(xn, n);

figure;
subplot(3,1,1); stem(n, xn); title('Ex. 1b: Sinal x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,2); stem(m, xe); title('Parte Par xe[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,3); stem(m, xo); title('Parte Ímpar xo[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 2c
% Convolução com sinais iniciando em n = 0

xn = [3, 11, 7, 0, -1, 4, 2];  N_xn = 0:6;
hn = [2, 3, 0, -5, 2, 1];      N_hn = 0:5;

yn = conv(xn, hn);
ny = (N_xn(1)+N_hn(1)) : (N_xn(end)+N_hn(end));

figure;
subplot(3,1,1); stem(N_xn, xn); title('Ex. 2c: Entrada x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,2); stem(N_hn, hn); title('Resposta ao Impulso h[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,3); stem(ny, yn); title('Saída y[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 3c
% Convolução com sinais em posições arbitrárias

xn = [3, 11, 7, 0, -1, 4, 2];  N_xn = -3:3;
hn = [2, 3, 0, -5, 2, 1];      N_hn = -1:4;

[y, ny] = conv_m(xn, N_xn, hn, N_hn);

figure;
subplot(3,1,1); stem(N_xn, xn); title('Ex. 3c: Entrada x[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,2); stem(N_hn, hn); title('Resposta ao Impulso h[n]');
xlabel('n'); ylabel('Amplitude'); grid on;
subplot(3,1,3); stem(ny, y); title('Saída y[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 4a
% Resposta ao impulso do sistema

[x, n] = impseq(0, -20, 120);
a = [1, -1, 0.9]; b = [1];
h = filter(b, a, x);

figure;
stem(n, h); title('Ex. 4a: Resposta ao Impulso h[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 4b
% Resposta ao degrau do sistema

[x, n] = stepseq(0, -20, 120);
a = [1, -1, 0.9]; b = [1];
s = filter(b, a, x);

figure;
stem(n, s); title('Ex. 4b: Resposta ao Degrau s[n]');
xlabel('n'); ylabel('Amplitude'); grid on;

%% Exercício 5
% Filtro de Média Móvel com M = 10

n = 0:100;
x_clean = 2*cos((pi/8).*n);
noise = randn(1, length(n));
x_noisy = x_clean + noise;

M = 10;
b = (1/M) * ones(1, M); a = [1];
y_filtered = filter(b, a, x_noisy);

figure;
plot(n, x_noisy, 'b-', 'DisplayName', 'Sinal Ruidoso'); hold on;
plot(n, y_filtered, 'r-', 'LineWidth', 2, 'DisplayName', 'Sinal Filtrado');
hold off;
title('Ex. 5: Filtro de Média Móvel');
xlabel('n'); ylabel('Amplitude'); legend; grid on;


%% Exercício 4c
% Implementação em tempo real da equação de diferenças

n = 0; y1 = 0; y2 = 0;

while n < 10
   x = input('Digite a amostra x[n]: '); 
   y = x + y1 - 0.9*y2; 
   y2 = y1; 
   y1 = y; 
   n = n + 1; 
   fprintf('y[%d] = %.2f\n', n, y); 
end

