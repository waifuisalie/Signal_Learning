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


