%% Relatório do Laboratório 1: Representação de Sequências Discretas
% Disciplina: Processamento Digital de Sinais
% Professor: Marcelo E. Pellenz
% Alunos: Francisco e Stefan

%% Objetivo
% O objetivo desta atividade é demonstrar como representar e manipular 
% sequências discretas, definindo e traçando seus gráficos e interpretando
% conceitos como frequência normalizada, usando o software Matlab.

% --- Configuração Inicial ---
clear;
clc;
close all;
fig_counter = 1; % Inicializa um contador para as figuras

%% Exercício 1: Representação de Sequências Discretas
% Esta seção implementa e traça o gráfico de várias sequências discretas 
% definidas por vetores ou equações simples.

% --- Item 1a ---
x = [3,0,2,1,5,7,0,0,1,1,10];
n = -3:7;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled','LineWidth',1.5); title('Exercício 1a'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1b ---
x = [-4,-3,-2,-1,0,1,2,3,4];
n = 0:8;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1b'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1c ---
x = [0,0,0,1,0,0,0];
n = -3:3;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1c: Impulso Unitário'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1d ---
x = ones(1,35);
n = 0:34;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1d: Degrau Unitário'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1e: x[n] = n^2 ---
n = -10:10;
x = n.^2;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1e: x[n] = n^2'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1f: x[n] = (0.9)^n ---
n = 0:30;
x = 0.9.^n;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1f: x[n] = (0.9)^n'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1g: x[n] = exp(|n/4|) ---
n = -20:20;
x = exp(abs(n/4));
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1g: x[n] = exp(|n/4|)'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1h: Função Seccionada ---
n = -15:15;
x = zeros(size(n));
cond1 = (n < 3); cond2 = (n >= 3 & n < 6); cond3 = (n >= 6);
x(cond1) = n(cond1) - 1; x(cond2) = -3; x(cond3) = 5 - (n(cond3)/3);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1h'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1i: x[n] = (n+1)/(n^2+1) ---
n = -15:15;
x = (n + 1) ./ (n.^2 + 1);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1i'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1j: Função Seccionada ---
n = -15:15;
x = zeros(size(n));
cond1 = n >= 0;
x(cond1) = n(cond1).^2 - 1;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1j'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 1k: Função Seccionada ---
n = -15:15;
x = zeros(size(n));
cond1 = n >= 0; cond2 = n < 0;
x(cond1) = 1./(n(cond1) + 1); x(cond2) = 1./(1 - n(cond2));
figure(fig_counter); fig_counter = fig_counter+1;
stem(n,x,'filled'); title('Exercício 1k'); xlabel('n'); ylabel('x[n]'); grid on;


%% Exercício 2: Sequências Exponenciais Reais
% Geração de sequências da forma x[n] = k*a^n.

% --- Item 2a: x[n] = (0.8)^n ---
N = 50; n = 0:N-1; x = (0.8).^n;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 2a: x[n] = (0.8)^n'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 2b: x[n] = (1.5)^n ---
N = 20; n = 0:N-1; x = (1.5).^n;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 2b: x[n] = (1.5)^n'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 2c: x[n] = 0.5 * 2^n ---
N = 200; n = 0:N-1; x = 0.5 * (2.^n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 2c: x[n] = 0.5 * 2^n'); xlabel('n'); ylabel('x[n]'); grid on;

%% Exercício 3: Sequências Exponenciais Complexas
% Geração de sequências da forma x[n] = exp((sigma + j*omega)*n) e 
% visualização de suas componentes (real, imaginária, módulo e fase).

% --- Item 3a: sigma=0.5, omega=pi/6 ---
sigma = 0.5; omega = pi/6; N = 50; n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);
figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3a: \sigma=0.5, \omega=\pi/6')
subplot(2,2,1); stem(n,real(x),'filled'); title('Parte Real'); grid on;
subplot(2,2,2); stem(n,imag(x),'filled'); title('Parte Imaginária'); grid on;
subplot(2,2,3); stem(n,abs(x),'filled'); title('Módulo'); grid on;
subplot(2,2,4); stem(n,angle(x),'filled'); title('Fase'); grid on;

% --- Item 3b: sigma=-0.5, omega=pi/4 ---
sigma = -0.5; omega = pi/4; N = 30; n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);
figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3b: \sigma=-0.5, \omega=\pi/4')
subplot(2,2,1); stem(n,real(x),'filled'); title('Parte Real'); grid on;
subplot(2,2,2); stem(n,imag(x),'filled'); title('Parte Imaginária'); grid on;
subplot(2,2,3); stem(n,abs(x),'filled'); title('Módulo'); grid on;
subplot(2,2,4); stem(n,angle(x),'filled'); title('Fase'); grid on;

% --- Item 3c: sigma=1, omega=pi/4 ---
sigma = 1; omega = pi/4; N = 100; n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);
figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3c: \sigma=1, \omega=\pi/4');
subplot(2,2,1); stem(n,real(x),'filled'); title('Parte Real'); grid on;
subplot(2,2,2); stem(n,imag(x),'filled'); title('Parte Imaginária'); grid on;
subplot(2,2,3); stem(n,abs(x),'filled'); title('Módulo'); grid on;
subplot(2,2,4); stem(n,angle(x),'filled'); title('Fase'); grid on;

% --- Item 3d: sigma=0, omega=pi/6 ---
sigma = 0; omega = pi/6; N = 60; n = 0:N-1;
x = exp((sigma + 1j*omega) .* n);
figure(fig_counter); fig_counter = fig_counter+1;
sgtitle('Exercício 3d: \sigma=0, \omega=\pi/6');
subplot(2,2,1); stem(n,real(x),'filled'); title('Parte Real'); grid on;
subplot(2,2,2); stem(n,imag(x),'filled'); title('Parte Imaginária'); grid on;
subplot(2,2,3); stem(n,abs(x),'filled'); title('Módulo'); grid on;
subplot(2,2,4); stem(n,angle(x),'filled'); title('Fase'); grid on;

%% Exercício 4: Digitalização de Sinais Analógicos
% Amostragem de sinais cosseno com Fs = 200 Hz.

Fs = 200; n = 0:20;

% --- Item 4a: f = 10 Hz ---
f = 10; omega = 2*pi*f / Fs; x = cos(omega * n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 4a: f = 10 Hz'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 4b: f = 20 Hz ---
f = 20; omega = 2*pi*f / Fs; x = cos(omega * n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 4b: f = 20 Hz'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 4c: f = 50 Hz ---
f = 50; omega = 2*pi*f / Fs; x = cos(omega * n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 4c: f = 50 Hz'); xlabel('n'); ylabel('x[n]'); grid on;

% --- Item 4d: f = 100 Hz (Nyquist) ---
f = 100; omega = 2*pi*f / Fs; x = cos(omega * n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); title('Exercício 4d: f = 100 Hz'); xlabel('n'); ylabel('x[n]'); grid on;

%% Exercício 5: Cosseno com Diferentes Frequências Normalizadas
% Geração de x[n] = cos(omega*n) para um conjunto de frequências.
n = 0:40;
omega_values = [0, pi/4, 2*pi/4, 3*pi/4, 4*pi/4, 5*pi/4, 6*pi/4, 7*pi/4, 8*pi/4];
for omega = omega_values
    x = cos(omega * n);
    figure(fig_counter); fig_counter = fig_counter+1;
    stem(n, x, 'filled'); grid on;
    title(['\omega = ', num2str(omega/pi), '\pi rad/amostra']);
    xlabel('n'); ylabel('x[n]');
end

% --- Análise do Exercício 5 ---
%
% *Conceito de Frequências Altas e Baixas:*
% Frequências baixas (omega perto de 0) resultam em sequências que variam
% lentamente. Frequências altas (omega perto de pi) resultam em sequências
% que variam rapidamente entre amostras.
%
% *Aliasing (Rebatimento):*
% Frequências acima de pi são indistinguíveis de frequências mais baixas.
% Por exemplo, omega = 5*pi/4 produz o mesmo sinal que omega = 3*pi/4.
% A frequência omega = 2*pi produz o mesmo sinal que omega = 0.
%
% *Tabela de Conversão para Frequência Analógica (Hz):*
% A conversão é feita com a fórmula f = (omega * Fs) / (2*pi).
%
% Para Fs = 8000 Hz:
%   - Para omega = 0.25*pi, f = 1000 Hz
%   - Para omega = 0.50*pi, f = 2000 Hz
%   - Para omega = 0.75*pi, f = 3000 Hz
%   - Para omega = 1.00*pi, f = 4000 Hz
%   - Para omega = 1.25*pi, f = 3000 Hz (aliasing)
%
% Para Fs = 16000 Hz:
%   - Para omega = 0.25*pi, f = 2000 Hz
%   - Para omega = 0.50*pi, f = 4000 Hz
%   - Para omega = 0.75*pi, f = 6000 Hz
%   - Para omega = 1.00*pi, f = 8000 Hz
%   - Para omega = 1.25*pi, f = 6000 Hz (aliasing)


%% Exercício 6: Soma de Senoides
% Gráfico de x[n] = 5*cos(0.5*pi*n + pi/4) + 2*sin(0.5*pi*n).
n = -20:20;
termo_cos = 5 * cos(0.5 * pi * n + pi/4);
termo_sin = 2 * sin(0.5 * pi * n);
x = termo_cos + termo_sin;
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x, 'filled'); grid on;
title('Exercício 6: Soma de Senoides'); xlabel('n'); ylabel('x[n]');

%% Exercício 7: Análise de Periodicidade
% Análise da periodicidade de três sequências de cosseno.

n = 0:30;

% --- Item 7a: x[n] = cos((pi/4)*n) ---
x_a = cos((pi/4) * n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x_a, 'filled'); grid on; title('Exercício 7a'); xlabel('n'); ylabel('x[n]');

% --- Item 7b: x[n] = cos((3*pi/8)*n) ---
x_b = cos((3*pi/8) * n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x_b, 'filled'); grid on; title('Exercício 7b'); xlabel('n'); ylabel('x[n]');

% --- Item 7c: x[n] = cos(n) ---
x_c = cos(n);
figure(fig_counter); fig_counter = fig_counter+1;
stem(n, x_c, 'filled'); grid on; title('Exercício 7c'); xlabel('n'); ylabel('x[n]');

% --- Análise de Periodicidade do Exercício 7 ---
% Um sinal discreto cos(omega*n) é periódico se omega/(2*pi) for um 
% número racional (k/N).
%
% a) x[n] = cos((pi/4)*n): (pi/4)/(2*pi) = 1/8. É periódico com N=8.
%
% b) x[n] = cos((3*pi/8)*n): (3*pi/8)/(2*pi) = 3/16. É periódico com N=16.
%
% c) x[n] = cos(n): 1/(2*pi) é irracional. Não é periódico.