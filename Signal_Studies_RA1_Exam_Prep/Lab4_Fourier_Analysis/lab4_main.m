%% ============================================================================
%% LABORATÓRIO 4: REVISÃO DO CONCEITO DE SÉRIE DE FOURIER
%% ============================================================================
% Disciplina: Processamento Digital de Sinais
% Professor: Marcelo Eduardo Pellenz
% Alunos: Francisco Bley e Stefan Rodrigues
%
% OBJETIVO GERAL:
% Compreender a representação de sinais periódicos usando Série de Fourier,
% síntese de formas de onda, análise espectral com FFT, e efeito do número
% de harmônicos na qualidade da aproximação.
%
% TEORIA FUNDAMENTAL DA SÉRIE DE FOURIER:
%
% Um sinal PERIÓDICO x(t) com período T pode ser decomposto em:
%
%   x(t) = a₀ + Σ[aₖcos(2πkFt) + bₖsin(2πkFt)]  (k=1 a ∞)
%
% Onde:
%   F = 1/T → Frequência fundamental (Hz)
%   k → Número do harmônico (k=1: fundamental, k=2: 2º harmônico, etc.)
%   aₖ, bₖ → Coeficientes de Fourier (determinam amplitudes)
%
% FORMA ALTERNATIVA (Senos apenas):
%   x(t) = Σ Aₖsin(2πkFt + φₖ)
%
% INTERPRETAÇÃO:
%   - Todo sinal periódico é SOMA de senoides
%   - Cada senoide tem frequência múltipla da fundamental (harmônicos)
%   - Coeficientes determinam quanto de cada harmônico está presente
%
% CONCEITOS-CHAVE:
%   1. SÍNTESE: Construir forma de onda a partir de harmônicos
%   2. ANÁLISE: Extrair harmônicos de uma forma de onda (FFT)
%   3. CONVERGÊNCIA: Mais harmônicos → melhor aproximação
%   4. FENÔMENO DE GIBBS: Overshoot em descontinuidades
%% ============================================================================

%% --- INICIALIZAÇÃO ---
clc; clear; close all;

%% ============================================================================
%% PARÂMETROS GERAIS
%% ============================================================================
F = 20;              % Frequência fundamental = 20 Hz
Fs = 16000;          % Frequência de amostragem = 16 kHz
T = 1/F;             % Período fundamental = 1/20 = 0.05 s
num_periods = 5;     % Número de períodos a simular
total_time = num_periods * T;      % Tempo total = 0.25 s
Ts = 1/Fs;                         % Período de amostragem
t = 0:Ts:total_time;               % Vetor de tempo (4000 amostras)

%% ============================================================================
%% FUNÇÃO AUXILIAR: CÁLCULO E PLOTAGEM DO ESPECTRO
%% ============================================================================
% Esta função encapsula o processo de análise espectral usando FFT
%
% PROCESSO:
%   1. Calcular FFT do sinal
%   2. Normalizar pela quantidade de pontos
%   3. Converter espectro bilateral → unilateral
%   4. Plotar amplitude vs frequência

function plot_spectrum(signal, Fs, title_str, fig_num)
    L = length(signal);                 % Número de pontos
    Y = fft(signal);                    % FFT (espectro bilateral complexo)

    % ESPECTRO BILATERAL NORMALIZADO:
    P2 = abs(Y/L);                      % Divide por L para normalizar
    %   - Y contém valores complexos
    %   - abs() extrai magnitude
    %   - Divisão por L normaliza energia

    % ESPECTRO UNILATERAL (Apenas Frequências Positivas):
    P1 = P2(1:floor(L/2)+1);            % Pega primeira metade + DC
    P1(2:end-1) = 2*P1(2:end-1);        % Multiplica por 2 (exceto DC e Nyquist)

    % POR QUÊ MULTIPLICAR POR 2?
    %   - FFT bilateral divide energia entre ±f
    %   - Espectro unilateral soma energia de f e -f
    %   - DC (f=0) e Nyquist não têm par negativo → não multiplicam

    % VETOR DE FREQUÊNCIAS:
    f = Fs*(0:floor(L/2))/L;            % 0, Δf, 2Δf, ..., Fs/2
    %   onde Δf = Fs/L (resolução em frequência)

    % PLOTAGEM:
    figure(fig_num);
    stem(f, P1, 'Marker', 'none');      % Stem destaca harmônicos discretos
    title(['Espectro de Frequências - ' title_str]);
    xlabel('Frequência (Hz)');
    ylabel('Amplitude');
    grid on;
    xlim([0 500]); % Limita a 500 Hz (suficiente para ver harmônicos)
end

%% ============================================================================
%% (a) SÍNTESE DAS FORMAS DE ONDA PERIÓDICAS
%% ============================================================================
% Utilizando Série de Fourier para sintetizar 3 formas de onda clássicas

N = 50;   % Número de harmônicos para síntese principal

%% ============================================================================
%% ONDA QUADRADA (SQUARE WAVE)
%% ============================================================================
% FÓRMULA DA SÉRIE DE FOURIER:
%   x(t) = (4/π) * Σ[sin(2πkFt)/k]  para k = 1, 3, 5, 7, ... (ÍMPARES)
%
% CARACTERÍSTICAS:
%   - Contém APENAS harmônicos ÍMPARES (k = 1, 3, 5, ...)
%   - Amplitude decai como 1/k (LENTA)
%   - Por que só ímpares? Simetria de meia-onda: x(t) = -x(t+T/2)
%
% ANÁLISE DA CONVERGÊNCIA:
%   - 1º harmônico (k=1): Amplitude 4/π ≈ 1.273
%   - 3º harmônico (k=3): Amplitude 4/(3π) ≈ 0.424
%   - 5º harmônico (k=5): Amplitude 4/(5π) ≈ 0.255
%   - Convergência LENTA → precisa muitos termos
%
% FENÔMENO DE GIBBS:
%   - Overshoot de ~9% nas descontinuidades
%   - NÃO desaparece com mais harmônicos!
%   - Concentra-se em região cada vez menor

func_square = zeros(size(t));           % Inicializa sinal

for k = 1:2:(2*N-1)                     % k = 1, 3, 5, ..., 99 (ímpares)
    harmonic = (4/pi) * (1/k) * sin(2*pi*k*F*t);
    func_square = func_square + harmonic;
end

figure(1);
plot(t, func_square, 'LineWidth', 1.5);
title(['Onda Quadrada - Síntese com N = ' num2str(N) ' harmônicos']);
xlabel('Tempo (s)'); ylabel('Amplitude'); grid on;
xlim([0 total_time]);

% OBSERVAÇÃO: Note o overshoot nas bordas (Gibbs)!

%% ============================================================================
%% ONDA TRIANGULAR (TRIANGLE WAVE)
%% ============================================================================
% FÓRMULA DA SÉRIE DE FOURIER:
%   x(t) = (8/π²) * Σ[(-1)^((k-1)/2) * sin(2πkFt)/k²]  para k ÍMPAR
%
% CARACTERÍSTICAS:
%   - Também APENAS harmônicos ÍMPARES
%   - Amplitude decai como 1/k² (RÁPIDA!)
%   - Alternância de sinais: (-1)^((k-1)/2)
%       k=1: +1, k=3: -1, k=5: +1, k=7: -1, ...
%   - Convergência RÁPIDA → poucos termos suficientes
%
% ANÁLISE:
%   - 1º harmônico: Amplitude 8/π² ≈ 0.811
%   - 3º harmônico: Amplitude -8/(9π²) ≈ -0.090 (oposto de fase!)
%   - 5º harmônico: Amplitude 8/(25π²) ≈ 0.032
%   - Decai muito mais rápido que onda quadrada

func_triangle = zeros(size(t));

for k = 1:2:(2*N-1)                     % k ímpar
    harmonic = (8/pi^2) * ((-1)^((k-1)/2)) * (sin(2*pi*k*F*t)/(k^2));
    func_triangle = func_triangle + harmonic;
end

figure(2);
plot(t, func_triangle, 'LineWidth', 1.5);
title(['Onda Triangular - Síntese com N = ' num2str(N) ' harmônicos']);
xlabel('Tempo (s)'); ylabel('Amplitude'); grid on;
xlim([0 total_time]);

% OBSERVAÇÃO: Convergência suave, sem Gibbs perceptível (descontinuidade só na derivada)

%% ============================================================================
%% ONDA DENTE DE SERRA (SAWTOOTH WAVE)
%% ============================================================================
% FÓRMULA DA SÉRIE DE FOURIER:
%   x(t) = (2/π) * Σ[sin(2πkFt)/k]  para k = 1, 2, 3, 4, ... (TODOS!)
%
% CARACTERÍSTICAS:
%   - Contém TODOS os harmônicos (pares E ímpares)
%   - Amplitude decai como 1/k
%   - Assimetria: rampa crescente → todos os harmônicos
%
% DIFERENÇA DA QUADRADA:
%   - Quadrada: só ímpares (simetria especial)
%   - Dente de serra: todos (assimétrica)

func_sawtooth = zeros(size(t));

for k = 1:N                             % k = 1, 2, 3, ..., 50 (TODOS)
    harmonic = (2/pi) * (sin(2*pi*k*F*t)/k);
    func_sawtooth = func_sawtooth + harmonic;
end

figure(3);
plot(t, func_sawtooth, 'LineWidth', 1.5);
title(['Onda Dente de Serra - Síntese com N = ' num2str(N) ' harmônicos']);
xlabel('Tempo (s)'); ylabel('Amplitude'); grid on;
xlim([0 total_time]);

%% ============================================================================
%% (b) IMPACTO DO NÚMERO DE COMPONENTES (CONVERGÊNCIA)
%% ============================================================================
% Comparar aproximações com diferentes números de harmônicos:
%   N = 1  → Apenas fundamental (senoide pura)
%   N = 3  → Fundamental + 2º e 3º harmônicos
%   N = 5  → Até 5º harmônico
%   N = 15 → Até 15º harmônico
%   N = 50 → Até 50º harmônico (boa aproximação)

Ns = [1, 3, 5, 15, 50];  % Valores de N a comparar

%% --- COMPARAÇÃO: ONDA QUADRADA ---
figure(4); hold on;
colors = lines(length(Ns));             % Cores diferentes para cada N

for i = 1:length(Ns)
    N = Ns(i);
    y = zeros(size(t));

    for k = 1:2:(2*N-1)                 % Harmônicos ímpares
        y = y + (4/pi) * (1/k) * sin(2*pi*k*F*t);
    end

    plot(t, y, 'Color', colors(i,:), 'LineWidth', 1.2, ...
         'DisplayName', ['N = ' num2str(N)]);
end

title('Onda Quadrada - Aproximação com Diferentes Números de Harmônicos');
xlabel('Tempo (s)'); ylabel('Amplitude'); legend show; grid on;
xlim([0 total_time]);

% ANÁLISE:
%   - N=1: Apenas senoide (fundamental), longe da quadrada
%   - N=3: Começa a formar "degraus"
%   - N=15: Quase quadrada, mas com ripple
%   - N=50: Muito próxima, mas Gibbs persiste

%% --- COMPARAÇÃO: ONDA TRIANGULAR ---
figure(5); hold on;

for i = 1:length(Ns)
    N = Ns(i);
    y = zeros(size(t));

    for k = 1:2:(2*N-1)
        y = y + (8/pi^2) * ((-1)^((k-1)/2)) * (sin(2*pi*k*F*t)/(k^2));
    end

    plot(t, y, 'Color', colors(i,:), 'LineWidth', 1.2, ...
         'DisplayName', ['N = ' num2str(N)]);
end

title('Onda Triangular - Aproximação com Diferentes Números de Harmônicos');
xlabel('Tempo (s)'); ylabel('Amplitude'); legend show; grid on;
xlim([0 total_time]);

% ANÁLISE:
%   - N=1: Fundamental já se parece com triangular!
%   - N=3: Quase perfeita (1/k² decai rápido)
%   - N=15, N=50: Praticamente indistinguíveis

%% --- COMPARAÇÃO: ONDA DENTE DE SERRA ---
figure(6); hold on;

for i = 1:length(Ns)
    N = Ns(i);
    y = zeros(size(t));

    for k = 1:N                         % Todos os harmônicos
        y = y + (2/pi) * (sin(2*pi*k*F*t)/k);
    end

    plot(t, y, 'Color', colors(i,:), 'LineWidth', 1.2, ...
         'DisplayName', ['N = ' num2str(N)]);
end

title('Onda Dente de Serra - Aproximação com Diferentes Números de Harmônicos');
xlabel('Tempo (s)'); ylabel('Amplitude'); legend show; grid on;
xlim([0 total_time]);

%% ============================================================================
%% (c) ESPECTRO DE FREQUÊNCIAS (ANÁLISE COM FFT)
%% ============================================================================
% FFT (Fast Fourier Transform) → Algoritmo eficiente para DFT
%
% DFT (Discrete Fourier Transform):
%   X[k] = Σ x[n] * e^(-j2πkn/N)  (n = 0 a N-1)
%
% INTERPRETAÇÃO:
%   - Decompõe sinal em componentes senoidais
%   - X[k] = amplitude e fase do k-ésimo harmônico
%   - Frequências: f_k = k * (Fs/N)
%
% RESULTADO:
%   - Picos no espectro → harmônicos presentes
%   - Altura dos picos → amplitude dos harmônicos
%   - Posição dos picos → frequências (múltiplos de F)

%% --- Espectro da Onda Quadrada ---
plot_spectrum(func_square, Fs, 'Onda Quadrada', 7);

% ESPERADO:
%   - Picos em f = F, 3F, 5F, 7F, ... (20, 60, 100, 140 Hz, ...)
%   - Amplitude ∝ 1/k
%   - SEM picos em 2F, 4F, 6F (harmônicos pares ausentes)

%% --- Espectro da Onda Triangular ---
plot_spectrum(func_triangle, Fs, 'Onda Triangular', 8);

% ESPERADO:
%   - Picos em f = F, 3F, 5F, 7F, ... (só ímpares)
%   - Amplitude ∝ 1/k² (decai MUITO mais rápido)
%   - Alternância de fase (não visível em magnitude)

%% --- Espectro da Onda Dente de Serra ---
plot_spectrum(func_sawtooth, Fs, 'Onda Dente de Serra', 9);

% ESPERADO:
%   - Picos em f = F, 2F, 3F, 4F, ... (TODOS os harmônicos)
%   - Amplitude ∝ 1/k
%   - Mais "denso" que os outros espectros

%% ============================================================================
%% (d) SINAL COMPOSTO ESPECÍFICO
%% ============================================================================
% SINAL MULTI-TONAL:
%   x(t) = cos(2π·1000t) + (1/2)cos(2π·3000t) +
%          (1/4)cos(2π·4000t) + cos(2π·5000t)
%
% COMPOSIÇÃO:
%   - 4 componentes senoidais
%   - Frequências: 1 kHz, 3 kHz, 4 kHz, 5 kHz
%   - Amplitudes: 1, 0.5, 0.25, 1
%
% ANÁLISE DO ESPECTRO ESPERADO:
%   - 4 picos discretos
%   - Pico em 1 kHz: amplitude 1
%   - Pico em 3 kHz: amplitude 0.5
%   - Pico em 4 kHz: amplitude 0.25
%   - Pico em 5 kHz: amplitude 1

%% --- Parâmetros para o Sinal Composto ---
F0 = 1000;                              % Frequência base
T0 = 1/F0;                              % Período base
total_time_d = num_periods * T0;        % Tempo de simulação
t_d = 0:Ts:total_time_d;                % Vetor de tempo

%% --- Definição do Sinal x(t) ---
x = cos(2*pi*1000*t_d) + ...
    0.5*cos(2*pi*3000*t_d) + ...
    0.25*cos(2*pi*4000*t_d) + ...
    cos(2*pi*5000*t_d);

%% --- Gráfico Temporal do Sinal x(t) ---
figure(10);
plot(t_d, x, 'LineWidth', 1.5);
title('Sinal x(t) no Domínio do Tempo (Composto de 4 Senoides)');
xlabel('Tempo (s)');
ylabel('Amplitude');
grid on;
xlim([0 total_time_d]);

% OBSERVAÇÃO: Padrão complexo resultante da interferência das 4 senoides

%% --- Espectro de Frequências do Sinal x(t) ---
plot_spectrum(x, Fs, 'Sinal x(t) - Multi-Tonal', 11);

% RESULTADO:
%   - 4 picos nítidos em 1k, 3k, 4k, 5k Hz
%   - Alturas: 1, 0.5, 0.25, 1 (exatamente como especificado!)
%   - FFT "decompôs" o sinal nas componentes originais

%% ============================================================================
%% ANÁLISE DOS RESULTADOS E CONCLUSÕES
%% ============================================================================
fprintf('\n=== RESUMO: SÉRIE DE FOURIER E ANÁLISE ESPECTRAL ===\n\n');

fprintf('SÍNTESE DE FORMAS DE ONDA:\n');
fprintf('  • Onda Quadrada:   Harmônicos ímpares, decai 1/k (lenta)\n');
fprintf('  • Onda Triangular: Harmônicos ímpares, decai 1/k² (rápida)\n');
fprintf('  • Onda Dente Serra: Todos harmônicos, decai 1/k\n\n');

fprintf('CONVERGÊNCIA:\n');
fprintf('  • Mais harmônicos → melhor aproximação\n');
fprintf('  • Decaimento 1/k²  → converge mais rápido que 1/k\n');
fprintf('  • Fenômeno de Gibbs: ~9%% overshoot em descontinuidades\n\n');

fprintf('ANÁLISE ESPECTRAL (FFT):\n');
fprintf('  • Picos = harmônicos presentes\n');
fprintf('  • Posição = frequência (múltiplos de F)\n');
fprintf('  • Altura = amplitude do harmônico\n');
fprintf('  • Resolução: Δf = Fs/N (quanto maior N, melhor resolução)\n\n');

fprintf('ESPECTROS OBTIDOS:\n');
fprintf('  • Quadrada:   Picos em F, 3F, 5F, ... (só ímpares)\n');
fprintf('  • Triangular: Picos em F, 3F, 5F, ... com decaimento rápido\n');
fprintf('  • Dente Serra: Picos em F, 2F, 3F, ... (todos)\n');
fprintf('  • Sinal (d):   Picos em 1k, 3k, 4k, 5k Hz\n\n');

fprintf('APLICAÇÕES PRÁTICAS:\n');
fprintf('  • Análise de áudio: identificar notas musicais\n');
fprintf('  • Processamento de sinais: filtrar frequências\n');
fprintf('  • Comunicações: multiplexação em frequência (FDM)\n');
fprintf('  • Compressão: remover harmônicos de baixa energia\n');
fprintf('====================================================\n\n');

%% ============================================================================
%% FIM DO LABORATÓRIO 4
%% ============================================================================
% CONCEITOS APRENDIDOS:
% ✓ Série de Fourier: decomposição em harmônicos
% ✓ Síntese: construir formas de onda a partir de senoides
% ✓ Análise: extrair espectro com FFT
% ✓ Convergência: efeito do número de harmônicos
% ✓ Fenômeno de Gibbs
% ✓ Espectro unilateral vs bilateral
% ✓ Interpretação de espectros de amplitude
%
% PREPARAÇÃO PARA O EXAME:
% - Saber sintetizar formas de onda (fórmulas decoradas!)
% - Identificar harmônicos presentes (ímpares vs todos)
% - Calcular espectro com FFT e interpretar picos
% - Entender normalização e conversão uni/bilateral
%% ============================================================================
