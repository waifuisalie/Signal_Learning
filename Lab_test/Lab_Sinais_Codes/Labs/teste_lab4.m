% Lab 4a - Série de Fourier
% Letra (a) e (b)

clc; clear; close all;

% --- 1. Parâmetros ---
F = 20;         % Frequência fundamental (Hz)
Fs = 16000;     % Frequência de amostragem (Hz)
T = 1/F;        % Período fundamental
num_periods = 5;                        % Número de períodos a simular
total_time = num_periods * T;           % Tempo total de simulação
Ts = 1/Fs;                              % Período de amostragem
t = 0:Ts:total_time;                    % Vetor de tempo

% =======================================================================
% --- (a) Construção com um valor fixo de N ---
N = 50;   % Número de harmônicos para a síntese principal (fixo p/ letra a)

% Onda quadrada
func_square = zeros(size(t));
for k = 1:2:(2*N-1)
    harmonic = (4/pi) * (1/k) * sin(2*pi*k*F*t);
    func_square = func_square + harmonic;
end

figure(1);
plot(t, func_square);
title(['Square Wave Synthesis (N = ' num2str(N) ')']);
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

% Onda triangular
func_triangle = zeros(size(t));
for k = 1:2:(2*N-1)
    harmonic = (8/pi^2) * ((-1)^((k-1)/2)) * (sin(2*pi*k*F*t)/(k^2));
    func_triangle = func_triangle + harmonic;
end

figure(2);
plot(t, func_triangle);
title(['Triangle Wave Synthesis (N = ' num2str(N) ')']);
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

% Onda dente de serra (sawtooth)
func_sawtooth = zeros(size(t));
for k = 1:N
    harmonic = (2/pi) * (sin(2*pi*k*F*t)/k);
    func_sawtooth = func_sawtooth + harmonic;
end

figure(3);
plot(t, func_sawtooth);
title(['Sawtooth Wave Synthesis (N = ' num2str(N) ')']);
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

% =======================================================================
% --- (b) Comparação da aproximação com diferentes N ---
Ns = [1, 3, 5, 15, 50];  % valores de N a comparar

% Quadrada
figure(4); hold on;
for N = Ns
    y = zeros(size(t));
    for k = 1:2:(2*N-1)
        y = y + (4/pi) * (1/k) * sin(2*pi*k*F*t);
    end
    plot(t, y, 'DisplayName', ['N = ' num2str(N)]);
end
title('Square Wave - Aproximação com diferentes N');
xlabel('Time (s)'); ylabel('Amplitude'); legend show; grid on;

% Triangular
figure(5); hold on;
for N = Ns
    y = zeros(size(t));
    for k = 1:2:(2*N-1)
        y = y + (8/pi^2) * ((-1)^((k-1)/2)) * (sin(2*pi*k*F*t)/(k^2));
    end
    plot(t, y, 'DisplayName', ['N = ' num2str(N)]);
end
title('Triangle Wave - Aproximação com diferentes N');
xlabel('Time (s)'); ylabel('Amplitude'); legend show; grid on;

% Dente de serra
figure(6); hold on;
for N = Ns
    y = zeros(size(t));
    for k = 1:N
        y = y + (2/pi) * (sin(2*pi*k*F*t)/k);
    end
    plot(t, y, 'DisplayName', ['N = ' num2str(N)]);
end
title('Sawtooth Wave - Aproximação com diferentes N');
xlabel('Time (s)'); ylabel('Amplitude'); legend show; grid on;

% =======================================================================
% --- (c) Espectro de frequências das ondas ---

% Função auxiliar para calcular e plotar espectro
function plot_spectrum(signal, Fs, title_str, fig_num)
    L = length(signal);                 % número de pontos
    Y = fft(signal);                    % FFT do sinal
    P2 = abs(Y/L);                      % espectro bilateral normalizado
    P1 = P2(1:floor(L/2)+1);            % metade positiva
    P1(2:end-1) = 2*P1(2:end-1);        % converter para espectro unilateral
    
    f = Fs*(0:floor(L/2))/L;            % eixo de frequências
    
    figure(fig_num);
    stem(f, P1, 'Marker', 'none');      % usar stem para destacar harmônicos
    title(['Espectro de Frequências - ' title_str]);
    xlabel('Frequência (Hz)');
    ylabel('Amplitude');
    grid on;
    xlim([0 500]); % limitar a 500 Hz (suficiente para ver harmônicos)
end

% Agora plota espectros das ondas sintetizadas com N=50
plot_spectrum(func_square, Fs, 'Onda Quadrada', 7);
plot_spectrum(func_triangle, Fs, 'Onda Triangular', 8);
plot_spectrum(func_sawtooth, Fs, 'Onda Dente de Serra', 9);

% =======================================================================
% --- (d) Sinal composto e seu espectro ---

% Parâmetros
Fs = 16000;        % frequência de amostragem
F0 = 1000;         % frequência fundamental
T0 = 1/F0;         % período fundamental
num_periods = 5;   
total_time = num_periods * T0;
Ts = 1/Fs;
t = 0:Ts:total_time;   % vetor de tempo

% Definição do sinal
x = cos(2*pi*1000*t) + ...
    0.5*cos(2*pi*3000*t) + ...
    0.25*cos(2*pi*4000*t) + ...
    cos(2*pi*5000*t);

% Plot no tempo
figure(10);
plot(t, x);
title('Sinal x(t) no tempo (5 períodos)');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;

% --- Espectro de frequências ---
plot_spectrum(x, Fs, 'Sinal x(t)', 11);

