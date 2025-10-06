%% ============================================================================
%% LABORATÓRIO 3 - EXERCÍCIO 4c: IMPLEMENTAÇÃO EM TEMPO REAL
%% ============================================================================
% Disciplina: Processamento Digital de Sinais
% Professor: Marcelo Eduardo Pellenz
%
% OBJETIVO:
% Implementar manualmente a equação de diferenças do sistema:
%   y[n] = x[n] + y[n-1] - 0.9*y[n-2]
%
% DIFERENÇA DO filter():
%   - filter() processa vetores completos
%   - Este script processa amostra-por-amostra (TEMPO REAL)
%
% CONCEITO DE IMPLEMENTAÇÃO EM TEMPO REAL:
%   1. Usuário fornece x[n] (valor atual da entrada)
%   2. Sistema usa memória: y[n-1] e y[n-2] (saídas anteriores)
%   3. Calcula y[n] usando a equação
%   4. Atualiza memória: y[n-2] ← y[n-1], y[n-1] ← y[n]
%   5. Repete para próxima amostra
%
% VARIÁVEIS DE ESTADO (Memória):
%   y1 = y[n-1]  (saída anterior, atraso de 1)
%   y2 = y[n-2]  (saída antes da anterior, atraso de 2)
%% ============================================================================

clc; clear;

%% --- APRESENTAÇÃO ---
fprintf('\n========================================\n');
fprintf('  FILTRO RECURSIVO EM TEMPO REAL\n');
fprintf('========================================\n');
fprintf('Sistema: y[n] = x[n] + y[n-1] - 0.9*y[n-2]\n\n');
fprintf('Você fornecerá 10 amostras de entrada x[n]\n');
fprintf('O sistema calculará a saída y[n] em tempo real.\n');
fprintf('========================================\n\n');

%% --- INICIALIZAÇÃO ---
n = 0;      % Contador de amostras
y1 = 0;     % y[n-1] inicial (assumindo repouso)
y2 = 0;     % y[n-2] inicial (assumindo repouso)

% CONDIÇÕES INICIAIS:
%   - Sistema começa em REPOUSO (y[-1] = y[-2] = 0)
%   - Primeira amostra: y[0] = x[0] + 0 - 0 = x[0]

%% --- LOOP DE PROCESSAMENTO EM TEMPO REAL ---
while n < 10
    % ENTRADA: Solicita valor atual x[n]
    x = input('Digite a amostra x[n]: ');

    % PROCESSAMENTO: Calcula y[n] usando equação de diferenças
    y = x + y1 - 0.9*y2;

    % EXPLICAÇÃO DO CÁLCULO:
    % y[n]   = x[n]  (entrada atual)
    %        + y[n-1] (saída anterior, armazenada em y1)
    %        - 0.9*y[n-2] (saída 2 passos atrás, armazenada em y2)

    % ATUALIZAÇÃO DA MEMÓRIA (shift de registros):
    y2 = y1;    % O que era y[n-1] agora é y[n-2]
    y1 = y;     % O valor atual y[n] agora é y[n-1] para próxima iteração

    % INCREMENTO DO CONTADOR
    n = n + 1;

    % SAÍDA: Exibe resultado
    fprintf('  → y[%d] = %.4f\n\n', n-1, y);
end

%% --- FINALIZAÇÃO ---
fprintf('========================================\n');
fprintf('  Processamento Concluído!\n');
fprintf('========================================\n\n');

%% ============================================================================
%% EXEMPLO DE EXECUÇÃO (Para Estudo):
%% ============================================================================
% ENTRADA: x = [1, 0, 0, 0, 0, 0, 0, 0, 0, 0] (Impulso)
%
% CÁLCULO PASSO-A-PASSO:
%
% n=0: x[0]=1, y1=0, y2=0
%      y[0] = 1 + 0 - 0.9*0 = 1
%      y2=0, y1=1
%
% n=1: x[1]=0, y1=1, y2=0
%      y[1] = 0 + 1 - 0.9*0 = 1
%      y2=1, y1=1
%
% n=2: x[2]=0, y1=1, y2=1
%      y[2] = 0 + 1 - 0.9*1 = 0.1
%      y2=1, y1=0.1
%
% n=3: x[3]=0, y1=0.1, y2=1
%      y[3] = 0 + 0.1 - 0.9*1 = -0.8
%      y2=0.1, y1=-0.8
%
% (continua oscilando e decaindo...)
%
% COMPARAÇÃO COM h[n] do Ex 4a:
%   - Esta é exatamente a resposta ao impulso!
%   - Se x = impulso → y = h[n]
%% ============================================================================

%% ============================================================================
%% DIAGRAMA DE FLUXO DE DADOS:
%% ============================================================================
%         Iteração n:
%         ┌─────────────────┐
%         │ Entrada x[n]    │
%         └────────┬────────┘
%                  │
%                  ↓
%         ┌─────────────────────────┐
%         │  y = x + y1 - 0.9*y2    │  ← EQUAÇÃO
%         └────────┬────────────────┘
%                  │
%         ┌────────┴────────┐
%         │                 │
%         ↓                 ↓
%    ┌─────────┐      ┌─────────────┐
%    │ y2 ← y1 │      │ Saída y[n]  │
%    └────┬────┘      └─────────────┘
%         │
%         ↓
%    ┌─────────┐
%    │ y1 ← y  │
%    └─────────┘
%         │
%         ↓
%   (Próxima iteração)
%% ============================================================================

%% ============================================================================
%% EXERCÍCIO ADICIONAL (Para Praticar):
%% ============================================================================
% Modifique o código para implementar OUTROS sistemas:
%
% 1) Média móvel de 3 pontos:
%    y[n] = (1/3)*[x[n] + x[n-1] + x[n-2]]
%    (Precisa armazenar x1 e x2 em vez de y1 e y2)
%
% 2) Filtro de primeira ordem:
%    y[n] = 0.9*y[n-1] + 0.1*x[n]
%    (Só precisa de y1, não precisa de y2)
%
% 3) Sistema com entrada e saída atrasadas:
%    y[n] = 0.5*x[n] + 0.3*x[n-1] + 0.8*y[n-1]
%    (Precisa armazenar x1 E y1)
%% ============================================================================
