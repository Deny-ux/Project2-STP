%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STP - Projekt 2 - dane nr 13
% Autor - Denys Fokashchuk
% Zadanie 3.a - Wyznaczenie nastaw ciągłego i dyskretnego regulatora PID
%
% UWAGA!
% Przed włączeniem skryptu należy uruchomić skrypt zad1.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long;
close all;

% liczba próbek
k_count = 200;

% wartość zadana - symulacja skoku jednostkowego
y_zad = zeros(1,k_count);
y_zad(13:k_count) = 1;

% wartości wejścia, wyjścia, błędu odpowiednio
u=zeros(1,k_count);
y=zeros(1,k_count);
e=zeros(1,k_count);

% wzmocnienie
K_reg = 0.2629;

% początkowy indeks k równa się 13, ponieważ od tego momentu
% następuje skok jednostkowy
for k=13:k_count
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    e(k) = y_zad(k) - y(k);
    u(k) = K_reg*e(k);
end

% Rysowanie wykresu
t = linspace(1,k_count,k_count);
hold on;
grid minor;
stairs(t, y_zad, 'r','LineWidth', 1.25);
stairs(t, y, 'b','LineWidth', 1.25);
title(sprintf('Wynik eksperymentu Zieglera-Nicholsa, K=%g', K_reg));
legend('y_{zad}[k]', 'y[k]', 'Location', 'southeast');
xlabel('Próbki, k');
ylabel('Wartości sygnałów');
hold off;

% Zapisywanie wykresu do pliku
saveas(gcf, './images/zad3_ZN.png', 'png')

Tk = 20.5;
Tp = 0.5;

% parametry ciągłego regulatora PID
Kp = K_reg*0.6;
Ti = 0.5*Tk;
Td = 0.12*Tk;

% parametry dyskretnego regulatora PID
r0 = Kp*(1+(Tp/(2*Ti)) + (Td/Tp));
r1 = Kp*((Tp/(2*Ti)) -2 *(Td/Tp) -1);
r2 = Kp*Td/Tp;

% Wyświetlanie wyników w konsoli
disp('Nastawy regulatora uzyskanego za pomocą eksperymentu Z-N:')
disp('Ciągłego:')
fprintf('Wartość Kp:\t %.5f\n', Kp);
fprintf('Wartość Ti:\t %.2f\n', Ti);
fprintf('Wartość Td:\t %.2f\n\n', Td);
disp('Dyskretnego:')
fprintf('Wartość r0:\t %.5f\n', r0);
fprintf('Wartość r1:\t %.5f\n', r1);
fprintf('Wartość r2:\t %.5f\n', r2);