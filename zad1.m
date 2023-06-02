%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STP - Projekt 2 - dane nr 13
% Autor - Denys Fokashchuk
% Zadanie 1. - wyznaczenie transmitancji dyskretnej
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

format long;
clear all;
close all;

% Dane dla mojego wariantu
K0 = 7.7;
T0 = 5;
T1 = 2.17;
T2 = 4.4;

% okres próbkowania
Tp = 0.5;

% Transmitancja ciągła
Gs = (K0 * exp(-tf('s')*T0))/((T1*tf('s') + 1)*(T2*tf('s') +1));

% Wyznaczenie i wyświetlenie w konsoli transmitancji dyskretnej
Gz = c2d(Gs, Tp, 'zoh')
    
% czas symulacji
symulation_time = 40;

% zmienna niezbędna do rysowania wykresu
t = linspace(0, symulation_time, symulation_time/Tp + 1);

% Wartości odpowiedzi skokowej dla transmitancji ciągłej i dyskretnej
Gs_data_plot = step(Gs,  t);
Gz_data_plot = step(Gz, t);

% Rysowanie wykresów
plot(t, Gs_data_plot, 'LineWidth', 1.2);
hold on;
grid on;
stairs(t, Gz_data_plot, 'LineWidth', 1.2);
legend('Model ciągły', 'Model dyskretny', 'Location', 'southeast');
title('Odpowiedzi skokowe transmitancji ciągłej i dyskretnej');
xlabel('Czas, t');
ylabel('Wyjście modelu, y');
hold off;

