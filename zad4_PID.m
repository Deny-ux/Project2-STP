%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STP - Projekt 2 - dane nr 13
% Autor - Denys Fokashchuk
% Zadanie 4.a - Symulacja algorytmu PID
% 
% UWAGA!
% Przed włączeniem skryptu należy uruchomić skrypt zad1.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;

k_count = 1000;

y_zad = zeros(1,k_count);
y_zad(13:k_count) = 1;
y=zeros(1,k_count);
u=zeros(1,k_count);
e=zeros(1,k_count);


Tk = 20.5;
Tp = 0.5;

% Parametry PID uzyskane za pomocą metody Zieglera–Nicholsa
Kp = 0.15774;
Ti =  10.25;
Td = 2.46;

r0 = Kp*(1 + Tp/(2*Ti) + Td/Tp);
r1 = Kp*(Tp/(2*Ti) - 2*Td/Tp - 1);
r2 = Kp*Td/Tp;


disp('Nastawy regulatora uzyskanego za pomocą eksperymentu Z-N:')
disp('Ciągłego:')
fprintf('Wartość Kp:\t %.5f\n', Kp);
fprintf('Wartość Ti:\t %.2f\n', Ti);
fprintf('Wartość Td:\t %.2f\n\n', Td);
disp('Dyskretnego:')
fprintf('Wartość r0:\t %.5f\n', r0);
fprintf('Wartość r1:\t %.5f\n', r1);
fprintf('Wartość r2:\t %.5f\n', r2);
fprintf('------------------------------\n')

for k=13:k_count
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    e(k) = y_zad(k) - y(k);
    u(k) = u(k-1) + r0*e(k) + r1*e(k) +r2*e(k);
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
title('Regulator uzyskany za pomocą eksperymentu Z-N');
hold off;
% Zapisywanie wykresu do pliku
saveas(gcf, './images/zad4_PID_ZN.png', 'png')


% Niżej znajduje się moja próba dostrojenia regulatora PID

% Dostrojone parametry PID
Kp = 0.09;
Ti =  18;
Td = 0.7;

r0 = Kp*(1 + Tp/(2*Ti) + Td/Tp);
r1 = Kp*(Tp/(2*Ti) - 2*Td/Tp - 1);
r2 = Kp*Td/Tp;

y_zad = zeros(1,k_count);
y_zad(13:k_count) = 1;
y=zeros(1,k_count);
u=zeros(1,k_count);
e=zeros(1,k_count);

for k=13:k_count
    y(k)=b1*u(k-11)+b0*u(k-12)-a1*y(k-1)-a0*y(k-2);
    e(k) = y_zad(k) - y(k);
    u(k) = u(k-1) + r0*e(k) + r1*e(k) +r2*e(k);
end

disp('Nastawy poprawionego regulatora:')
disp('Ciągłego:')
fprintf('Wartość Kp:\t %g\n', Kp);
fprintf('Wartość Ti:\t %g\n', Ti);
fprintf('Wartość Td:\t %g\n\n', Td);
disp('Dyskretnego:')
fprintf('Wartość r0:\t %.5f\n', r0);
fprintf('Wartość r1:\t %.5f\n', r1);
fprintf('Wartość r2:\t %.5f\n', r2);

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
title('Regulator uzyskany za pomocą ręcznego dostrojenia');
% title(sprintf('Kp=%.5f, Ti=%.5f, Td=%.5f', Kp, Ti, Td));
hold off;
saveas(gcf, './images/zad4_PID_dostrojony.png', 'png')
