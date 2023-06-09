%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STP - Projekt 2 - dane nr 13
% Autor - Denys Fokashchuk
% Zadanie 4.b - Symulacja algorytmu DMC
% 
% UWAGA!
% Przed włączeniem skryptu należy uruchomić skrypt zad1.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k_count = 500;

% Dane regulatora
% N = 50;
% Nu = 3;
N = 20;
Nu = 2;
lambda = 0.2;
D = 70;

% wektor współczynników odpowiedzi skokowej
S = step(Gz, 0:Tp:D*2);

y_zad = zeros(1,k_count);
y_zad(D:k_count) = 1;
y=zeros(1,k_count);
u=zeros(1,k_count);

% Wyznaczenie macierzy M
M = zeros(N, Nu);
for i=1:N
    for j=1:Nu
        if i >= j
            M(i+j-1,j) = S(i);
        end
    end
end
M = M(1:N, 1:Nu);

% Wyznaczenie macierzy Mp
Mp = zeros(N,D-1);
for i=1:N
    for j=1:(D-1)
        Mp(i,j) = S(i+j) - S(j);
    end
end

% Wyznaczenie wektora K
K = (M'*M + lambda*eye(Nu))^-1 * M';

for k=D+1:k_count
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);

    % wektor przyrostów sterowań
    dUp = zeros(D-1, 1);
    for i = 1:D-1
        dUp(i) = u(k-i) - u(k - i -1);
    end

    % składowa wsobodna wyjścia
    yok = repmat(y(k), N,1) + Mp*dUp;
   
    % wektor optymalnych przyrostów sygnału 
    % sterujcego na horyzoncie sterowania
    dUk = K*(repmat(y_zad(k), N, 1) - yok);
    u(k) = u(k-1) + dUk(1);
end

% Rysowanie wykresów
figure;
t = linspace(1,k_count,k_count);
hold on;
plot(t, y_zad, 'r', 'LineWidth', 1.25);
stairs(t, u, 'g', 'LineWidth', 1.25);
stairs(t, y, 'b', 'LineWidth', 1.25);
grid minor;
legend('y_{zad}[k]', 'u[k]', 'y[k]');
xlabel('Próbki dyskretne, k');
ylabel('Wartości sygnałów');
% title('Regulator DMC');
title(sprintf('Regulator DMC: N_{u}=%d, N=%d, D=%d, λ=%g',Nu, N, D, lambda))
hold off;

% zapisywanie wykresów
% saveas(gcf, sprintf('./images/zad5_b_n_%d.png', N))
% saveas(gcf, sprintf('./images/zad5c/zad5_nu_%d.png', Nu))
saveas(gcf, sprintf('./images/zad5d/zad5_lambda_%g.png', lambda))